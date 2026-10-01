#arg:mapid
# 点某行行首的 ▶️/⏸️：**选中**这张谱面（全局共享，选中行会缩进）+ 切换**预览**
# · 点别的行 = 停旧预览、选中新的并开始预览
# · 点当前选中行的 ⏸️ = 只停预览（仍然选中）
# 预览参数取自谱面：preview_start（从第几刻起播）/ preview_len（播多少刻），缺省 0 / 200
# 状态与音频都是**全局**的：一个人切歌，所有人下次刷新看到同一份选中，预览音也全员可听
# 先判「是不是同一张 + 正在预览」→ 是则这次点击 = 停止（判定必须在改写 sel 之前做）
scoreboard players set #prev_same menu 0
$execute if data storage rhythm_axe:map_list {sel:"$(mapid)"} if data storage rhythm_axe:map_list {prev:1b} run scoreboard players set #prev_same menu 1
$data modify storage rhythm_axe:map_list sel set value "$(mapid)"
# —— 取预览参数（读进 prop 交给 preview/start；宏参数只能“调用时解析”，故分两步）——
data remove storage rhythm_axe:prop music
data remove storage rhythm_axe:prop pv_start
data remove storage rhythm_axe:prop pv_len
$data modify storage rhythm_axe:prop music set from storage rhythm_axe:maps.$(mapid) music
$data modify storage rhythm_axe:prop pv_start set from storage rhythm_axe:maps.$(mapid) preview_start
$data modify storage rhythm_axe:prop pv_len set from storage rhythm_axe:maps.$(mapid) preview_len
execute unless data storage rhythm_axe:prop pv_start run data modify storage rhythm_axe:prop pv_start set value 0
execute unless data storage rhythm_axe:prop pv_len run data modify storage rhythm_axe:prop pv_len set value 200
execute if score #prev_same menu matches 1 run function rhythm_axe:map_list/preview/stop
# ⚠️ 有局在跑时不给预览：预览音全员可听，停的时候 /stopmusic @a 会把对局音乐一起停掉
execute if score #prev_same menu matches 0 if score is_running play_state matches 1 run tellraw @s [{"text":"[大厅] ","color":"gold"},{"text":"正在游玩中，暂不预览（避免打断对局音乐）","color":"gray"}]
execute if score #prev_same menu matches 0 unless score is_running play_state matches 1 run function rhythm_axe:map_list/preview/start
# 立刻重绘：点击者必刷，其它正在看总表的人也一起刷（共享大厅，见 map_list/sync_list）
function rhythm_axe:map_list/sync_list
data remove storage rhythm_axe:prop music
data remove storage rhythm_axe:prop pv_start
data remove storage rhythm_axe:prop pv_len
