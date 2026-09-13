# 判定时间【使用当前时间】(12005)：把判定时间**切换为绝对模式**并设为**当前播放头位置**
# 语义与 13301「切到绝对」一致：批量模式补打 batch_set.time（= 视为已修改，【确认】时写回）
# 并清掉相对增量（否则切回相对时还留着旧增量）
data modify storage rhythm_axe:maps.editor editing.rel.on.time set value 0b
execute if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.time set value 1b
data remove storage rhythm_axe:maps.editor editing.rel.delta.time
# 取当前播放头（下界 0，与判定时间的下界一致）
scoreboard players set #te_now editor 0
execute store result score #te_now editor run data get storage rhythm_axe:maps.editor playhead
execute if score #te_now editor matches ..-1 run scoreboard players set #te_now editor 0
execute store result storage rhythm_axe:maps.editor editing.temp.time int 1 run scoreboard players get #te_now editor
# 重渲面板（与其它字段按钮一致：就地刷新，不改面板/光标）
function rhythm_axe:editor/menu/note/panel/note_panel
