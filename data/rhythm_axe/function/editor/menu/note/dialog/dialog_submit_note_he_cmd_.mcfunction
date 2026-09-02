#arg:he_cur,he_cmd,he_spawn,he_tick,he_bad,he_good_early,he_perfect_early,he_perfect,he_perfect_late,he_good_late,he_miss,he_damage
# 写入第 $(he_cur) 条指令的 command 与 10 个启用状态（he_cur 与 he_* 来自 prop，由第一步传入）
$data modify storage rhythm_axe:maps.editor editing.he_events[$(he_cur)] merge value {command:'$(he_cmd)',enabled:{spawn:$(he_spawn),tick:$(he_tick),bad:$(he_bad),good_early:$(he_good_early),perfect_early:$(he_perfect_early),perfect:$(he_perfect),perfect_late:$(he_perfect_late),good_late:$(he_good_late),miss:$(he_miss),damage:$(he_damage)}}
data remove storage rhythm_axe:prop he_cur
data remove storage rhythm_axe:prop he_cmd
data remove storage rhythm_axe:prop he_spawn
data remove storage rhythm_axe:prop he_tick
data remove storage rhythm_axe:prop he_bad
data remove storage rhythm_axe:prop he_good_early
data remove storage rhythm_axe:prop he_perfect_early
data remove storage rhythm_axe:prop he_perfect
data remove storage rhythm_axe:prop he_perfect_late
data remove storage rhythm_axe:prop he_good_late
data remove storage rhythm_axe:prop he_miss
data remove storage rhythm_axe:prop he_damage
data remove storage rhythm_axe:maps.editor editing.he_cur
data modify storage rhythm_axe:maps.editor feedback set value "已修改击打特效指令（确认后生效）"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/note/hit_events/note_hit_events_panel