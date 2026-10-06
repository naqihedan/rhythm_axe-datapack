# 工具选项栏渲染（面板 23，@s = 查看者）。按 maps.editor.tool_panel_gid 决定显示哪一栏内容。
#   gid：1 音符工具 / 2 时间轴工具 / 3 回到开头·跳到结尾 / 4 播放速度 / 5 选择 / 6 事件点·时间点 / 7 协作
# 每栏末尾都有一条【返回】（值 1）= 回到"上一个打开的非工具面板"，见 editor/tool/offhand/back。
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
data modify storage rhythm_axe:maps.editor current_panel set value 23

scoreboard players set #tp_gid editor 0
execute store result score #tp_gid editor run data get storage rhythm_axe:maps.editor tool_panel_gid
# 分组 1（音符工具）：有设置项
execute if score #tp_gid editor matches 1 run function rhythm_axe:editor/menu/tool/panel/note
# 分组 2..7：暂无设置项（显示"该工具没有设置项。"）
execute if score #tp_gid editor matches 2 run data modify storage rhythm_axe:prop tool_label set value "时间轴工具"
execute if score #tp_gid editor matches 2 run function rhythm_axe:editor/menu/tool/panel/empty with storage rhythm_axe:prop
execute if score #tp_gid editor matches 3 run data modify storage rhythm_axe:prop tool_label set value "回到开头/跳到结尾工具"
execute if score #tp_gid editor matches 3 run function rhythm_axe:editor/menu/tool/panel/empty with storage rhythm_axe:prop
execute if score #tp_gid editor matches 4 run data modify storage rhythm_axe:prop tool_label set value "播放速度工具"
execute if score #tp_gid editor matches 4 run function rhythm_axe:editor/menu/tool/panel/empty with storage rhythm_axe:prop
execute if score #tp_gid editor matches 5 run data modify storage rhythm_axe:prop tool_label set value "选择工具"
execute if score #tp_gid editor matches 5 run function rhythm_axe:editor/menu/tool/panel/empty with storage rhythm_axe:prop
execute if score #tp_gid editor matches 6 run data modify storage rhythm_axe:prop tool_label set value "事件点/时间点工具"
execute if score #tp_gid editor matches 6 run function rhythm_axe:editor/menu/tool/panel/empty with storage rhythm_axe:prop
execute if score #tp_gid editor matches 7 run data modify storage rhythm_axe:prop tool_label set value "协作工具"
execute if score #tp_gid editor matches 7 run function rhythm_axe:editor/menu/tool/panel/empty with storage rhythm_axe:prop
data remove storage rhythm_axe:prop tool_label
# gid 缺失/异常（正常到不了）→ 回主菜单
execute unless score #tp_gid editor matches 1..7 run function rhythm_axe:editor/menu/main
