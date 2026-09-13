# 批量剪切收尾（由 remove_finish 按 clip_action="batch_cut" 分派）
# 反馈走反馈系统（顶部提示 + 【撤销】按钮），与【批量删除】一致——不再用单行 tellraw；数量 = 被剪掉的音符数
# 剪切 = 复制 + 删除：剪贴板**保留**这些音符（之后可直接【批量粘贴】），只清理收集用的临时下标与 prop
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
execute store result score #cut_count editor run data get storage rhythm_axe:maps.editor clipboard.notes
data modify storage rhythm_axe:maps.editor feedback set value "已剪切"
scoreboard players operation #fb_count editor = #cut_count editor
data modify storage rhythm_axe:prop fb_count set value 1b
# 回「原面板」：入口把 current_panel 存进 prop.ret_panel，18 → 已选定列表，其余（含缺省）→ 活跃列表
scoreboard players reset #ret_panel editor
execute store result score #ret_panel editor run data get storage rhythm_axe:prop ret_panel
execute if score #ret_panel editor matches 18 run schedule function rhythm_axe:editor/menu/note/selected/sel_note_list_open_next 1t
execute unless score #ret_panel editor matches 18 run schedule function rhythm_axe:editor/menu/note/list/note_list_open_next 1t
# 清理（收集流程 prop + 本次标记）
function rhythm_axe:editor/note/copy/clip_cleanup
data remove storage rhythm_axe:prop ret_panel
scoreboard players reset #cut_count editor
scoreboard players reset #ret_panel editor
