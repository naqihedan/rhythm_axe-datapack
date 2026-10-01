#arg:rank,name,score,score_color,rating,rating_color,del_val
# 排行榜单行输出：  [x]  #名次  玩家名  分数  评级
#   [x] 只在 map_list.lb_edit 开着（prop.show_del=1b）时输出 —— 默认隐藏，靠页脚【编辑成绩】切换
#   score_color = 这条成绩**当时**的血量百分比色（同结算界面上下边框）
#   rating / rating_color = 由 options 的 SS/S/A/B/C 评级线动态算出（见 lb/decorate）
# 两条 tellraw 二选一：避免把一个空片段宏注入进 JSON（拼出来的逗号会破坏整条 JSON）
$execute if data storage rhythm_axe:prop {show_del:1b} run tellraw @s [{"text":"  "},{"text":"[x]","color":"red","bold":true,"click_event":{"action":"run_command","command":"/trigger menu_click set $(del_val)"},"hover_event":{"action":"show_text","value":"删除 $(name) 的这份成绩（$(score)）"}},{"text":"  #$(rank) ","color":"gold"},{"text":"$(name)","color":"white"},{"text":"   ","color":"white"},{"text":"$(score)","color":"$(score_color)"},{"text":"  ","color":"white"},{"text":"$(rating)","color":"$(rating_color)","bold":true}]
$execute unless data storage rhythm_axe:prop {show_del:1b} run tellraw @s [{"text":"  #$(rank) ","color":"gold"},{"text":"$(name)","color":"white"},{"text":"   ","color":"white"},{"text":"$(score)","color":"$(score_color)"},{"text":"  ","color":"white"},{"text":"$(rating)","color":"$(rating_color)","bold":true}]
