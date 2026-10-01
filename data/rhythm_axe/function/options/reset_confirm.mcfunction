# 【恢复默认】第一步（16004）：只**进入待确认状态**，不执行重置，然后重绘。
#   照编辑器「删除谱面」的做法：先记 pending 状态 → 渲染确认按钮 → 确认后才真正执行。
#   状态存在菜单会话 rhythm_axe:map_list.reset_confirm（与 open / panel 同一处；
#   打开面板与收起面板时都会清掉，避免残留）。
data modify storage rhythm_axe:map_list reset_confirm set value 1b
function rhythm_axe:options/render
