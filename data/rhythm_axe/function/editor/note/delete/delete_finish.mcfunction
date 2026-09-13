# 删除收尾（由 remove_finish 按 clip_action="delete" 分派）：还原剪贴板 → commit + refresh → 反馈「已删除」→ 回原面板
# 删除个数 = clipboard.notes（本次收集到的音符 = 被删掉的音符），读完立刻还原剪贴板
execute store result score #del_count editor run data get storage rhythm_axe:maps.editor clipboard.notes
execute if data storage rhythm_axe:prop clip_bak run data modify storage rhythm_axe:maps.editor clipboard set from storage rhythm_axe:prop clip_bak
execute unless data storage rhythm_axe:prop clip_bak run data remove storage rhythm_axe:maps.editor clipboard
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
data modify storage rhythm_axe:maps.editor feedback set value "已删除"
scoreboard players operation #fb_count editor = #del_count editor
data modify storage rhythm_axe:prop fb_count set value 1b
# 回「原面板」：入口把 current_panel 存进 prop.ret_panel，18 → 已选定列表，其余（含缺省）→ 活跃列表
scoreboard players reset #ret_panel editor
execute store result score #ret_panel editor run data get storage rhythm_axe:prop ret_panel
execute if score #ret_panel editor matches 18 run schedule function rhythm_axe:editor/menu/note/selected/sel_note_list_open_next 1t
execute unless score #ret_panel editor matches 18 run schedule function rhythm_axe:editor/menu/note/list/note_list_open_next 1t
# 清理（收集流程的 prop + 本次的备份/回面板标记）
function rhythm_axe:editor/note/copy/clip_cleanup
data remove storage rhythm_axe:prop clip_bak
data remove storage rhythm_axe:prop ret_panel
scoreboard players reset #del_count editor
scoreboard players reset #ret_panel editor
