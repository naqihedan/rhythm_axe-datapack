# 取消批量编辑：丢弃暂存并返回来源面板（从哪来回哪去）
scoreboard players operation #from editor = #batch_from editor
data remove storage rhythm_axe:maps.editor editing
function rhythm_axe:editor/menu/note/panel/note_panel_return
