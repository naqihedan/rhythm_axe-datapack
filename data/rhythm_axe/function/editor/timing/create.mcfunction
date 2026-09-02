# 创建时间点：前置 prop.time（起始刻）、prop.bpm（Float）、prop.bpb、prop.tpb

# 可选 prop：judgement_scale（缺省 1）；按 time 升序插入 timing_points
execute unless data storage rhythm_axe:prop time run tellraw @s [{"text":"[编辑器] 缺少时间（prop.time）","color":"red"}]
execute unless data storage rhythm_axe:prop time run return fail
execute unless data storage rhythm_axe:prop bpm run tellraw @s [{"text":"[编辑器] 缺少 bpm（prop.bpm）","color":"red"}]
execute unless data storage rhythm_axe:prop bpm run return fail
execute unless data storage rhythm_axe:prop bpb run tellraw @s [{"text":"[编辑器] 缺少 bpb（prop.bpb）","color":"red"}]
execute unless data storage rhythm_axe:prop bpb run return fail
execute unless data storage rhythm_axe:prop tpb run tellraw @s [{"text":"[编辑器] 缺少 tpb（prop.tpb）","color":"red"}]
execute unless data storage rhythm_axe:prop tpb run return fail

function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute unless data storage rhythm_axe:prop judgement_scale run data modify storage rhythm_axe:prop judgement_scale set value 1
# 类型规范化（宏展开时输出带正确 NBT 后缀；bpm 用 data modify 保留 float 原类型——26.x store result storage 截断小数）
data modify storage rhythm_axe:prop bpm set from storage rhythm_axe:prop bpm
execute store result storage rhythm_axe:prop bpb int 1 run data get storage rhythm_axe:prop bpb
execute store result storage rhythm_axe:prop tpb int 1 run data get storage rhythm_axe:prop tpb
execute store result storage rhythm_axe:prop judgement_scale int 1 run data get storage rhythm_axe:prop judgement_scale
data modify storage rhythm_axe:prop list_name set value "timing_points"
data modify storage rhythm_axe:prop new_time set from storage rhythm_axe:prop time
execute store result storage rhythm_axe:prop new_time int 1 run data get storage rhythm_axe:prop new_time
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop insert_mode

# 规则：一刻内只能有一个时间点（各自最多 1 个；时间点与事件点可共存）
data modify storage rhythm_axe:prop dup set value 0b
data modify storage rhythm_axe:prop kind set value "时间"
function rhythm_axe:editor/util/check_unique_time with storage rhythm_axe:prop
# ★ 判断 dup 值需用复合标签 {dup:1b}；判断键是否存在（execute if data ... dup）会因键恒存在而误判为真
execute if data storage rhythm_axe:prop {dup:1b} run tellraw @s [{"text":"[编辑器] 该刻已存在时间点，一刻内只能有一个时间点或事件点","color":"red"}]
execute if data storage rhythm_axe:prop {dup:1b} run return fail

function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop {insert_mode:"append"} run function rhythm_axe:editor/timing/create_append with storage rhythm_axe:prop
execute if data storage rhythm_axe:prop {insert_mode:"insert"} run function rhythm_axe:editor/timing/create_insert with storage rhythm_axe:prop
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
# ★ 走 feedback 机制（显示反馈 + 附撤销/重做按钮），供 show_feedback 读取
data modify storage rhythm_axe:maps.editor feedback set value "已创建时间点"

data remove storage rhythm_axe:prop time
data remove storage rhythm_axe:prop bpm
data remove storage rhythm_axe:prop bpb
data remove storage rhythm_axe:prop tpb
data remove storage rhythm_axe:prop judgement_scale
data remove storage rhythm_axe:prop list_name
data remove storage rhythm_axe:prop new_time
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop dup
data remove storage rhythm_axe:prop kind
