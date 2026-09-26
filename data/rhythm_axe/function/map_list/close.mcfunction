# 收起总表：清状态 + 清屏（聊天栏面板是临时的，清掉后旧按钮不再响应）
# 没有【关闭】按钮，本函数只被【游玩】/【编辑】复用（进游戏/编辑器前先收摊）
function rhythm_axe:editor/menu/clear_lines
data remove storage rhythm_axe:map_list open
data remove storage rhythm_axe:map_list panel
# 页码已改成按玩家（menu_page 计分项）：收起时把自己的页号归零（下次打开从第一页开始）
scoreboard players reset @s menu_page
data remove storage rhythm_axe:prop i
data remove storage rhythm_axe:prop row
data remove storage rhythm_axe:prop mapid
data remove storage rhythm_axe:prop title
data remove storage rhythm_axe:prop src
data remove storage rhythm_axe:prop artist
data remove storage rhythm_axe:prop title_comp
data remove storage rhythm_axe:prop play_val
data remove storage rhythm_axe:prop edit_val
tellraw @s [{"text":"[大厅] ","color":"gold"},{"text":"已收起谱面总表","color":"gray"}]
