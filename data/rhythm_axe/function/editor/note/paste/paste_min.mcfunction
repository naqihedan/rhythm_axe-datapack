#arg:paste_index
# 遍历剪贴板音符更新最小 time；遍历完转偏移计算
$execute unless data storage rhythm_axe:maps.editor clipboard.notes[$(paste_index)] run function rhythm_axe:editor/note/paste/paste_offset_done
# ★ 终止分支必须 return 0（否则 paste_offset_done 后继续执行 → 游标+1 → 无限递归 → 200000 超限）
$execute unless data storage rhythm_axe:maps.editor clipboard.notes[$(paste_index)] run return 0
$execute store result score #paste_time editor run data get storage rhythm_axe:maps.editor clipboard.notes[$(paste_index)].time
execute if score #paste_time editor < #min_time editor run scoreboard players operation #min_time editor = #paste_time editor
execute store result score #paste_count editor run data get storage rhythm_axe:prop paste_index
scoreboard players add #paste_count editor 1
execute store result storage rhythm_axe:prop paste_index int 1 run scoreboard players get #paste_count editor
function rhythm_axe:editor/note/paste/paste_min with storage rhythm_axe:prop
