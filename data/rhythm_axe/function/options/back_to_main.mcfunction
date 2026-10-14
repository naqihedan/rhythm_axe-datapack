# 【回到主菜单】（设置面板页脚 16003，2026-10-14 由原【收起】改名并改语义）：
#   原【收起】只清会话 + 清屏（旧按钮失效，聊天栏留在原地）；现改为**真正回到大厅「谱面总表」**。
#   做法：清掉设置面板自己的状态（页号 / 待确认），再复用大厅入口 map_list/open
#   （它会设 map_list.open=1、panel=19、自检索引并渲染总表）。
#   ⚠️ 不要误清 map_list.open —— 大厅按钮（menu_click）依赖它「菜单开着」才会响应。
scoreboard players reset @s options_page
data remove storage rhythm_axe:map_list reset_confirm
function rhythm_axe:map_list/open