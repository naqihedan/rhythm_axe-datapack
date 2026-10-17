#arg: x, y, z
# 对话框提交：「到」坐标（X Y Z）→ 写 editing.df.s_b_fp（百分之一格）
# ★ 校验（2026-10-17 重写）：同 df_from —— 列表包裹 + `data get … [n] 100`（带 scale）+ store success 短路链
scoreboard players set #dlg_ok editor 0
data remove storage rhythm_axe:prop dlg_in
$data modify storage rhythm_axe:prop dlg_in set value [$(x),$(y),$(z)]
scoreboard players set #dlg_ok editor 0
execute store success score #dlg_ok editor run data get storage rhythm_axe:prop dlg_in[0] 100
execute if score #dlg_ok editor matches 1 run execute store success score #dlg_ok editor run data get storage rhythm_axe:prop dlg_in[1] 100
execute if score #dlg_ok editor matches 1 run execute store success score #dlg_ok editor run data get storage rhythm_axe:prop dlg_in[2] 100
execute if score #dlg_ok editor matches 0 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"输入无效，请填数字（如 5 / 1.5 / 0）","color":"red"}]
scoreboard players set #dlg_v editor 0
execute if score #dlg_ok editor matches 1 run execute store result score #dlg_v editor run data get storage rhythm_axe:prop dlg_in[0] 100
execute if score #dlg_ok editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.df.s_b_fp[0] int 1 run scoreboard players get #dlg_v editor
execute if score #dlg_ok editor matches 1 run execute store result score #dlg_v editor run data get storage rhythm_axe:prop dlg_in[1] 100
execute if score #dlg_ok editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.df.s_b_fp[1] int 1 run scoreboard players get #dlg_v editor
execute if score #dlg_ok editor matches 1 run execute store result score #dlg_v editor run data get storage rhythm_axe:prop dlg_in[2] 100
execute if score #dlg_ok editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.df.s_b_fp[2] int 1 run scoreboard players get #dlg_v editor
execute if score #dlg_ok editor matches 1 run function rhythm_axe:editor/menu/note/df/df_render
data remove storage rhythm_axe:prop dlg_in
