# 开始游戏（宏参数 mapid）
# 把谱面读取成可玩形式并进入主循环
#arg: mapid

# 复制谱面到运行存储（运行期只读）
# 先清空 runtime 的谱面数据键（merge 不会删除源没有的旧键，避免残留）
# 用 if data 保护，键不存在时不报错
execute if data storage rhythm_axe:runtime notes run data remove storage rhythm_axe:runtime notes
execute if data storage rhythm_axe:runtime timing_points run data remove storage rhythm_axe:runtime timing_points
execute if data storage rhythm_axe:runtime events run data remove storage rhythm_axe:runtime events
# 其它根字段（id/title/.../teleport/spawn_pos 等）由 merge 覆盖，无需逐个清
$data modify storage rhythm_axe:runtime {} merge from storage rhythm_axe:maps.$(mapid)
$data modify storage rhythm_axe:runtime mapid set value "$(mapid)"
# ★ title 若为复合 {text:...}，宏 $(title) 传不了（bossbar/结算标题不显示）→ 清洗为字符串（与编辑器 main_header 一致；字符串组件则跳过）
execute if data storage rhythm_axe:runtime title.text run data modify storage rhythm_axe:runtime title set from storage rhythm_axe:runtime title.text

# 运行标记
scoreboard players set is_running play_state 1

# 玩家初始化
# 记录进入前游戏模式（结束游戏时还原；1.20.2+ 无法读玩家 NBT，改用 gamemode 选择器判断）
# 注意：main 可能由服务器/命令方块执行，@s 不一定是玩家 → 用 @a 判断
# 先清除旧值避免残留；模式数值：0=生存 1=创造 2=冒险 3=旁观
execute if data storage rhythm_axe:runtime prev_gamemode run data remove storage rhythm_axe:runtime prev_gamemode
execute if entity @a[gamemode=survival] run data modify storage rhythm_axe:runtime prev_gamemode set value 0
execute if entity @a[gamemode=creative] run data modify storage rhythm_axe:runtime prev_gamemode set value 1
execute if entity @a[gamemode=adventure] run data modify storage rhythm_axe:runtime prev_gamemode set value 2
execute if entity @a[gamemode=spectator] run data modify storage rhythm_axe:runtime prev_gamemode set value 3
execute unless data storage rhythm_axe:runtime prev_gamemode run data modify storage rhythm_axe:runtime prev_gamemode set value 2
gamemode adventure @a[gamemode=!adventure]
scoreboard players set #dbg play_state 3
effect give @a minecraft:instant_health 1 255 true
effect give @a minecraft:resistance 5 255 true
# 标记为游玩中（射线步进视线检测按此筛选玩家；结束游戏时移除）
tag @a add playing
# 激活唱片机点击 advancement（完整获得 → 触发器检测）
# 26.x 已验证：grant 整个激活后永久生效（即使 reward 里 revoke 整个，后续点击仍每次触发一次）
#   grant 时若玩家历史满足会立即触发一次 reward——无害（reward 只 revoke 不清 grant，不会循环）
advancement revoke @a only rhythm_axe:jukebox_right_click
advancement revoke @a only rhythm_axe:jukebox_left_click
advancement grant @a only rhythm_axe:jukebox_right_click
advancement grant @a only rhythm_axe:jukebox_left_click
# 若谱面 teleport 为真，传送到初始位置（spawn_x/y/z/yaw/pitch 标量；旧谱面缺字段时补 0）
execute store result score #tp_flag play_state run data get storage rhythm_axe:runtime teleport
execute if data storage rhythm_axe:runtime spawn_x run data modify storage rhythm_axe:runtime spawn_x set from storage rhythm_axe:runtime spawn_x
execute unless data storage rhythm_axe:runtime spawn_x run data modify storage rhythm_axe:runtime spawn_x set value 0.0d
execute if data storage rhythm_axe:runtime spawn_y run data modify storage rhythm_axe:runtime spawn_y set from storage rhythm_axe:runtime spawn_y
execute unless data storage rhythm_axe:runtime spawn_y run data modify storage rhythm_axe:runtime spawn_y set value 0.0d
execute if data storage rhythm_axe:runtime spawn_z run data modify storage rhythm_axe:runtime spawn_z set from storage rhythm_axe:runtime spawn_z
execute unless data storage rhythm_axe:runtime spawn_z run data modify storage rhythm_axe:runtime spawn_z set value 0.0d
execute unless data storage rhythm_axe:runtime spawn_yaw run data modify storage rhythm_axe:runtime spawn_yaw set value 0.0d
execute unless data storage rhythm_axe:runtime spawn_pitch run data modify storage rhythm_axe:runtime spawn_pitch set value 0.0d
execute if score #tp_flag play_state matches 1 run function rhythm_axe:play/start_of_game/tp_to_spawn with storage rhythm_axe:runtime
# 实体交互距离：游玩期间硬编码 4.5 格（玩家属性 entity_interaction_range，1.21.2+ 无前缀）
# 结束游戏恢复原版 3.0（end_of_game/end_of_game）
execute as @a run attribute @s entity_interaction_range base set 4.5

# 给予斧头（默认小木斧lv.1，可由谱面自定义）
scoreboard players set #dbg play_state 4
give @a minecraft:stick[\
    item_model="minecraft:wooden_axe",\
    can_break={\
    blocks:[note_block,birch_planks]},\
    item_name={"text":"小木斧lv.1","color":"green"},\
    max_stack_size=1,\
    unbreakable={},\
    tool={\
            can_destroy_blocks_in_creative:false,\
            default_mining_speed:2333.0,\
            rules:[{blocks:[note_block,birch_planks]}]\
         }\
] 1
# 读取 mods 计分板（玩家设置的 mod 开关）到 play_state 同名项（运行期判定系统读取）
#   auto = mods.auto（缺省 0 = 关闭自动模式）；mods 扩展项将来同样在此复制
scoreboard players operation auto play_state = auto mods
# 计分板初始化（含 time 起点计算）
scoreboard players set #dbg play_state 5
function rhythm_axe:play/init_game
scoreboard players set #dbg play_state 6

# 进入主循环（schedule 自循环）
# ★ 修复（2026-08-08 用户实测"前两个音符停出生位置"）：原本直接调用 main_loop → 第一批音符（time 起点）
#   与 start 初始化（gamemode/advancement/give 等）同一 tick 生成 → 客户端实体同步延迟 → 插值设置时
#   客户端还没收到实体的起点 transformation（wiki：实体首 tick 可能不渲染）→ 插值起点丢失 → 停出生位置。
#   改为 schedule 1t：第一批生成落在独立 tick，客户端有 1 tick 缓冲（生成 tick 结束后收到实体初始数据）。
schedule function rhythm_axe:play/main_loop 1t
