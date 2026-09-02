# 回收站面板（current_panel=17）：遍历 trash[] 显示 {标题}-{作者}-{mapid}【还原】【彻底删除】
# 先清理旧复合结构（旧版本 trash.<mapid> 会让列表读取失败）
function rhythm_axe:editor/file/trash_migrate
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
data remove storage rhythm_axe:maps.editor trash_pending
data modify storage rhythm_axe:maps.editor current_panel set value 17
tellraw @s [{"text":"====回收站====","color":"gold","bold":true}]
# 先归零再计数：trash 不存在时 data get 失败不会覆盖残留值
scoreboard players set #temp editor 0
execute store result score #temp editor run data get storage rhythm_axe:maps trash
execute if score #temp editor matches ..0 run tellraw @s [{"text":"回收站为空","color":"gray","italic":true}]
scoreboard players set #trash_shown editor 0
data modify storage rhythm_axe:prop index set value 0
function rhythm_axe:editor/menu/trash/trash_panel_row with storage rhythm_axe:prop
data remove storage rhythm_axe:prop index
tellraw @s [{"text":"【返回】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 1"},"hover_event":{"action":"show_text","value":"返回主菜单"}}]
