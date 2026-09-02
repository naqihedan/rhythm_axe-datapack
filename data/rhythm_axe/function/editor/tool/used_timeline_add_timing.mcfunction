# 时间点工具右键（@s = 玩家）：当前时间无时间点 → 创建并打开编辑（继承上一个时间点字段）；已有时间点 → 直接打开编辑。
# prop.time = 播放头。

# ★ 先保存 target_time（create 末尾会移除 prop.time）
data modify storage rhythm_axe:prop target_time set from storage rhythm_axe:prop time

# 先查找该 time 是否已存在时间点（data get 比较，可靠）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop list_name set value "timing_points"
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_time

# 命中 → 直接打开已有时间点编辑面板（不创建）
execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/timing/panel/timing_panel_open with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop found_index run return 0

# 未命中 → 创建（默认值 + 继承上一个时间点）
# 默认值（源：timing_panel_new_open 的 editing.temp 缺省）
execute unless data storage rhythm_axe:prop bpm run data modify storage rhythm_axe:prop bpm set value 150.0f
execute unless data storage rhythm_axe:prop bpb run data modify storage rhythm_axe:prop bpb set value 4
execute unless data storage rhythm_axe:prop tpb run data modify storage rhythm_axe:prop tpb set value 8
execute unless data storage rhythm_axe:prop judgement_scale run data modify storage rhythm_axe:prop judgement_scale set value 1

# 继承上一个时间点（命中则覆盖上面的默认值）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop inherit_playhead set from storage rhythm_axe:prop target_time
# 初始化遍历状态（timing_inherit 递归体内不重置，必须在此一次初始化）
data modify storage rhythm_axe:prop index set value 0
scoreboard players set #inh_found editor 0
scoreboard players set #inh_done editor 0
function rhythm_axe:editor/tool/timing_inherit
execute if score #inh_found editor matches 1 run data modify storage rhythm_axe:prop bpm set from storage rhythm_axe:prop inh_bpm
execute if score #inh_found editor matches 1 run data modify storage rhythm_axe:prop bpb set from storage rhythm_axe:prop inh_bpb
execute if score #inh_found editor matches 1 run data modify storage rhythm_axe:prop tpb set from storage rhythm_axe:prop inh_tpb
execute if score #inh_found editor matches 1 run data modify storage rhythm_axe:prop judgement_scale set from storage rhythm_axe:prop inh_judgement_scale

# 创建时间点（自动插入+历史快照+反馈）
data modify storage rhythm_axe:maps.editor op_label set value "创建时间点"
function rhythm_axe:editor/timing/create

# 创建后打开新时间点设置面板：按 time=target_time 找到索引
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop list_name set value "timing_points"
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_time
execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/timing/panel/timing_panel_open with storage rhythm_axe:prop

# 清理
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop target_time
data remove storage rhythm_axe:prop list_name
data remove storage rhythm_axe:prop found_index
data remove storage rhythm_axe:prop time
data remove storage rhythm_axe:prop bpm
data remove storage rhythm_axe:prop bpb
data remove storage rhythm_axe:prop tpb
data remove storage rhythm_axe:prop judgement_scale
data remove storage rhythm_axe:prop inherit_playhead
data remove storage rhythm_axe:prop inh_bpm
data remove storage rhythm_axe:prop inh_bpb
data remove storage rhythm_axe:prop inh_tpb
data remove storage rhythm_axe:prop inh_judgement_scale
