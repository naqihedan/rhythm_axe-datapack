# 批量重排·移出驱动：按 prop.move_idx 的**尾部**（= 下标降序）逐个把音符搬到 prop.move_out
#   前置：prop.cursor（工作副本下标）、prop.move_idx（**升序**下标表）、prop.move_out 由调用方先清空
#   收尾：prop.move_idx / prop.move_out 由调用方清理（move_in_drive 会把 move_out 取空）
#   ⚠️ 必须在「数组不再被别的操作改动」的前提下调用（本驱动器自身不改下标相对顺序之外的东西）
execute unless data storage rhythm_axe:prop move_idx[0] run return 0
data modify storage rhythm_axe:prop rm_i set from storage rhythm_axe:prop move_idx[-1]
function rhythm_axe:editor/util/move_out_leaf with storage rhythm_axe:prop
data remove storage rhythm_axe:prop move_idx[-1]
function rhythm_axe:editor/util/move_out_drive
