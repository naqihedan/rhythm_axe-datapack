#arg:value
# 查找音符提交：按 id 遍历输出结果
# ★ 校验（2026-10-17）：空 / 非数字会让 `$scoreboard players set #target_id editor $(value)` 整条失败
#   ⇒ 整个函数不执行。改为：列表包裹 + `data get … [0] 1`（带 scale）验数字。
scoreboard players set #dlg_ok editor 0
data remove storage rhythm_axe:prop dlg_in
$data modify storage rhythm_axe:prop dlg_in set value [$(value)]
scoreboard players set #dlg_ok editor 0
scoreboard players set #target_id editor 0
execute store result score #target_id editor store success score #dlg_ok editor run data get storage rhythm_axe:prop dlg_in[0] 1
data remove storage rhythm_axe:prop dlg_in
execute if score #dlg_ok editor matches 0 run tellraw @s [{"text":"[查找] ","color":"gray"},{"text":"输入无效，请填数字（音符 id）","color":"red"}]
execute if score #dlg_ok editor matches 1 run function rhythm_axe:editor/menu/find/find_note_prep
data remove storage rhythm_axe:maps.editor editing
