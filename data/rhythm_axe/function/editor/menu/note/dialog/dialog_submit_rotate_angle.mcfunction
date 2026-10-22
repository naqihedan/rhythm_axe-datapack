#arg: value
# 外层「安全转发」（与数值类同款，2026-10-17 拆层约定）：
#   对话框软输入可能是 空 / 非法 SNBT（如 `12a`）/ 数字粘字母 —— 内层若因此**实例化失败**，整个内层不执行、
#   点【确认】毫无反应。⚠ 实测：**被调函数实例化失败不会中断调用者** ⇒ 用哨兵 #dlg_ok=9 兜底：
#   内层开头置 0；外层调用后仍为 9 ⇒ 内层没跑 ⇒ 补一句提示。故【确认】总有反馈（含未转义引号时除外）。
scoreboard players set #dlg_ok editor 9
$function rhythm_axe:editor/menu/note/dialog/dialog_submit_rotate_angle_core {"value":"$(value)"}
execute if score #dlg_ok editor matches 9 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"输入无效，请填角度（度，可带小数与负号，如 37.5 或 -12）","color":"red"}]
