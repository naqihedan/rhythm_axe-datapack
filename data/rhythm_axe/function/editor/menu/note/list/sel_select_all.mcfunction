# 全部选中：把当前存活且**未选中**的音符追加到当前 selection（不清空、不重复添加已选中项）
# 通过遍历存活展示实体实现——editor/visual/refresh 只生成存活音符的展示实体（kill 后按存活重建）
execute as @e[type=item_display,tag=editor_note] run function rhythm_axe:editor/menu/note/list/sel_all_entity
execute store result score #sel_count editor run data get storage rhythm_axe:maps.editor selection
function rhythm_axe:editor/menu/note/list/note_list_open
