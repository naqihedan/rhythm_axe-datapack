# Shift+左键：把交互实体相对"应该在的位置"的偏移加到音符判定位置（@s = 玩家；#nc_id = 音符 id）
# 相当于 打开音符属性面板→改判定位置→确定，独立反馈="已应用音符位置"
execute unless score #off_valid editor matches 1 run tellraw @s [{"text":"[编辑器] 无法读取偏移（音符未定位/缺少应该在的位置）","color":"red"}]
execute unless score #off_valid editor matches 1 run return fail
# 定位音符索引
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop note_id int 1 run scoreboard players get #nc_id editor
data modify storage rhythm_axe:prop index set value 0
data remove storage rhythm_axe:prop found_index
function rhythm_axe:editor/util/find_by_id
execute unless data storage rhythm_axe:prop found_index run tellraw @s [{"text":"[编辑器] 找不到该音符","color":"red"}]
execute unless data storage rhythm_axe:prop found_index run return fail
data modify storage rhythm_axe:prop index set from storage rhythm_axe:prop found_index
# 记录 + 修改 + 提交（撤销快照）
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "修改音符"
function rhythm_axe:editor/tool/note_offset_apply with storage rhythm_axe:prop
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
# 时间轴同步刷新
scoreboard players add #content_ver editor 1
execute store result storage rhythm_axe:maps.editor content_ver int 1 run scoreboard players get #content_ver editor
# 独立弹一次"已应用音符位置"反馈（打开面板本身不产生 feedback）
data modify storage rhythm_axe:maps.editor feedback set value "已应用音符位置"
function rhythm_axe:editor/menu/show_feedback
# 打开/刷新音符属性控制面板（读 post-offset 数据；面板已打开则刷新，未打开则打开）
function rhythm_axe:editor/menu/note/panel/note_panel_open_ with storage rhythm_axe:prop
# 清理
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop note_id
data remove storage rhythm_axe:prop found_index
