# 清空全部选中（含视觉）：selection + 每个音符的 selected 标记 + 黄光 + 交互实体「已选中」标记 + #sel_count
# ★ 面板 10 的【取消选中】(11305) 与「时间范围选择」共用这一个函数 —— 不要再各写一遍
#   （需要重开列表的调用方自己再调 note_list_open；只要反馈的调用方调 show_feedback 即可）
function rhythm_axe:editor/menu/note/selected/sel_clear_all
scoreboard players set #sel_count editor 0
execute as @e[type=item_display,tag=editor_note] run data modify entity @s Glowing set value 0b
execute as @e[type=interaction,tag=editor_note] run tag @s remove editor_note_selected
