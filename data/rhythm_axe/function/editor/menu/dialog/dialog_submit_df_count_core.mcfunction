#arg: value
# 对话框提交：每段插入个数（1~99）
# ★ 校验（2026-10-17 重写）：软输入可能为空 / 非数字 / 复合 / 列表。
#   ① 裸 token 装进**列表**（`[$(value)]` 永远合法，空输入 → `[]`）⇒ 宏永不实例化失败（点确认总有反应）
#   ② `data get … [0] 1`（**必须带 scale**）只接受数字 ⇒ 用 store success 判定
#      ⚠ 不带 scale 会把 SNBT 字符串当成功并返回**字符串长度**（"abc"→3），旧写法就是这个坑
scoreboard players set #dlg_ok editor 0
data remove storage rhythm_axe:prop dlg_in
$data modify storage rhythm_axe:prop dlg_in set value [$(value)]
scoreboard players set #dlg_ok editor 0
scoreboard players set #dlg_v editor 0
execute store result score #dlg_v editor store success score #dlg_ok editor run data get storage rhythm_axe:prop dlg_in[0] 1
data remove storage rhythm_axe:prop dlg_in
execute if score #dlg_ok editor matches 0 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"输入无效，请填数字（1~99）","color":"red"}]
execute if score #dlg_ok editor matches 1 if score #dlg_v editor matches ..0 run scoreboard players set #dlg_v editor 1
execute if score #dlg_ok editor matches 1 if score #dlg_v editor matches 100.. run scoreboard players set #dlg_v editor 99
execute if score #dlg_ok editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.df.cnt int 1 run scoreboard players get #dlg_v editor
execute if score #dlg_ok editor matches 1 run function rhythm_axe:editor/menu/note/df/df_render
