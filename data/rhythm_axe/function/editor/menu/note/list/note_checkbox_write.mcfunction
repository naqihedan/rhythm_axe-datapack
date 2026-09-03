#arg:sel_val
# 写入复选框组件到 prop.checkbox（供 note_list_line 行首 [$(checkbox), 使用）
# @s = 玩家（无效）；#sel_on editor = 此音符是否已选中（note_list_row2 计算）
# 注意：只有行首带 $ 的宏行才能用 $(sel_val)
$execute if score #sel_on editor matches 1 run data modify storage rhythm_axe:prop checkbox set value "{\"text\":\"[√]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set $(sel_val)\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"取消选中该音符\"}}"
$execute if score #sel_on editor matches 0 run data modify storage rhythm_axe:prop checkbox set value "{\"text\":\"[  ]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set $(sel_val)\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"选中该音符（用于批量编辑）\"}}"
