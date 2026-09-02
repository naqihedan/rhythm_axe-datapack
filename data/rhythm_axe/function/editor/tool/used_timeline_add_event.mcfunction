# 事件点工具右键（@s = 玩家）：当前时间无事件点 → 创建并打开编辑；已有事件点 → 直接打开编辑。
# prop.time = 播放头。

# ★ 先保存 target_time（create 末尾会移除 prop.time）
data modify storage rhythm_axe:prop target_time set from storage rhythm_axe:prop time

# 先查找该 time 是否已有事件点（data get 比较，可靠）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop list_name set value "events"
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_time

# 命中 → 直接打开已有事件点编辑面板（不创建）
execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/event/panel/event_panel_open with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop found_index run return 0

# 未命中 → 创建（commands 不继承，空列表）
data modify storage rhythm_axe:prop commands set value []
data modify storage rhythm_axe:maps.editor op_label set value "创建事件"
function rhythm_axe:editor/event/create

# 创建后打开新事件点设置面板：按 time=target_time 找到索引
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop list_name set value "events"
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_time
execute if data storage rhythm_axe:prop found_index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
execute if data storage rhythm_axe:prop found_index run function rhythm_axe:editor/menu/event/panel/event_panel_open with storage rhythm_axe:prop

# 清理
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop target_time
data remove storage rhythm_axe:prop list_name
data remove storage rhythm_axe:prop found_index
data remove storage rhythm_axe:prop commands
data remove storage rhythm_axe:prop time
