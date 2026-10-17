#arg: value
# 对话框提交：间隔（两颗之间空几刻，0~9999；0 = 每刻一颗）
# ★ 校验（2026-10-17 重写）：同 df_count —— 列表包裹 + `data get … 1`（带 scale）+ store success
#   （空 / 非数字 / 复合 / 列表 一律判为无效并提示，不再把字符串长度当成数字写进去）
scoreboard players set #dlg_ok editor 0
data remove storage rhythm_axe:prop dlg_in
$data modify storage rhythm_axe:prop dlg_in set value [$(value)]
scoreboard players set #dlg_ok editor 0
scoreboard players set #dlg_v editor 0
execute store result score #dlg_v editor store success score #dlg_ok editor run data get storage rhythm_axe:prop dlg_in[0] 1
data remove storage rhythm_axe:prop dlg_in
execute if score #dlg_ok editor matches 0 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"输入无效，请填数字（0~9999）","color":"red"}]
execute if score #dlg_ok editor matches 1 if score #dlg_v editor matches ..-1 run scoreboard players set #dlg_v editor 0
execute if score #dlg_ok editor matches 1 if score #dlg_v editor matches 10000.. run scoreboard players set #dlg_v editor 9999
execute if score #dlg_ok editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.df.stp int 1 run scoreboard players get #dlg_v editor
execute if score #dlg_ok editor matches 1 run function rhythm_axe:editor/menu/note/df/df_render
