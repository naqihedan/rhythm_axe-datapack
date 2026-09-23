# 主菜单【音符聊天反馈：开/关】（10702，行107 列02）：翻转 options.feedback_chat
# ★ 与游玩共用同一个全局开关：编辑器真实判定的文字反馈在 editor/judge/feedback_text 里读它
#   （0=判定等级不显示在聊天栏 1=显示）
scoreboard players set #nf_tmp editor 1
execute if score feedback_chat options matches 1 run scoreboard players set #nf_tmp editor 0
scoreboard players operation feedback_chat options = #nf_tmp editor
execute if score feedback_chat options matches 1 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"音符聊天反馈：开","color":"green"},{"text":"（判定等级 Bad/Good/Perfect/Miss 显示在聊天栏）","color":"gray"}]
execute if score feedback_chat options matches 0 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"音符聊天反馈：关","color":"red"},{"text":"（判定等级不再显示在聊天栏）","color":"gray"}]
function rhythm_axe:editor/menu/main
