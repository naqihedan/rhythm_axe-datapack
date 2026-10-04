#arg:mapid
# 谱面排行榜（聊天栏输出前 10 名）——由总表操作行的【🏆 排行榜】按钮触发（11903，作用于选中的谱面）
# 数据：rhythm_axe:scores.<玩家key>.<mapid> = {name:"..",score:N,health:P}；rhythm_axe:scores_index.<mapid> = ["key",...]
# 玩家 key = UUID 四个 int 拼串（原版拿不到 UUID 字符串，见 play/highscore/collect_ 顶部说明）
function rhythm_axe:editor/menu/clear_lines
data modify storage rhythm_axe:map_list panel set value 19
# 视图标记（共享大厅）：这个人现在在看排行榜（不再算“在看总表”，两者互斥）
# ⚠️ 预览音只发给 tag=maplist_view 的人：切榜单前先停掉自己那一份（不然响到播完）
execute if entity @s[tag=maplist_view] run stopmusic @s
tag @s add lb_view
tag @s remove maplist_view
# 标题 + 作者（title 复用 utilization/title_comp 归一化，和总表行同一套；artist=曲师 / charter=谱面作者）
data remove storage rhythm_axe:prop title
data remove storage rhythm_axe:prop artist
data remove storage rhythm_axe:prop charter
$data modify storage rhythm_axe:prop title set from storage rhythm_axe:maps.$(mapid) title
$data modify storage rhythm_axe:prop artist set from storage rhythm_axe:maps.$(mapid) artist
$data modify storage rhythm_axe:prop charter set from storage rhythm_axe:maps.$(mapid) charter
execute unless data storage rhythm_axe:prop title run data modify storage rhythm_axe:prop title set value "(无标题)"
execute if data storage rhythm_axe:prop {title:""} run data modify storage rhythm_axe:prop title set value "(无标题)"
execute unless data storage rhythm_axe:prop artist run data modify storage rhythm_axe:prop artist set value "(未知曲师)"
execute if data storage rhythm_axe:prop {artist:""} run data modify storage rhythm_axe:prop artist set value "(未知曲师)"
execute unless data storage rhythm_axe:prop charter run data modify storage rhythm_axe:prop charter set value "(未知作者)"
execute if data storage rhythm_axe:prop {charter:""} run data modify storage rhythm_axe:prop charter set value "(未知作者)"
$data modify storage rhythm_axe:prop src set value "rhythm_axe:maps.$(mapid)"
function rhythm_axe:utilization/title_comp with storage rhythm_axe:prop
tellraw @s [{"text":"==== 谱面排行榜 ====","color":"gold","bold":true}]
# 标题行：交给宏叶子原样注入 $(title_comp)（不能包 nbt+interpret，见 head.mcfunction 注释）
function rhythm_axe:map_list/lb/head with storage rhythm_axe:prop
# 渲染快照：本页每一行是谁（按名次顺序），[x] 删除按钮靠它回查
#   ⚠️ 用 set value [] 而不是 remove：out_b 的 append 要求父键已存在
data modify storage rhythm_axe:lb rows set value []
# 记住“当前排行榜是谁的” —— 【编辑成绩】按钮靠它重绘（prop.mapid 在本函数收尾就被清了）
$data modify storage rhythm_axe:map_list lb_mapid set value "$(mapid)"
# 是否显示 [x]：全局开关 map_list.lb_edit（缺省=隐藏，2026-10-01 用户定）
data modify storage rhythm_axe:prop show_del set value 0b
execute if data storage rhythm_axe:map_list {lb_edit:1b} run data modify storage rhythm_axe:prop show_del set value 1b
# 取榜单
function rhythm_axe:map_list/lb/prepare with storage rhythm_axe:prop
execute if score #lb_n menu matches 0 run tellraw @s [{"text":"（这张谱面还没有任何成绩：先在房间页加入游玩并打完一局）","color":"gray","italic":true}]
scoreboard players set #lb_rank menu 1
execute if score #lb_n menu matches 1.. run function rhythm_axe:map_list/lb/pass
execute if score #lb_total menu matches 11.. run tellraw @s [{"text":"（共 ","color":"dark_gray"},{"score":{"name":"#lb_total","objective":"menu"},"color":"dark_gray"},{"text":" 人，只显示前 10 名）","color":"dark_gray","italic":true}]
# 页脚：回谱面总表（11704）+ 【编辑成绩】开关（11705；默认隐藏 [x]，点一下开）
#   ⚠️ 这里不看 prop.mapid（已清）；重绘走 map_list.lb_mapid
execute if data storage rhythm_axe:map_list {lb_edit:1b} run tellraw @s [{"text":""},{"text":"【返回总表】","color":"aqua","click_event":{"action":"run_command","command":"/trigger menu_click set 11704"},"hover_event":{"action":"show_text","value":"回到谱面总表"}},{"text":"　 ","color":"aqua"},{"text":"【完成编辑】","color":"gold","click_event":{"action":"run_command","command":"/trigger menu_click set 11705"},"hover_event":{"action":"show_text","value":"隐藏每个名次行前面的 [x]"}}]
execute unless data storage rhythm_axe:map_list {lb_edit:1b} run tellraw @s [{"text":""},{"text":"【返回总表】","color":"aqua","click_event":{"action":"run_command","command":"/trigger menu_click set 11704"},"hover_event":{"action":"show_text","value":"回到谱面总表"}},{"text":"　 ","color":"aqua"},{"text":"【编辑成绩】","color":"gold","click_event":{"action":"run_command","command":"/trigger menu_click set 11705"},"hover_event":{"action":"show_text","value":"显示每个名次行前面的 [x]（删单项成绩）"}}]
# 清理临时键（prop.i / prop.mapid 由 panel19 收尾统一清）
# ⚠️ rhythm_axe:lb.rows（渲染快照）**不要清**：聊天栏里那些 [x] 按钮还要靠它回查是谁
data remove storage rhythm_axe:lb keys
data remove storage rhythm_axe:prop rank
data remove storage rhythm_axe:prop bi
data remove storage rhythm_axe:prop key
data remove storage rhythm_axe:prop name
data remove storage rhythm_axe:prop score
data remove storage rhythm_axe:prop health
data remove storage rhythm_axe:prop rating
data remove storage rhythm_axe:prop rating_color
data remove storage rhythm_axe:prop score_color
data remove storage rhythm_axe:prop del_val
data remove storage rhythm_axe:prop show_del
data remove storage rhythm_axe:prop title
data remove storage rhythm_axe:prop title_comp
data remove storage rhythm_axe:prop artist
data remove storage rhythm_axe:prop charter
data remove storage rhythm_axe:prop src
