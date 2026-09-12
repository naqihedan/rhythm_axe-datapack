# 时间范围选择（选择工具 + 蹲下右键）：两次蹲右键定入点/出点，按音符判定时间选中区间内音符
#   第一次 定入点 = 当前播放头 | 第二次 定出点 = 当前播放头（选中 [min,max] 区间内音符 + 弹已选定音符列表）后回 state=0
# 与站立右键的立方体框选（used_select）互不干扰：状态存 time_select，与 select_tool 分开
# （操作音效由 use.mcfunction 统一播放，此处不再重复）
execute unless data storage rhythm_axe:maps.editor time_select run data modify storage rhythm_axe:maps.editor time_select set value {state:0}
execute store result score #ts_state editor run data get storage rhythm_axe:maps.editor time_select.state
# 规范化：state 只认 0/1（残留/越界值一律按 0 处理）
execute if score #ts_state editor matches 2.. run scoreboard players set #ts_state editor 0
execute if score #ts_state editor matches 0 run function rhythm_axe:editor/tool/select/time_select_first
execute if score #ts_state editor matches 1 run function rhythm_axe:editor/tool/select/time_select_second
