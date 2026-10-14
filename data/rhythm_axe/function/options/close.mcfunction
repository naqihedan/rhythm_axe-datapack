# 【已废弃 2026-10-14】原「收起设置面板」——页脚 16003 已改名【回到主菜单】并改走
#   options/back_to_main（清设置状态 + 复用 map_list/open 真正回到大厅总表）。
#   ⇒ 本函数**已无调用方**，保留仅作历史参考，勿再接线（它会清 map_list.open，与"回主菜单"语义相反）。
#
# —— 原说明 ——
# 收起设置面板：清状态 + 清屏（聊天栏面板是临时的，清掉后旧按钮不再响应）
function rhythm_axe:editor/menu/clear_lines
# 与谱面总表/房间页共用同一个菜单会话：收起即清 open（大厅/房间页的旧按钮也一并失效，符合"临时 UI"语义）
data remove storage rhythm_axe:map_list open
data remove storage rhythm_axe:map_list panel
# 收起时也清掉【恢复默认】待确认状态（下次打开重新开始）
data remove storage rhythm_axe:map_list reset_confirm
# 页号按玩家存 options_page 计分项：收起时把自己的页号归零（下次打开从第一页开始）
scoreboard players reset @s options_page
tellraw @s [{"text":"[设置] ","color":"gold"},{"text":"已收起设置面板","color":"gray"}]
