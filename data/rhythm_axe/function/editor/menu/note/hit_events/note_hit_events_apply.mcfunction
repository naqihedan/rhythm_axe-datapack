#arg:idx
# 对第 $(idx) 条指令执行开关操作（#he_off：1-10 开关；由 click 按 he_off 分支调用）
# 开关切换（spawn）
$execute if score #he_off editor matches 1 run execute if data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.spawn run data remove storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.spawn
$execute if score #he_off editor matches 1 run execute unless data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.spawn run data modify storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.spawn set value 1b
# 开关切换（tick）
$execute if score #he_off editor matches 10 run execute if data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.tick run data remove storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.tick
$execute if score #he_off editor matches 10 run execute unless data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.tick run data modify storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.tick set value 1b
# 开关切换（bad）
$execute if score #he_off editor matches 2 run execute if data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.bad run data remove storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.bad
$execute if score #he_off editor matches 2 run execute unless data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.bad run data modify storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.bad set value 1b
# 开关切换（good_early）
$execute if score #he_off editor matches 3 run execute if data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.good_early run data remove storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.good_early
$execute if score #he_off editor matches 3 run execute unless data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.good_early run data modify storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.good_early set value 1b
# 开关切换（perfect_early）
$execute if score #he_off editor matches 4 run execute if data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.perfect_early run data remove storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.perfect_early
$execute if score #he_off editor matches 4 run execute unless data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.perfect_early run data modify storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.perfect_early set value 1b
# 开关切换（perfect）
$execute if score #he_off editor matches 5 run execute if data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.perfect run data remove storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.perfect
$execute if score #he_off editor matches 5 run execute unless data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.perfect run data modify storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.perfect set value 1b
# 开关切换（perfect_late）
$execute if score #he_off editor matches 6 run execute if data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.perfect_late run data remove storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.perfect_late
$execute if score #he_off editor matches 6 run execute unless data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.perfect_late run data modify storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.perfect_late set value 1b
# 开关切换（good_late）
$execute if score #he_off editor matches 7 run execute if data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.good_late run data remove storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.good_late
$execute if score #he_off editor matches 7 run execute unless data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.good_late run data modify storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.good_late set value 1b
# 开关切换（miss）
$execute if score #he_off editor matches 8 run execute if data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.miss run data remove storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.miss
$execute if score #he_off editor matches 8 run execute unless data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.miss run data modify storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.miss set value 1b
# 开关切换（damage）
$execute if score #he_off editor matches 9 run execute if data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.damage run data remove storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.damage
$execute if score #he_off editor matches 9 run execute unless data storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.damage run data modify storage rhythm_axe:maps.editor editing.he_events[$(idx)].enabled.damage set value 1b
# 刷新面板（click 仅在 1-9 调用本函数）
function rhythm_axe:editor/menu/note/hit_events/note_hit_events_panel
