#arg:value
# 查找时间点/事件点提交：按 time 遍历输出结果
$scoreboard players set #target_id editor $(value)
execute unless data storage rhythm_axe:maps.editor editing.find_is_event run function rhythm_axe:editor/menu/find/find_timing_prep
execute if data storage rhythm_axe:maps.editor editing.find_is_event run function rhythm_axe:editor/menu/find/find_event_prep
data remove storage rhythm_axe:maps.editor editing
