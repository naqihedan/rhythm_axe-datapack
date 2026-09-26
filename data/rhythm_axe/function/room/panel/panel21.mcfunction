# 面板 21：房间页（游玩名单；菜单系统页面）。规范 v2：
#   固定控件：12101 加入游玩 / 12102 退出游玩 / 12103 开始游戏 / 12104 返回谱面总表
# 入口：room/open（或 room/render）设 rhythm_axe:map_list.panel = 21。
# 本页没有动态行（名单是只读行、不带按钮）⇒ 号段只有这一行。
# 入口白名单守卫（两行：先提示再 return fail）
execute unless score #menu_value menu matches 12101..12104 run function rhythm_axe:map_list/wrong_panel
execute unless score #menu_value menu matches 12101..12104 run return fail

execute if score #menu_value menu matches 12101 run function rhythm_axe:room/join
execute if score #menu_value menu matches 12102 run function rhythm_axe:room/leave
execute if score #menu_value menu matches 12103 run function rhythm_axe:room/start with storage rhythm_axe:map_list
execute if score #menu_value menu matches 12104 run function rhythm_axe:room/back
