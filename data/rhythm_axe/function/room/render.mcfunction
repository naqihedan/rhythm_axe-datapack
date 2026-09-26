# 房间页渲染（@s = 接收者）：页头（谱面标题 - 作者）→ 名单 → 页脚（按钮 + n/x人）
#   名单分两段：已加入（✔ 绿）/ 未加入（✘ 灰）—— 都在页面上，便于房主知道还有谁能来。
#   名字用 {"selector":"@s"} 输出：把成员当命令上下文（execute as <成员> run tellraw <接收者>）即可拿显示名，无需宏。
data modify storage rhythm_axe:map_list panel set value 21
scoreboard players enable @s menu_click
# ★ 2026-09-26 用户定：**不输出十行换行**（不清屏）—— 房间页要广播给所有人，不能刷掉别人聊天栏里的内容
# 页头（宏叶子读 map_list.room_mapid → maps.<id>.title/artist，同时算好 #rm_x = player_count）
function rhythm_axe:room/head_line with storage rhythm_axe:map_list
# 名单：接收者用 room_viewer 标记（内层 as 会顶掉 @s，靠标记找回「看的人」）
tag @s add room_viewer
execute as @a[team=player] run function rhythm_axe:room/row_player
execute as @a[team=!player] run function rhythm_axe:room/row_observer
tag @s remove room_viewer
# 页脚：n = 在线成员数，x = 谱面 player_count（不足黄 / 正好绿 / 超过红）
scoreboard players set #rm_n menu 0
execute store result score #rm_n menu if entity @a[team=player]
execute if score #rm_n menu < #rm_x menu run function rhythm_axe:room/footer_line {cnt_color:"yellow"}
execute if score #rm_n menu = #rm_x menu run function rhythm_axe:room/footer_line {cnt_color:"green"}
execute if score #rm_n menu > #rm_x menu run function rhythm_axe:room/footer_line {cnt_color:"red"}
