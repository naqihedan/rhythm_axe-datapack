# 蹲下右键已选中音符：取消所有选中（清空 selection + 移除全部音符 selected），可撤销
#   selected 标记存音符元素（在工作副本快照里）→ 撤销 cursor-1 后 refresh 会从恢复的 selected 重建 selection
# 前置：@s = 玩家（editor_active）
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "取消所有选中音符"
function rhythm_axe:editor/menu/note/selected/sel_clear_all
function rhythm_axe:editor/file/commit
# 移除所有交互实体的选中 tag；高亮/selection 由 refresh 重建（无 selected 则不亮）
execute as @e[type=interaction,tag=editor_note] run tag @s remove editor_note_selected
function rhythm_axe:editor/refresh
scoreboard players add #content_ver editor 1
execute store result storage rhythm_axe:maps.editor content_ver int 1 run scoreboard players get #content_ver editor
data modify storage rhythm_axe:maps.editor feedback set value "已取消所有选中"
data remove storage rhythm_axe:maps.editor editing
# 取消所有选中后回到活跃音符列表（selection 已空）
function rhythm_axe:editor/menu/note/list/note_list_open
