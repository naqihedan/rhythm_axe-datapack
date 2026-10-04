# 上移一行：点击值 = (1000+指令序号)×100 + 4 → 序号 = click/100 − 1000；目标 = 序号 − 1。
# 序号 0（最前）不能再上移 → 走面板 feedback 提示（纯文本）。
# ⚠️ #temp 会被 event_panel 内部改写（时间行），所以判定先算进专用 #mv_ok，之后守卫只用 #mv_ok。
scoreboard players operation #temp editor = #click_value editor
scoreboard players operation #temp editor /= 100 const
scoreboard players remove #temp editor 1000
scoreboard players operation #mv_j editor = #temp editor
scoreboard players remove #mv_j editor 1
scoreboard players set #mv_ok editor 1
execute if score #temp editor matches ..0 run scoreboard players set #mv_ok editor 0
# 边界（最前）→ 仅提示
execute if score #mv_ok editor matches 0 run data modify storage rhythm_axe:maps.editor feedback set value "已经是最前面一条了"
execute if score #mv_ok editor matches 0 run data modify storage rhythm_axe:maps.editor no_undo set value 1b
execute if score #mv_ok editor matches 0 run function rhythm_axe:editor/menu/event/panel/event_panel
# 可上移 → 交换后重绘
execute if score #mv_ok editor matches 1 run execute store result storage rhythm_axe:prop mv_i int 1 run scoreboard players get #temp editor
execute if score #mv_ok editor matches 1 run execute store result storage rhythm_axe:prop mv_j int 1 run scoreboard players get #mv_j editor
execute if score #mv_ok editor matches 1 run function rhythm_axe:editor/menu/event/panel/event_panel_cmd_move_ with storage rhythm_axe:prop
execute if score #mv_ok editor matches 1 run data remove storage rhythm_axe:prop mv_i
execute if score #mv_ok editor matches 1 run data remove storage rhythm_axe:prop mv_j
execute if score #mv_ok editor matches 1 run function rhythm_axe:editor/menu/event/panel/event_panel
