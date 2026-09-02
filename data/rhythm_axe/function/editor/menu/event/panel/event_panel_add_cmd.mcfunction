# 在末尾追加一条空指令（只改暂存 editing.temp）
data modify storage rhythm_axe:maps.editor editing.temp.commands append value ""
function rhythm_axe:editor/menu/event/panel/event_panel
