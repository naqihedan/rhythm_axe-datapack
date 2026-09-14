#arg:cursor,i
# 向后查找宏叶子：探测 notes[$(i)]
#   越界（该下标无音符）→ #gnx_end=1（停止，B 不存在）
#   是普通音符（type 0..2）→ 读齐 B 的 id/time/出生点（position+start_pos，×100），#gnx_found=1、结束
#   是混凝土/玻璃（3/4）→ 跳过（不结束，驱动器继续往后走）
# 成本：每个被跳过的音符只需 1 条 data get；命中后约 12 条
# ★ 2026-09-14：同样只留 1 行宏（把元素复制到 prop.gnnote）—— 宏展开成本 ∝ 函数体内 $ 行数。
#   先删再复制，保证「下标越界」时复制失败能被 #gnx_ex 可靠检测到（否则会残留上一轮的旧值）。
data remove storage rhythm_axe:prop gnnote
$data modify storage rhythm_axe:prop gnnote set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(i)]
execute store success score #gnx_ex editor run execute store result score #gnx_ty editor run data get storage rhythm_axe:prop gnnote.type
execute if score #gnx_ex editor matches 0 run scoreboard players set #gnx_end editor 1
# 出生点：start_pos（缺省 0）×100 + position（缺省 0）×100
scoreboard players set #gnx_px editor 0
scoreboard players set #gnx_py editor 0
scoreboard players set #gnx_pz editor 0
scoreboard players set #gnx_sx editor 0
scoreboard players set #gnx_sy editor 0
scoreboard players set #gnx_sz editor 0
execute if score #gnx_ex editor matches 1 if score #gnx_ty editor matches 0..2 if data storage rhythm_axe:prop gnnote.position[0] run execute store result score #gnx_px editor run data get storage rhythm_axe:prop gnnote.position[0] 100
execute if score #gnx_ex editor matches 1 if score #gnx_ty editor matches 0..2 if data storage rhythm_axe:prop gnnote.position[1] run execute store result score #gnx_py editor run data get storage rhythm_axe:prop gnnote.position[1] 100
execute if score #gnx_ex editor matches 1 if score #gnx_ty editor matches 0..2 if data storage rhythm_axe:prop gnnote.position[2] run execute store result score #gnx_pz editor run data get storage rhythm_axe:prop gnnote.position[2] 100
execute if score #gnx_ex editor matches 1 if score #gnx_ty editor matches 0..2 if data storage rhythm_axe:prop gnnote.start_pos[0] run execute store result score #gnx_sx editor run data get storage rhythm_axe:prop gnnote.start_pos[0] 100
execute if score #gnx_ex editor matches 1 if score #gnx_ty editor matches 0..2 if data storage rhythm_axe:prop gnnote.start_pos[1] run execute store result score #gnx_sy editor run data get storage rhythm_axe:prop gnnote.start_pos[1] 100
execute if score #gnx_ex editor matches 1 if score #gnx_ty editor matches 0..2 if data storage rhythm_axe:prop gnnote.start_pos[2] run execute store result score #gnx_sz editor run data get storage rhythm_axe:prop gnnote.start_pos[2] 100
execute if score #gnx_ex editor matches 1 if score #gnx_ty editor matches 0..2 run scoreboard players operation #gnx_sx editor += #gnx_px editor
execute if score #gnx_ex editor matches 1 if score #gnx_ty editor matches 0..2 run scoreboard players operation #gnx_sy editor += #gnx_py editor
execute if score #gnx_ex editor matches 1 if score #gnx_ty editor matches 0..2 run scoreboard players operation #gnx_sz editor += #gnx_pz editor
execute if score #gnx_ex editor matches 1 if score #gnx_ty editor matches 0..2 run execute store result score #gnx_id editor run data get storage rhythm_axe:prop gnnote.id
execute if score #gnx_ex editor matches 1 if score #gnx_ty editor matches 0..2 run scoreboard players set #gnx_found editor 1
execute if score #gnx_ex editor matches 1 if score #gnx_ty editor matches 0..2 run execute store result score #gnx_time editor run data get storage rhythm_axe:prop gnnote.time
execute if score #gnx_ex editor matches 1 if score #gnx_ty editor matches 0..2 run scoreboard players set #gnx_end editor 1
