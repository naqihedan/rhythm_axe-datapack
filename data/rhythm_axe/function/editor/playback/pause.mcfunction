# 暂停：停音乐、tick rate 回 20、播放头冻结（bossbar 保持显示，仅停止推进）
data modify storage rhythm_axe:maps.editor playing set value 0b
# ★ 试玩结束：视线/交互距离恢复原版 3.0（试玩期间的 4.5 由 visual/tick 每刻维持，见那里的说明）
execute as @a[tag=editor_active] run attribute @s entity_interaction_range base set 3.0
pausemusic @a[tag=editor_active]
tick rate 20
execute store result score #playhead editor run data get storage rhythm_axe:maps.editor playhead
# ★ 2026-09-20 暂停清理：已过判定位置且未判定的音符静默清掉（0/1/2 判据 = 寿命 < 0）
#   （暂停后时间冻结，它们既不会再被判定、也不会自己消失，会一直挂在判定位置上）
# ★ 2026-09-21 补：混凝土长条(3) 也归本机制 —— 尾端越过判定位置（局部 z ≥ 0）后清掉，判据见 prune_passed
execute as @e[tag=editor_note,type=item_display] run function rhythm_axe:editor/judge/prune_passed
# 暂停补亮橙光：若有音符正处于判定时刻（播放中判定只播音效不亮）→ 亮起提示
# 只亮不播（不调 trigger_，不推 seg、不重复播音效）
execute as @e[tag=editor_note,type=item_display] run function rhythm_axe:editor/visual/pause_glow_check
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][编辑器]","color":"gray"},{"text":" 已暂停","color":"yellow"}]
