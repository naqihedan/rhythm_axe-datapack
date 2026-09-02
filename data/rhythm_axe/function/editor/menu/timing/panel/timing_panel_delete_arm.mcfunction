# 删除二次确认：第一次点击进入武装状态，面板底部变为【确认删除】
data modify storage rhythm_axe:maps.editor editing.delete_armed set value 1b
function rhythm_axe:editor/menu/timing/panel/timing_panel
