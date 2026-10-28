#arg: value
# ★ 外层「安全转发」（照 dialog_submit_end_time）：json 提交的软输入可能是 `12a` 这种**非法 SNBT**
#   ⇒ 内层直接在宏行里写 `set value [$(value)]` 会实例化失败（点确认毫无反应）。
#   本层把参数嵌进 JSON 字符串（{value:"..."}）⇒ 任何内容都合法；用哨兵 #dlg_ok=9 判断内层是否真的跑了。
scoreboard players set #dlg_ok editor 9
$function rhythm_axe:editor/menu/dialog/dialog_submit_music_offset_core {"value":"$(value)"}
execute if score #dlg_ok editor matches 9 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"输入无效，请填非负整数（毫秒）","color":"red"}]