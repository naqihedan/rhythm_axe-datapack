# 统一定位：@s = 编辑器音符展示实体；按当前 playhead + 类型计算并写位置（生成后与播放 tick 共用）
# 实体计分板参数：editor_n_birth / editor_n_time / editor_n_end / editor_n_dist / editor_n_type
#                  editor_n_dur / editor_n_lt / editor_n_easing / editor_n_power / editor_n_len
# 类型：0/1/2 线性；4 玻璃两段缓动；3 混凝土三段（头线性 + 长条拉伸/停留/缩短）
# 算 prog（×1000，clamp）：出生 0 → 判定 1000
scoreboard players operation #prog editor = #playhead editor
scoreboard players operation #prog editor -= @s editor_n_birth
scoreboard players operation #prog editor *= 1000 const
scoreboard players operation #den editor = @s editor_n_time
scoreboard players operation #den editor -= @s editor_n_birth
execute if score #den editor matches 1.. run scoreboard players operation #prog editor /= #den editor
execute if score #den editor matches ..0 run scoreboard players set #prog editor 1000
execute if score #prog editor matches ..0 run scoreboard players set #prog editor 0
execute if score #prog editor matches 1001.. run scoreboard players set #prog editor 1000
# 段标记（调试用；普通=0，玻璃=1/2，混凝土=1/2/3）
scoreboard players set #seg editor 0
# 按类型分发
execute unless score @s editor_n_type matches 3 unless score @s editor_n_type matches 4 run function rhythm_axe:editor/visual/place_linear
execute if score @s editor_n_type matches 4 run function rhythm_axe:editor/visual/place_glass
execute if score @s editor_n_type matches 3 run function rhythm_axe:editor/visual/place_concrete
# ===== 交互实体跟随展示实体缓动头部（2026-08-26：读展示当前 translation/scale 沿 dir 换算；替代旧线性 #prog）=====
# 头端局部 z×100：#htz = trans[2]×100（普通/玻璃=位置；混凝土=中心+len/2=头端，★ 先 scale/2 再加，勿 (trans+scale)/2）
execute store result score #htz editor run data get entity @s transformation.translation[2] 100
execute if score @s editor_n_type matches 3 run execute store result score #hsz editor run data get entity @s transformation.scale[2] 100
execute if score @s editor_n_type matches 3 run scoreboard players operation #hsz editor /= 2 const
execute if score @s editor_n_type matches 3 run scoreboard players operation #htz editor += #hsz editor
# ★ 混凝土：交互实体往出生方向回退 size/2（对准长条身体而非头端，避免交互只包住 50%）
#   #hsz 复用：size/2×100 = editor_n_size/20（editor_n_size = size×1000）
execute if score @s editor_n_type matches 3 run scoreboard players operation #hsz editor = @s editor_n_size
execute if score @s editor_n_type matches 3 run scoreboard players operation #hsz editor /= 20 const
execute if score @s editor_n_type matches 3 run scoreboard players operation #htz editor -= #hsz editor
# 交互 = 判定 + 头端偏移×dir；dir = -start/dist → 交互(×1000) = 判定(×1000) - htz×start(×1000)/dist(×100)
scoreboard players operation #ix editor = @s editor_n_px
scoreboard players operation #it editor = @s editor_n_sx
scoreboard players operation #it editor *= #htz editor
scoreboard players operation #it editor /= @s editor_n_dist
scoreboard players operation #it editor *= -1 const
scoreboard players operation #ix editor += #it editor
scoreboard players operation #iy editor = @s editor_n_py
scoreboard players operation #it2 editor = @s editor_n_sy
scoreboard players operation #it2 editor *= #htz editor
scoreboard players operation #it2 editor /= @s editor_n_dist
scoreboard players operation #it2 editor *= -1 const
scoreboard players operation #iy editor += #it2 editor
# ★ 2026-08-25 交互实体 Y 减 size/2：interaction 定位在方块底部（展示实体中心在判定 Y 处）
scoreboard players operation #it2 editor = @s editor_n_size
scoreboard players operation #it2 editor /= 2 const
scoreboard players operation #iy editor -= #it2 editor
scoreboard players operation #iz editor = @s editor_n_pz
scoreboard players operation #it3 editor = @s editor_n_sz
scoreboard players operation #it3 editor *= #htz editor
scoreboard players operation #it3 editor /= @s editor_n_dist
scoreboard players operation #it3 editor *= -1 const
scoreboard players operation #iz editor += #it3 editor
# 配对同 note_id 的交互实体写 Pos（×1000 → double）
scoreboard players operation #iid editor = @s note_id
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #iid editor run execute store result entity @s Pos[0] double 0.001 run scoreboard players get #ix editor
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #iid editor run execute store result entity @s Pos[1] double 0.001 run scoreboard players get #iy editor
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #iid editor run execute store result entity @s Pos[2] double 0.001 run scoreboard players get #iz editor
# ★ 快照"应该在的位置"到交互实体（Axiom 偏移检测用；每次 place 覆写）
#   交互实体实际 Pos 被 Axiom 移动后，其与 editor_should_x/y/z 的差 = 手动偏移，shift+左击时读到判定位置
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #iid editor run data merge entity @s {data:{editor_should_x:0.0d,editor_should_y:0.0d,editor_should_z:0.0d}}
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #iid editor run execute store result entity @s data.editor_should_x double 0.001 run scoreboard players get #ix editor
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #iid editor run execute store result entity @s data.editor_should_y double 0.001 run scoreboard players get #iy editor
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #iid editor run execute store result entity @s data.editor_should_z double 0.001 run scoreboard players get #iz editor
# 存展示实体当前视觉中心（×1000；y 恢复中心 = 交互脚底 + size/2；引导线/后续读取用）
scoreboard players operation @s editor_n_vx = #ix editor
scoreboard players operation @s editor_n_vy = #iy editor
scoreboard players operation #tmp_v editor = @s editor_n_size
scoreboard players operation #tmp_v editor /= 2 const
scoreboard players operation @s editor_n_vy += #tmp_v editor
scoreboard players operation @s editor_n_vz = #iz editor

# ===== 调试 lv.2：每次刷新输出音符 id / type / translation（混凝土额外输出 scale）=====
execute if score debug_output options matches 2.. run tellraw @a ["",{"text":"[调试.lv2][音符] ","color":"dark_green"},{"text":" id=","color":"gray"},{"score":{"objective":"note_id","name":"@s"},"color":"white"},{"text":" type=","color":"gray"},{"score":{"objective":"editor_n_type","name":"@s"},"color":"white"},{"text":"  trans=","color":"gray"},{"nbt":"transformation.translation[0]","entity":"@s","color":"aqua"},{"text":",","color":"gray"},{"nbt":"transformation.translation[1]","entity":"@s","color":"aqua"},{"text":",","color":"gray"},{"nbt":"transformation.translation[2]","entity":"@s","color":"aqua"}]
execute if score debug_output options matches 2.. if score @s editor_n_type matches 3 run tellraw @a ["",{"text":"[调试.lv2][音符] ","color":"dark_green"},{"text":"  scale=","color":"gray"},{"nbt":"transformation.scale[0]","entity":"@s","color":"light_purple"},{"text":",","color":"gray"},{"nbt":"transformation.scale[1]","entity":"@s","color":"light_purple"},{"text":",","color":"gray"},{"nbt":"transformation.scale[2]","entity":"@s","color":"light_purple"}]
