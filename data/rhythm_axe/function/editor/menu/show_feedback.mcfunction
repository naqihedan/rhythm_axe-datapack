# 面板操作反馈：清屏后、面板内容前显示（黄色纯文本；宏插入，无 nbt 引号问题）
# 反馈后**同时**附【撤销】与【重做】按钮，按历史光标动态判断可用性：
#   可撤销 = history_cursor ≥ 1（存在更早的快照）
#   可重做 = history_cursor < history 长度-1（存在更新的快照，即刚撤销过）
#   不可用的按钮变灰且**不带 click_event**（点了没反应，也不会弹“该按钮不属于当前面板”）
# no_undo 标记存在 → 纯文本反馈（不附按钮）：用于不产生撤销/重做的操作（保存、改名、设置暂存等）
execute if data storage rhythm_axe:maps.editor feedback run data modify storage rhythm_axe:prop fb set from storage rhythm_axe:maps.editor feedback
# no_undo → 纯文本反馈
execute if data storage rhythm_axe:maps.editor feedback if data storage rhythm_axe:maps.editor no_undo run function rhythm_axe:editor/menu/show_feedback_text with storage rhythm_axe:prop
# 默认两个按钮都置灰（兜底：保证宏参数一定存在，防宏参数缺失导致整行不渲染）
execute if data storage rhythm_axe:maps.editor feedback unless data storage rhythm_axe:maps.editor no_undo run data modify storage rhythm_axe:prop btn_undo set value '{"text":"【撤销】","color":"gray"}'
execute if data storage rhythm_axe:maps.editor feedback unless data storage rhythm_axe:maps.editor no_undo run data modify storage rhythm_axe:prop btn_redo set value '{"text":"【重做】","color":"gray"}'
# 计算光标与历史末尾（可重做 = 光标 < 长度-1）
execute if data storage rhythm_axe:maps.editor feedback unless data storage rhythm_axe:maps.editor no_undo run execute store result score #fb_hc editor run data get storage rhythm_axe:maps.editor history_cursor
execute if data storage rhythm_axe:maps.editor feedback unless data storage rhythm_axe:maps.editor no_undo run execute store result score #fb_hlen editor run data get storage rhythm_axe:maps.editor history
execute if data storage rhythm_axe:maps.editor feedback unless data storage rhythm_axe:maps.editor no_undo run scoreboard players remove #fb_hlen editor 1
# 可撤销（光标 ≥ 1）→ 撤销按钮点亮
execute if data storage rhythm_axe:maps.editor feedback unless data storage rhythm_axe:maps.editor no_undo if score #fb_hc editor matches 1.. run data modify storage rhythm_axe:prop btn_undo set value '{"text":"【撤销】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 8"},"hover_event":{"action":"show_text","value":"撤销上一步操作"}}'
# 可重做（光标 < 末尾）→ 重做按钮点亮
execute if data storage rhythm_axe:maps.editor feedback unless data storage rhythm_axe:maps.editor no_undo if score #fb_hc editor < #fb_hlen editor run data modify storage rhythm_axe:prop btn_redo set value '{"text":"【重做】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 9"},"hover_event":{"action":"show_text","value":"重做上一步操作"}}'
execute if data storage rhythm_axe:maps.editor feedback unless data storage rhythm_axe:maps.editor no_undo run function rhythm_axe:editor/menu/show_feedback_ with storage rhythm_axe:prop
# 先清理 prop（feedback 尚存在，条件成立）；最后才删 feedback/no_undo，避免成为死代码
execute if data storage rhythm_axe:maps.editor feedback run data remove storage rhythm_axe:prop fb
execute if data storage rhythm_axe:maps.editor feedback run data remove storage rhythm_axe:prop btn_undo
execute if data storage rhythm_axe:maps.editor feedback run data remove storage rhythm_axe:prop btn_redo
execute if data storage rhythm_axe:maps.editor feedback run data remove storage rhythm_axe:maps.editor feedback
execute if data storage rhythm_axe:maps.editor feedback run data remove storage rhythm_axe:maps.editor no_undo
# 清理可选计数标志（批量编辑数量反馈）
data remove storage rhythm_axe:prop fb_count
scoreboard players reset #fb_count editor
# 保险：清残留 no_undo / fb_redo（防异常路径残留影响下一次）
data remove storage rhythm_axe:maps.editor no_undo
data remove storage rhythm_axe:maps.editor fb_redo
