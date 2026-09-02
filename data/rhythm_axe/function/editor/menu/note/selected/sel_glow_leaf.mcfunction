#arg:glow_idx
# 对 selection[$(glow_idx)] 对应的音符补黄光（复用 select_mark_glow）
$execute unless data storage rhythm_axe:maps.editor selection[$(glow_idx)] run return 0
$execute store result storage rhythm_axe:prop nid int 1 run data get storage rhythm_axe:maps.editor selection[$(glow_idx)]
function rhythm_axe:editor/tool/select/select_mark_glow with storage rhythm_axe:prop
# ★ refresh 整体重建会丢 editor_note_selected 标签 → 右击取消选中在 exec 的标签检查处失败，
#   此处重建后重打标签（@s=玩家；用 prop.nid 遍历交互实体按 note_id 匹配）
execute store result score #sel_nid editor run data get storage rhythm_axe:prop nid
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #sel_nid editor run tag @s add editor_note_selected
scoreboard players reset #sel_nid editor
data remove storage rhythm_axe:prop nid
