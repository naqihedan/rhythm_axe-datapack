# 消费 editor_click 点击值并分发（@s = 玩家；tick 检测 @a[scores={editor_click=1..}]）
execute store result score #click_value editor run scoreboard players get @s editor_click
scoreboard players reset @s editor_click
scoreboard players enable @s editor_click

# ★ 统一操作反馈音：所有 trigger 按钮点击（含 903/时间控件/撤销重做/各面板按钮）
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1

# 返回编辑器（903）：重进存档后无条件恢复编辑并打开上次所在面板（绕过 active 检查与面板隔离）
execute if score #click_value editor matches 903 run data modify storage rhythm_axe:maps.editor active set value 1b
execute if score #click_value editor matches 903 run function rhythm_axe:editor/menu/resume
execute if score #click_value editor matches 903 run return fail

# 仅在编辑中响应
execute unless data storage rhythm_axe:maps.editor {active:1b} run return fail

# 时间控件（20-29）：任意面板可用（提前分发并返回，绕过面板隔离；面板按钮值 20-29 与各子面板不冲突）
execute if score #click_value editor matches 20 run data modify storage rhythm_axe:prop kind set value "bar"
execute if score #click_value editor matches 20 run data modify storage rhythm_axe:prop direction set value "back"
execute if score #click_value editor matches 20 run function rhythm_axe:editor/playback/step with storage rhythm_axe:prop
execute if score #click_value editor matches 21 run data modify storage rhythm_axe:prop kind set value "beat"
execute if score #click_value editor matches 21 run data modify storage rhythm_axe:prop direction set value "back"
execute if score #click_value editor matches 21 run function rhythm_axe:editor/playback/step with storage rhythm_axe:prop
execute if score #click_value editor matches 22 run data modify storage rhythm_axe:prop direction set value "back"
execute if score #click_value editor matches 22 run data modify storage rhythm_axe:prop ticks set value 1
execute if score #click_value editor matches 22 run function rhythm_axe:editor/playback/seek with storage rhythm_axe:prop
execute if score #click_value editor matches 23 run function rhythm_axe:editor/menu/playback_toggle
execute if score #click_value editor matches 24 run data modify storage rhythm_axe:prop direction set value "fwd"
execute if score #click_value editor matches 24 run data modify storage rhythm_axe:prop ticks set value 1
execute if score #click_value editor matches 24 run function rhythm_axe:editor/playback/seek with storage rhythm_axe:prop
execute if score #click_value editor matches 25 run data modify storage rhythm_axe:prop kind set value "beat"
execute if score #click_value editor matches 25 run data modify storage rhythm_axe:prop direction set value "fwd"
execute if score #click_value editor matches 25 run function rhythm_axe:editor/playback/step with storage rhythm_axe:prop
execute if score #click_value editor matches 26 run data modify storage rhythm_axe:prop kind set value "bar"
execute if score #click_value editor matches 26 run data modify storage rhythm_axe:prop direction set value "fwd"
execute if score #click_value editor matches 26 run function rhythm_axe:editor/playback/step with storage rhythm_axe:prop
execute if score #click_value editor matches 27 run function rhythm_axe:editor/menu/cycle_speed
execute if score #click_value editor matches 28 run function rhythm_axe:editor/menu/jump/jump_start
execute if score #click_value editor matches 29 run function rhythm_axe:editor/menu/jump/jump_end
execute if score #click_value editor matches 20..29 run data remove storage rhythm_axe:prop kind
execute if score #click_value editor matches 20..29 run return 0

# 撤销/重做（8/9）：任意面板可用，撤销/重做后回操作面板（undo_panel 记录的最新操作所在面板）
execute if score #click_value editor matches 8 run function rhythm_axe:editor/file/undo
execute if score #click_value editor matches 8 run data modify storage rhythm_axe:maps.editor current_panel set from storage rhythm_axe:maps.editor undo_panel
execute if score #click_value editor matches 8 run data remove storage rhythm_axe:maps.editor undo_panel
execute if score #click_value editor matches 8 run function rhythm_axe:editor/menu/resume
execute if score #click_value editor matches 8 run return 0
execute if score #click_value editor matches 9 run function rhythm_axe:editor/file/redo
execute if score #click_value editor matches 9 run data modify storage rhythm_axe:maps.editor current_panel set from storage rhythm_axe:maps.editor undo_panel
execute if score #click_value editor matches 9 run data remove storage rhythm_axe:maps.editor undo_panel
execute if score #click_value editor matches 9 run function rhythm_axe:editor/menu/resume
execute if score #click_value editor matches 9 run return 0

# —— 按面板号分流到各面板分支文件（分支内已含该面板白名单守卫与全部值处理）——
# 903/8/9/20..29 已在上面统一处理（任意面板可用），此处不再放行；其余一律进所属面板分支。
execute store result score #panel_id editor run data get storage rhythm_axe:maps.editor current_panel
execute if score #panel_id editor matches 1 run return run function rhythm_axe:editor/menu/panel/panel1
execute if score #panel_id editor matches 2 run return run function rhythm_axe:editor/menu/panel/panel2
execute if score #panel_id editor matches 3 run return run function rhythm_axe:editor/menu/panel/panel3
execute if score #panel_id editor matches 4 run return run function rhythm_axe:editor/menu/panel/panel4
execute if score #panel_id editor matches 5 run return run function rhythm_axe:editor/menu/panel/panel5
execute if score #panel_id editor matches 6 run return run function rhythm_axe:editor/menu/panel/panel6
execute if score #panel_id editor matches 7 run return run function rhythm_axe:editor/menu/panel/panel7
execute if score #panel_id editor matches 8 run return run function rhythm_axe:editor/menu/panel/panel8
execute if score #panel_id editor matches 9 run return run function rhythm_axe:editor/menu/panel/panel9
execute if score #panel_id editor matches 10 run return run function rhythm_axe:editor/menu/panel/panel10
execute if score #panel_id editor matches 11 run return run function rhythm_axe:editor/menu/panel/panel11
execute if score #panel_id editor matches 12 run return run function rhythm_axe:editor/menu/panel/panel12
execute if score #panel_id editor matches 13 run return run function rhythm_axe:editor/menu/panel/panel13
execute if score #panel_id editor matches 14 run return run function rhythm_axe:editor/menu/panel/panel14
execute if score #panel_id editor matches 15 run return run function rhythm_axe:editor/menu/panel/panel15
execute if score #panel_id editor matches 16 run return run function rhythm_axe:editor/menu/panel/panel16
execute if score #panel_id editor matches 17 run return run function rhythm_axe:editor/menu/panel/panel17
execute if score #panel_id editor matches 18 run return run function rhythm_axe:editor/menu/panel/panel18
# 兜底（面板号异常未命中时；正常到不了）
function rhythm_axe:editor/menu/wrong_panel
