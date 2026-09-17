# [⌖] 重置锚点位置（按钮 11510）：清掉现有锚点（含「被改过」标记）→ 按选中包围盒中心重建 → 重绘当前列表
#   语义 = 「回到自动跟随」；任何时候都可点（无选中时只是清掉实体，安全）
# 前置：prop.cursor 由本函数临时设置/清理（按钮路径下调用方没有准备它）
kill @e[tag=editor_anchor]
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute if data storage rhythm_axe:maps.editor selection[0] run function rhythm_axe:editor/menu/note/anchor/anchor_center
execute if data storage rhythm_axe:maps.editor selection[0] run scoreboard players operation #an_tx editor = #rc0 editor
execute if data storage rhythm_axe:maps.editor selection[0] run scoreboard players operation #an_ty editor = #rc1 editor
execute if data storage rhythm_axe:maps.editor selection[0] run scoreboard players operation #an_tz editor = #rc2 editor
execute if data storage rhythm_axe:maps.editor selection[0] run function rhythm_axe:editor/menu/note/anchor/anchor_put
execute if data storage rhythm_axe:maps.editor selection[0] run function rhythm_axe:editor/menu/note/anchor/anchor_mark_auto
data remove storage rhythm_axe:prop cursor
# 重绘当前列表（按钮颜色：manual→auto 要变回红）
execute store result score #from editor run data get storage rhythm_axe:maps.editor current_panel
execute if score #from editor matches 18 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute unless score #from editor matches 18 run function rhythm_axe:editor/menu/note/list/note_list_open
