# 音符工具选项栏（面板 23，@s = 查看者；分组 1）
# 设置：固定音符位置 —— 放置音符时把 X/Y/Z 坐标锁定在固定值上（各轴独立开关）。
#   行 221 X 轴（红）/ 行 222 Y 轴（绿）/ 行 223 Z 轴（淡蓝）
#   列码：1 开关 / 2 −1 / 3 −0.1 / 4 +0.1 / 5 +1 / 6 使用注视位置 / 7 对齐方块中心
#   ★ 设置值存计分板 tool_opt（全局、跨谱面）：note_lock_<轴>（0/1 开关）、note_lock_<轴>_val（×10 一位小数）。
#   ★ 本栏现在只做"设置界面 + 存储"；"锁定坐标实际影响放置"的逻辑待后续讨论后接入。
# 本文件是"发射点"：按钮值经 prop.<key> 注入 axis_row 宏（check_all_panel_coverage.py 认这种写法）。
# 注：清屏由调用方 tool_panel 负责，这里不重复 clear_lines。
data modify storage rhythm_axe:maps.editor current_panel set value 23
tellraw @s [{"text":"====音符工具选项栏====","color":"gold","bold":true}]
tellraw @s [{"text":"----固定音符位置----------","color":"gray"}]

# ==================== X 轴（行 221）====================
data modify storage rhythm_axe:prop a_tgl set value '{"text":"【关】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 22101"},"hover_event":{"action":"show_text","value":"点击开启：放置音符时锁定 X 坐标"}}'
execute if score note_lock_x tool_opt matches 1 run data modify storage rhythm_axe:prop a_tgl set value '{"text":"【开】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 22101"},"hover_event":{"action":"show_text","value":"点击关闭：不锁定 X 坐标"}}'
data modify storage rhythm_axe:prop label set value "X"
data modify storage rhythm_axe:prop color set value "red"
data modify storage rhythm_axe:prop tkey set value "note_lock_x"
data modify storage rhythm_axe:prop vkey set value "note_lock_x_val"
data modify storage rhythm_axe:prop b1 set value 22102
data modify storage rhythm_axe:prop b2 set value 22103
data modify storage rhythm_axe:prop b3 set value 22104
data modify storage rhythm_axe:prop b4 set value 22105
data modify storage rhythm_axe:prop look set value 22106
data modify storage rhythm_axe:prop center set value 22107
function rhythm_axe:editor/menu/tool/panel/axis_row with storage rhythm_axe:prop

# ==================== Y 轴（行 222）====================
data modify storage rhythm_axe:prop a_tgl set value '{"text":"【关】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 22201"},"hover_event":{"action":"show_text","value":"点击开启：放置音符时锁定 Y 坐标"}}'
execute if score note_lock_y tool_opt matches 1 run data modify storage rhythm_axe:prop a_tgl set value '{"text":"【开】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 22201"},"hover_event":{"action":"show_text","value":"点击关闭：不锁定 Y 坐标"}}'
data modify storage rhythm_axe:prop label set value "Y"
data modify storage rhythm_axe:prop color set value "green"
data modify storage rhythm_axe:prop tkey set value "note_lock_y"
data modify storage rhythm_axe:prop vkey set value "note_lock_y_val"
data modify storage rhythm_axe:prop b1 set value 22202
data modify storage rhythm_axe:prop b2 set value 22203
data modify storage rhythm_axe:prop b3 set value 22204
data modify storage rhythm_axe:prop b4 set value 22205
data modify storage rhythm_axe:prop look set value 22206
data modify storage rhythm_axe:prop center set value 22207
function rhythm_axe:editor/menu/tool/panel/axis_row with storage rhythm_axe:prop

# ==================== Z 轴（行 223）====================
data modify storage rhythm_axe:prop a_tgl set value '{"text":"【关】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 22301"},"hover_event":{"action":"show_text","value":"点击开启：放置音符时锁定 Z 坐标"}}'
execute if score note_lock_z tool_opt matches 1 run data modify storage rhythm_axe:prop a_tgl set value '{"text":"【开】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 22301"},"hover_event":{"action":"show_text","value":"点击关闭：不锁定 Z 坐标"}}'
data modify storage rhythm_axe:prop label set value "Z"
data modify storage rhythm_axe:prop color set value "aqua"
data modify storage rhythm_axe:prop tkey set value "note_lock_z"
data modify storage rhythm_axe:prop vkey set value "note_lock_z_val"
data modify storage rhythm_axe:prop b1 set value 22302
data modify storage rhythm_axe:prop b2 set value 22303
data modify storage rhythm_axe:prop b3 set value 22304
data modify storage rhythm_axe:prop b4 set value 22305
data modify storage rhythm_axe:prop look set value 22306
data modify storage rhythm_axe:prop center set value 22307
function rhythm_axe:editor/menu/tool/panel/axis_row with storage rhythm_axe:prop

# ==================== 返回 ====================
tellraw @s [{"text":""},{"text":"【返回】","color":"dark_aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 1"},"hover_event":{"action":"show_text","value":"返回上一个打开的面板"}}]

# 清理（axis_row 用过的 prop 键）
data remove storage rhythm_axe:prop a_tgl
data remove storage rhythm_axe:prop label
data remove storage rhythm_axe:prop color
data remove storage rhythm_axe:prop tkey
data remove storage rhythm_axe:prop vkey
data remove storage rhythm_axe:prop b1
data remove storage rhythm_axe:prop b2
data remove storage rhythm_axe:prop b3
data remove storage rhythm_axe:prop b4
data remove storage rhythm_axe:prop look
data remove storage rhythm_axe:prop center
