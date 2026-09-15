# 写入单个过场事件点（复用编辑器自身的「一刻一个 + 升序插入」机制）
# ★ 本函数**不**自己调 file/begin / file/commit —— 快照由 apply_editor 统一包住，
#   这样 23 条事件合起来只占一份快照（= 一步操作）。
# 前置：prop.cursor（工作副本下标）、prop.lr_list[0] = {time:N, commands:[...]}

data modify storage rhythm_axe:prop time set from storage rhythm_axe:prop lr_list[0].time
data modify storage rhythm_axe:prop commands set from storage rhythm_axe:prop lr_list[0].commands

data modify storage rhythm_axe:prop list_name set value "events"
data modify storage rhythm_axe:prop new_time set from storage rhythm_axe:prop time
execute store result storage rhythm_axe:prop new_time int 1 run data get storage rhythm_axe:prop new_time
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index

# 一刻只能有一个事件点：该刻已有事件 → 跳过这一条（不覆盖别人的事件）
data modify storage rhythm_axe:prop dup set value 0b
data modify storage rhythm_axe:prop kind set value "事件"
function rhythm_axe:editor/util/check_unique_time with storage rhythm_axe:prop

execute unless data storage rhythm_axe:prop {dup:1b} run function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
execute unless data storage rhythm_axe:prop {dup:1b} if data storage rhythm_axe:prop {insert_mode:"append"} run function rhythm_axe:editor/event/create_append with storage rhythm_axe:prop
execute unless data storage rhythm_axe:prop {dup:1b} if data storage rhythm_axe:prop {insert_mode:"insert"} run function rhythm_axe:editor/event/create_insert with storage rhythm_axe:prop

# 处理下一条
data remove storage rhythm_axe:prop lr_list[0]
function rhythm_axe:maps/lament_rain/cutscene/apply_loop
