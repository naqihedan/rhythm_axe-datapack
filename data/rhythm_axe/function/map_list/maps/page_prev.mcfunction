# 总表上一页（11701）：**本玩家自己的**页号 -1，然后重绘
# 说明：页号存 menu_page 计分项（每人独立 ⇒ 别人翻页不影响我）；越界由 list_open 的钳制兜底（夹到 [0, 页数-1]）。
scoreboard players remove @s menu_page 1
function rhythm_axe:map_list/maps/list_open
