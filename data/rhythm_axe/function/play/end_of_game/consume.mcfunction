# 结算界面聊天栏按钮的分发（@s = 点击者）——由 tick.mcfunction 检测 play_click 后调用
#   101 = 【重新开始】→ 用上一局的 mapid 重开（play/end_of_game/restart）
#   102 = 【返回选曲】→ 打开谱面总表（大厅）
# 三套点击通道完全分开：编辑器 editor_click / 菜单 menu_click / 游玩 play_click（各自的临时分数板）
# 临时分数用 play_state 板（游玩侧自己的板），名 #pc_value
execute store result score #pc_value play_state run scoreboard players get @s play_click
scoreboard players reset @s play_click
# 守卫：只有在「本局已结束」时才响应 —— 聊天栏里的旧结算行在游玩中依然可点（见《AI常见问题》）
execute if score is_running play_state matches 1 run tellraw @s [{"text":"[结算] ","color":"gold"},{"text":"本局还在进行中，先结束再来","color":"gray"}]
execute if score is_running play_state matches 1 run return fail
execute if score #pc_value play_state matches 101 run function rhythm_axe:play/end_of_game/restart
execute if score #pc_value play_state matches 102 run function rhythm_axe:map_list/open
