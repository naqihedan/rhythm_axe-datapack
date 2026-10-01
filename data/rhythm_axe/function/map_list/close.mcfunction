# 收起总表：清状态 + 清屏（聊天栏面板是临时的，清掉后旧按钮不再响应）
# 没有【关闭】按钮，本函数只被【游玩】/【编辑】复用（进游戏/编辑器前先收摊）
function rhythm_axe:map_list/view_clear
function rhythm_axe:editor/menu/clear_lines
# ★ 2026-10-01：收起 = 停掉曲目预览（全局状态），免得离开大厅后还在“预览中”
function rhythm_axe:map_list/preview/stop
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
data remove storage rhythm_axe:prop charter
data remove storage rhythm_axe:prop title_comp
data remove storage rhythm_axe:prop play_val
data remove storage rhythm_axe:prop edit_val
data remove storage rhythm_axe:prop lb_val
data remove storage rhythm_axe:prop ind
data remove storage rhythm_axe:prop pv_val
data remove storage rhythm_axe:prop pv_icon
tellraw @s [{"text":"[大厅] ","color":"gold"},{"text":"已收起谱面总表","color":"gray"}]
