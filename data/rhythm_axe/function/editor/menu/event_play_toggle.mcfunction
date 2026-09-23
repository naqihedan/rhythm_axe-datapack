# 主菜单【事件播放：开/关】（10701，行107 列01）：翻转 options.editor_play_events（0=不执行 1=执行）
# ★ 2026-09-23 合并开关：原来 editor_note_hitevents（音符击打事件）与本开关并存，现统一由本开关控制
#   = 1 时：试听经过事件点执行谱面事件（events[]），经过音符判定时刻执行该音符的击打事件（hit_events）
# 提示 + 刷新主菜单（本文件由 panel1 分支调用，@s = 触发点击的玩家）
scoreboard players set #ep_tmp editor 1
execute if score editor_play_events options matches 1 run scoreboard players set #ep_tmp editor 0
scoreboard players operation editor_play_events options = #ep_tmp editor
execute if score editor_play_events options matches 1 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"事件播放：开","color":"green"},{"text":"（经过事件点执行 events[] 指令，经过音符判定时刻执行 hit_events 击打事件）","color":"gray"}]
execute if score editor_play_events options matches 0 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"事件播放：关","color":"red"},{"text":"（只播音效/粒子，不执行谱面事件与音符击打事件）","color":"gray"}]
function rhythm_axe:editor/menu/main
