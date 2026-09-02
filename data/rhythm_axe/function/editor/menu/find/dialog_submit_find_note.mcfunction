#arg:value
# 查找音符提交：按 id 遍历输出结果
$scoreboard players set #target_id editor $(value)
function rhythm_axe:editor/menu/find/find_note_prep
data remove storage rhythm_axe:maps.editor editing
