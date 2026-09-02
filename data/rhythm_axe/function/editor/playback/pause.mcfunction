# 暂停：停音乐、tick rate 回 20、播放头冻结（bossbar 保持显示，仅停止推进）
data modify storage rhythm_axe:maps.editor playing set value 0b
pausemusic @s
tick rate 20
execute store result score #playhead editor run data get storage rhythm_axe:maps.editor playhead
# 暂停补亮橙光：若有音符正处于判定时刻（播放中判定只播音效不亮）→ 亮起提示
# 只亮不播（不调 trigger_，不推 seg、不重复播音效）
execute as @e[tag=editor_note,type=item_display] run function rhythm_axe:editor/visual/pause_glow_check
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][编辑器]","color":"gray"},{"text":" 已暂停","color":"yellow"}]
