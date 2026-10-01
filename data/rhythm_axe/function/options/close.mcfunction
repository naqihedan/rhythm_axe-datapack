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
