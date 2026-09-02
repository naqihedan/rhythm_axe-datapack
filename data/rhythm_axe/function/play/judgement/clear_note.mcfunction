# 静默清除音符对（无反馈；@s = 交互实体）
# 用于木板出窗等无 miss 的清除：按 note_id 配对杀展示实体 + 判定区域 marker + 交互实体
# ★ 先用 note_id 配对打 tag，再 reset+kill：直接 reset 会清掉 note_id，导致后续 kill 配对失效（展示实体残留）
scoreboard players operation #nid play_state = @s note_id
# 清理该音符的 hit_events（判定反馈存储，M2-H）
execute store result storage rhythm_axe:runtime fb_nid int 1 run scoreboard players get #nid play_state
function rhythm_axe:play/feedback/remove_events with storage rhythm_axe:runtime
execute as @e[tag=note_display] if score @s note_id = #nid play_state run tag @s add note_to_clear
# 引导线消失规则（2026-08-29 修订）：
#   不再在前一个音符消失时立刻清掉引导线；改为一头连接当前音符、另一头从前一个音符判定位置逐渐缩短，
#   直到当前音符到达前一判定位置时完全消失。过程不需要检测前一个音符是否已消失。
#   因此这里只在正在判定/清理的当前音符本身需要清理时清掉发生关联的 guide；
#   若是前一个音符本身已消失，不触发强制清理，留给收缩逻辑自然结束。
execute as @e[type=item_display,tag=note_guide] if score @s note_guide_b = #nid play_state run tag @s add note_to_clear
execute as @e[type=marker,tag=note_c_zone] if score @s note_id = #nid play_state run tag @s add note_to_clear
execute as @e[type=marker,tag=note_c_zone_near] if score @s note_id = #nid play_state run tag @s add note_to_clear
execute as @e[type=marker,tag=note_glass_center] if score @s note_id = #nid play_state run tag @s add note_to_clear
tag @s add note_to_clear
# reset 清计分板分数（本版本实体删除不自动清分；note_id 也被清，但已用 tag 配对）
execute as @e[tag=note_to_clear] run scoreboard players reset @s
# kill 用 tag 配对
kill @e[tag=note_to_clear]
