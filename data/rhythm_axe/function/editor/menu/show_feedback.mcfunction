# 面板操作反馈：清屏后、面板内容前显示（黄色纯文本；宏插入，无 nbt 引号问题）
# 反馈后附【撤销】/【重做】按钮（行为一致：撤销/重做最新操作）
# ★ 按钮决定逻辑（2026-08-28 重构，弃 fb_redo 标记）：按历史光标位置动态判断
#   - history_cursor < history 长度-1（已撤销，有可重做）→ 弹【重做】(btn 9)
#   - 否则（光标在末尾 = 刚做了新操作/重做，有可撤销）→ 弹【撤销】(btn 8)
# no_undo 标记存在 → 纯文本反馈（不附按钮）：用于不产生撤销/重做的操作（保存、改名、设置暂存等）
execute if data storage rhythm_axe:maps.editor feedback run data modify storage rhythm_axe:prop fb set from storage rhythm_axe:maps.editor feedback
# no_undo → 纯文本反馈
execute if data storage rhythm_axe:maps.editor feedback if data storage rhythm_axe:maps.editor no_undo run function rhythm_axe:editor/menu/show_feedback_text with storage rhythm_axe:prop
# 计算可重做性：可重做 = history_cursor < history 长度-1
execute if data storage rhythm_axe:maps.editor feedback unless data storage rhythm_axe:maps.editor no_undo run execute store result score #fb_hc editor run data get storage rhythm_axe:maps.editor history_cursor
execute if data storage rhythm_axe:maps.editor feedback unless data storage rhythm_axe:maps.editor no_undo run execute store result score #fb_hlen editor run data get storage rhythm_axe:maps.editor history
execute if data storage rhythm_axe:maps.editor feedback unless data storage rhythm_axe:maps.editor no_undo run scoreboard players remove #fb_hlen editor 1
# 可重做（已撤销）→ 【重做】
execute if data storage rhythm_axe:maps.editor feedback unless data storage rhythm_axe:maps.editor no_undo if score #fb_hc editor < #fb_hlen editor run data modify storage rhythm_axe:prop btn_label set value "【重做】"
execute if data storage rhythm_axe:maps.editor feedback unless data storage rhythm_axe:maps.editor no_undo if score #fb_hc editor < #fb_hlen editor run data modify storage rhythm_axe:prop btn_val set value 9
# 否则（末尾 = 新操作/重做）→ 【撤销】
execute if data storage rhythm_axe:maps.editor feedback unless data storage rhythm_axe:maps.editor no_undo unless score #fb_hc editor < #fb_hlen editor run data modify storage rhythm_axe:prop btn_label set value "【撤销】"
execute if data storage rhythm_axe:maps.editor feedback unless data storage rhythm_axe:maps.editor no_undo unless score #fb_hc editor < #fb_hlen editor run data modify storage rhythm_axe:prop btn_val set value 8
execute if data storage rhythm_axe:maps.editor feedback unless data storage rhythm_axe:maps.editor no_undo run function rhythm_axe:editor/menu/show_feedback_ with storage rhythm_axe:prop
# 先清理 prop（feedback 尚存在，条件成立）；最后才删 feedback/no_undo，避免成为死代码
execute if data storage rhythm_axe:maps.editor feedback run data remove storage rhythm_axe:prop fb
execute if data storage rhythm_axe:maps.editor feedback run data remove storage rhythm_axe:prop btn_label
execute if data storage rhythm_axe:maps.editor feedback run data remove storage rhythm_axe:prop btn_val
execute if data storage rhythm_axe:maps.editor feedback run data remove storage rhythm_axe:maps.editor feedback
execute if data storage rhythm_axe:maps.editor feedback run data remove storage rhythm_axe:maps.editor no_undo
# 清理可选计数标志（批量编辑数量反馈）
data remove storage rhythm_axe:prop fb_count
scoreboard players reset #fb_count editor
# 保险：清残留 no_undo / fb_redo（防异常路径残留影响下一次）
data remove storage rhythm_axe:maps.editor no_undo
data remove storage rhythm_axe:maps.editor fb_redo
