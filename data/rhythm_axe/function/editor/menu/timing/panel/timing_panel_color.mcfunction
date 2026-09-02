# 颜色自动计算（基于暂存 editing.temp，每次刷新面板前调用）：
# bpm 变化 或 bpm×tpb（tps）变化 → 红，否则绿；第一个时间点为红
# 结果写入 maps.editor editing.is_red（1b/0b），由面板显示行读取
data remove storage rhythm_axe:maps.editor editing.is_red
execute store result score #temp editor run data get storage rhythm_axe:maps.editor editing.temp.bpm 1000
execute store result score #index editor run data get storage rhythm_axe:maps.editor editing.temp.tpb
scoreboard players operation #temp_cursor editor = #temp editor
scoreboard players operation #temp_cursor editor *= #index editor
# 比较前一个时间点（ref=0 时直接红线）
execute store result score #temp_playhead editor run data get storage rhythm_axe:maps.editor editing.ref
execute if score #temp_playhead editor matches ..0 run data modify storage rhythm_axe:maps.editor editing.is_red set value 1b
execute if score #temp_playhead editor matches 1.. run function rhythm_axe:editor/menu/timing/panel/timing_panel_color_prev
