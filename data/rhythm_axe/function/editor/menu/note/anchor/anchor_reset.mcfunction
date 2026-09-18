# [⌖] 重置锚点位置（按钮 11510）：清掉现有锚点（含「被改过」标记）→ 按选中包围盒中心重建 → 重绘当前列表
#   语义 = 「完全重置」：位置回包围盒中心 + **旋转归零**（summon 用单位四元数）+ 变回红
#   重建逻辑与「应用锚点变换」收尾共用 → anchor_rebuild_at_center
#   任何时候都可点（无选中时只是清掉实体，安全）
# 前置：prop.cursor 由本函数临时设置/清理（按钮路径下调用方没有准备它）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/menu/note/anchor/anchor_rebuild_at_center
data remove storage rhythm_axe:prop cursor
# 重绘当前列表（按钮颜色：manual→auto 要变回红）
execute store result score #from editor run data get storage rhythm_axe:maps.editor current_panel
execute if score #from editor matches 18 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute unless score #from editor matches 18 run function rhythm_axe:editor/menu/note/list/note_list_open
