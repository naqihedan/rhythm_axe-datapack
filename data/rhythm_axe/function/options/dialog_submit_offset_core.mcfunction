#arg: value, mute_hs
# 对话框提交：全局音乐偏移（整数，-500~500 ms）→ 写 options.music_offset，再重绘设置面板
# ★ 2026-10-17：新增复选框 mute_hs（「同时禁用音符击打音效」，**默认不勾选**）——
#   勾选（"1"）→ options.hitsound_on = 0（禁用打击音）；**不勾选（"0"）→ 不改动**
#   （语义 = 「勾上才去禁用」；不勾就不干预，避免“本来已禁用、只调个偏移却被自动启用”）
# ★ 校验思路（不照抄编辑器 df 那套「无条件打印输入无效 + 非数字静默写错值」的缺陷写法）：
#   1) 先用 `data modify ... set value [$(value)]` 把输入原样装进**列表** —— 裸 token 永远能解析
#      （数字→int、非数字→字符串、**空输入→空列表**），所以宏函数不会实例化失败（确认按钮总会有反应）。
#      ⚠️ 不能直接 `$scoreboard players set #op_in menu $(value)`：非数字/空输入会让整条宏解析失败
#         → 整个函数实例化失败 → 点了「确认」毫无反应（连提示都没有）。
#      ⚠️ 也不能直接 `set value $(value)`（不带列表）：**空输入**同样会让整条 set 失败 → 同一后果。
#   2) 再用 `data get ... in[0] 1`（**必须带 scale**）取回：数字成功、字符串/空失败 ⇒ 用 `store success` 判定。
#      ⚠️ 2026-10-14 实测踩坑：SNBT 允许**不带引号的字符串**（abc 是合法字符串！），
#         不带 scale 的 `data get` 对字符串会成功并返回**字符串长度**（"abc" → 3）⇒ 校验被骗过。
#         带 scale 的 data get 只接受数字（字符串报「无法将字符串乘以 scale」）⇒ 才能正确拒绝。
#         小数（12.5）带 scale 成功、store result 截断为整数（12），符合「填整数」的预期。
scoreboard players set #dlg_ok editor 0
data remove storage rhythm_axe:prop in
$data modify storage rhythm_axe:prop in set value [$(value)]
scoreboard players set #op_ok menu 0
scoreboard players set #op_in menu 0
execute store result score #op_in menu store success score #op_ok menu run data get storage rhythm_axe:prop in[0] 1
# 无效（非数字）：提示后重绘（值不变）
execute if score #op_ok menu matches 0 run tellraw @s [{"text":"[设置] ","color":"gray"},{"text":"输入无效，请填整数（-500 ~ 500）","color":"red"}]
# 有效：钳到 [-500,500] → 写入 → 反馈
execute if score #op_ok menu matches 1 if score #op_in menu matches ..-501 run scoreboard players set #op_in menu -500
execute if score #op_ok menu matches 1 if score #op_in menu matches 501.. run scoreboard players set #op_in menu 500
execute if score #op_ok menu matches 1 run scoreboard players operation music_offset options = #op_in menu
execute if score #op_ok menu matches 1 run tellraw @s [{"text":"[设置] ","color":"gray"},{"text":"全局音乐偏移 = ","color":"green"},{"score":{"name":"music_offset","objective":"options"},"color":"white"},{"text":" ms","color":"green"}]
# ★ 复选框 mute_hs：勾选（"1"）→ 禁用打击音（hitsound_on=0）；不勾（"0"）→ **不改动**
#   on_true/on_false = "1"/"0"（裸数字 token）⇒ 直接 set 到临时分数再判
#   （缺参/异常时宏展开失败 → #op_mute 保持 0 = 不干预，保守处理）
scoreboard players set #op_mute menu 0
$scoreboard players set #op_mute menu $(mute_hs)
execute if score #op_mute menu matches 1 run scoreboard players set hitsound_on options 0
data remove storage rhythm_axe:prop in
# ★ 按来源重绘（2026-10-17：编辑器主菜单行 110 也复用本对话框）：
#   prop.offset_ui 存在 = 从编辑器打开的 → 重绘编辑器主菜单；否则 = 设置面板 → 重绘设置面板
scoreboard players set #op_from editor 0
execute if data storage rhythm_axe:prop offset_ui run scoreboard players set #op_from editor 1
data remove storage rhythm_axe:prop offset_ui
execute if score #op_from editor matches 1 run schedule function rhythm_axe:editor/menu/main_next 1t
execute if score #op_from editor matches 0 run function rhythm_axe:options/render
