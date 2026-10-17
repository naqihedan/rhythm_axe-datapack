#arg: x,y,z
# ★ 外层「安全转发」（2026-10-17 拆层）：json 提交的软输入可能是 `12a` 这种**非法 SNBT** ——
#   若内层直接在宏行里写 `set value [$(value)]`，内层会**实例化失败**（整个内层不执行，点确认毫无反应）。
#   ⚠ 实测事实：**被调函数实例化失败不会中断调用者** ⇒ 本层用哨兵 #dlg_ok=9 判断「内层压根没跑」：
#     内层开头会把它置 0；外层调用后仍是 9 ⇒ 内层没跑 ⇒ 补一句提示。故【确认】总会有反馈。
#   本层唯一的宏行把参数嵌进 **JSON 字符串**（`{value:"..."}`）—— 任何内容都合法（除非含未转义引号）⇒ 本层永不失败。
scoreboard players set #dlg_ok editor 9
$function rhythm_axe:editor/menu/dialog/dialog_submit_df_from_core {"x":"$(x)","y":"$(y)","z":"$(z)"}
execute if score #dlg_ok editor matches 9 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"输入无效，请填数字（如 1.5 / -2 / 0）","color":"red"}]
