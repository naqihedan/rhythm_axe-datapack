#arg: x, y, z
# 对话框提交：「从」坐标（X Y Z）→ 写 editing.df.s_a_fp（百分之一格）
# ★ 校验（2026-10-17 重写）：三轴逐个验，任一为空/非数字/复合/列表即整体拒绝。
#   ① 裸 token 装进**列表**（`[$(x),$(y),$(z)]` 永远合法，空输入 → 元素缺失）⇒ 宏永不实例化失败
#   ② `data get … [n] 100`（**必须带 scale**）只接受数字 ⇒ store success 判定，短路链式（一个失败即中止）
#   ③ 旧的「无条件先打印无效」写法已删（它靠一句空 tellraw 遮丑，实际无效行始终留在聊天栏）
scoreboard players set #dlg_ok editor 0
data remove storage rhythm_axe:prop dlg_in
$data modify storage rhythm_axe:prop dlg_in set value [$(x),$(y),$(z)]
scoreboard players set #dlg_ok editor 0
execute store success score #dlg_ok editor run data get storage rhythm_axe:prop dlg_in[0] 100
execute if score #dlg_ok editor matches 1 run execute store success score #dlg_ok editor run data get storage rhythm_axe:prop dlg_in[1] 100
execute if score #dlg_ok editor matches 1 run execute store success score #dlg_ok editor run data get storage rhythm_axe:prop dlg_in[2] 100
execute if score #dlg_ok editor matches 0 run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"输入无效，请填数字（如 1.5 / -2 / 0）","color":"red"}]
scoreboard players set #dlg_v editor 0
execute if score #dlg_ok editor matches 1 run execute store result score #dlg_v editor run data get storage rhythm_axe:prop dlg_in[0] 100
execute if score #dlg_ok editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.df.s_a_fp[0] int 1 run scoreboard players get #dlg_v editor
execute if score #dlg_ok editor matches 1 run execute store result score #dlg_v editor run data get storage rhythm_axe:prop dlg_in[1] 100
execute if score #dlg_ok editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.df.s_a_fp[1] int 1 run scoreboard players get #dlg_v editor
execute if score #dlg_ok editor matches 1 run execute store result score #dlg_v editor run data get storage rhythm_axe:prop dlg_in[2] 100
execute if score #dlg_ok editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.df.s_a_fp[2] int 1 run scoreboard players get #dlg_v editor
execute if score #dlg_ok editor matches 1 run function rhythm_axe:editor/menu/note/df/df_render
data remove storage rhythm_axe:prop dlg_in
