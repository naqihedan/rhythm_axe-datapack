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
# 生成标题组件 runtime.title_comp（JSON 组件串直接注入；裸纯文本合成字面组件；复合/列表走 nbt+interpret）
data remove storage rhythm_axe:prop title
data remove storage rhythm_axe:prop title_comp
data modify storage rhythm_axe:prop title set from storage rhythm_axe:runtime title
execute unless data storage rhythm_axe:prop title run data modify storage rhythm_axe:prop title set value "(无标题)"
execute if data storage rhythm_axe:prop {title:""} run data modify storage rhythm_axe:prop title set value "(无标题)"
data modify storage rhythm_axe:prop src set value "rhythm_axe:runtime"
execute if data storage rhythm_axe:prop title run function rhythm_axe:utilization/title_comp with storage rhythm_axe:prop
data modify storage rhythm_axe:runtime title_comp set from storage rhythm_axe:prop title_comp
data remove storage rhythm_axe:prop title
data remove storage rhythm_axe:prop title_comp
data remove storage rhythm_axe:prop src

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

# ★ 2026-09-05 跨刻排序：main_loop 不再在此直接 schedule。
#   init_game 里的 sort_notes 用 schedule 跨多刻对 notes 按 _birth 排序；
#   排序完成后由 sort_bucket_finish → sort_start_main 启动 main_loop。
#   （否则主循环会在音符还没排好序时就开始生成，游标推进错误。）
# schedule function rhythm_axe:play/main_loop 1t
