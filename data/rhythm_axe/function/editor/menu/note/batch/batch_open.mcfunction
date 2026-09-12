# 批量编辑入口（面板18【批量编辑】按钮；从 selection 进入）：editing.batch=1b，默认相对，全部增量置 0
# batch_ids = selection（音符 id 列表）；panel_from 记录来源（从哪来回哪去）
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
# 清理 selection 中已失效（被删但未移除）的音符 id，确保批量计数与已选中列表一致
# ★ 顺序游标 clean_cursor：find_by_id 从上次命中位置继续，避免逐个全扫导致 O(n²) 超限
data modify storage rhythm_axe:prop slc_out set value []
data modify storage rhythm_axe:prop slc_idx set value 0
data modify storage rhythm_axe:prop clean_cursor set value 0
execute if data storage rhythm_axe:maps.editor selection run function rhythm_axe:editor/menu/note/selected/sel_clean_drive
data remove storage rhythm_axe:prop slc_out
data remove storage rhythm_axe:prop slc_idx
data remove storage rhythm_axe:prop clean_cursor
execute store result score #sel_count editor run data get storage rhythm_axe:maps.editor selection
data modify storage rhythm_axe:maps.editor editing.batch set value 1b
data modify storage rhythm_axe:maps.editor editing.batch_ids set from storage rhythm_axe:maps.editor selection
execute store result score #batch_n editor run data get storage rhythm_axe:maps.editor editing.batch_ids
execute if score #batch_n editor matches ..0 run tellraw @s [{"text":"[编辑器] 没有选中的音符，无法批量编辑","color":"red"}]
execute if score #batch_n editor matches ..0 run data remove storage rhythm_axe:maps.editor editing.batch
execute if score #batch_n editor matches ..0 run return fail
# 同值字段暂存 editing.temp（=将应用到所有音符的值，默认从常见缺省起；batch_set 标记哪些同值字段被改动）
data modify storage rhythm_axe:maps.editor editing.temp set value {size:1.0f,note_base_life:24,anim_easing:1,anim_power:1,type:0,following_point:0b,ignore_note_speed:0b,custom_tag:"",position:[0.0d,0.0d,0.0d],start_pos:[0.0d,0.0d,24.0d],time:0,hitsound:0,hit_particles:0,duration:8,color:0b,density:8}
data modify storage rhythm_axe:maps.editor editing.batch_set set value {}
# 相对增量字段：默认相对，增量置 0（相对模式显示并应用增量；切换绝对则用 editing.temp 同值）
data modify storage rhythm_axe:maps.editor editing.rel set value {on:{time:1b,size:1b,position:1b,start_pos:1b,duration:1b},delta:{time:0,size:0,position:[0,0,0],start_pos:[0,0,0],duration:0}}
data modify storage rhythm_axe:maps.editor editing.panel_from set from storage rhythm_axe:maps.editor current_panel
execute store result score #batch_from editor run data get storage rhythm_axe:maps.editor current_panel
data modify storage rhythm_axe:maps.editor current_panel set value 11
function rhythm_axe:editor/menu/note/panel/note_panel
