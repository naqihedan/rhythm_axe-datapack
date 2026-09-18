# 把锚点清掉并按**当前**选中音符的包围盒中心重建（含 `data.anchor_c*` 记录 + 清 manual 标记）
# 用于：【⌖】11510 重置；「应用锚点变换」的收尾（变换后锚点要回到新中心、旋转归零、变回红）
#   注意 summon 用 anchor_put 的 NBT ⇒ left_rotation 回到单位四元数 [0,0,0,1]（旋转归零正是「完全重置」的一部分）
# 前置：prop.cursor 已指向工作副本（anchor_center 的兜底扫描要用）；调用方负责 `data remove prop.cursor`
kill @e[tag=editor_anchor]
execute unless data storage rhythm_axe:maps.editor selection[0] run return 0
function rhythm_axe:editor/menu/note/anchor/anchor_center
scoreboard players operation #an_tx editor = #rc0 editor
scoreboard players operation #an_ty editor = #rc1 editor
scoreboard players operation #an_tz editor = #rc2 editor
function rhythm_axe:editor/menu/note/anchor/anchor_put
function rhythm_axe:editor/menu/note/anchor/anchor_mark_auto
