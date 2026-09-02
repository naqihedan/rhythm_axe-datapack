# 取消音符面板：丢弃暂存 editing，返回来源面板（10 活跃列表 / 18 已选定列表）
execute store result score #from editor run data get storage rhythm_axe:maps.editor editing.panel_from
data remove storage rhythm_axe:maps.editor editing
function rhythm_axe:editor/menu/note/panel/note_panel_return
