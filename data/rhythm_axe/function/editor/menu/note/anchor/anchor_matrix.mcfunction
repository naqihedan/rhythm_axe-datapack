# 读锚点 transformation.left_rotation（4 个 float）+ transformation.scale[0] → 变换矩阵 #r11..#r33（×10000 定点整数）
# ★ 缩放（2026-09-18 新增，**三轴独立**）：矩阵按列分别乘「锚点 scale[j] × 4」（R' = R·S，S = diag(sx,sy,sz)）—— 默认 scale 0.25 ⇒ 各轴 ×1（不缩放）
# 公式（q = x,y,z,w 单位四元数；右手法、几何主动旋转 —— 与 note_panel_rotate_apply_one 的 cos/sin 同向，已用 Y 轴 90° 数值对拍验证）：
#   R = [ 1-2(y²+z²),  2(xy-wz)  ,  2(xz+wy)  ]
#       [ 2(xy+wz)  ,  1-2(x²+z²),  2(yz-wx)  ]
#       [ 2(xz-wy)  ,  2(yz+wx)  ,  1-2(x²+y²)]
# 定点：q 读 ×10000；先乘（≤1e8）、相加（≤2e8）、再除 10000 ⇒ 矩阵分辨率 1e-4（位置本来只落 0.01）
#   ⚠️ 溢出检查：q 分量 ≤1e4 ⇒ 两分量乘积 ≤1e8、二者和 ≤2e8 ⇒ 全程远小于 2^31 ✓
# 前置：锚点实体存在（tag editor_anchor，anchor_read 已确认）；本函数只写 #q*/#a/#b/#s/#t/#r*/#scl1/#scl2/#scl3
# 缺 left_rotation 时保持默认单位四元数（= 不旋转）
scoreboard players set #q1 editor 0
scoreboard players set #q2 editor 0
scoreboard players set #q3 editor 0
scoreboard players set #q4 editor 10000
execute store result score #q1 editor run data get entity @e[tag=editor_anchor,type=item_display,limit=1] transformation.left_rotation[0] 10000
execute store result score #q2 editor run data get entity @e[tag=editor_anchor,type=item_display,limit=1] transformation.left_rotation[1] 10000
execute store result score #q3 editor run data get entity @e[tag=editor_anchor,type=item_display,limit=1] transformation.left_rotation[2] 10000
execute store result score #q4 editor run data get entity @e[tag=editor_anchor,type=item_display,limit=1] transformation.left_rotation[3] 10000
# —— 对角项：R11 = 1-2(y²+z²) / R22 = 1-2(x²+z²) / R33 = 1-2(x²+y²) ——
scoreboard players operation #t editor = #q2 editor
scoreboard players operation #t editor *= #q2 editor
scoreboard players operation #s editor = #q3 editor
scoreboard players operation #s editor *= #q3 editor
scoreboard players operation #t editor += #s editor
scoreboard players operation #t editor /= 10000 const
scoreboard players operation #t editor *= 2 const
scoreboard players set #r11 editor 10000
scoreboard players operation #r11 editor -= #t editor
scoreboard players operation #t editor = #q1 editor
scoreboard players operation #t editor *= #q1 editor
scoreboard players operation #t editor += #s editor
scoreboard players operation #t editor /= 10000 const
scoreboard players operation #t editor *= 2 const
scoreboard players set #r22 editor 10000
scoreboard players operation #r22 editor -= #t editor
scoreboard players operation #t editor = #q1 editor
scoreboard players operation #t editor *= #q1 editor
scoreboard players operation #s editor = #q2 editor
scoreboard players operation #s editor *= #q2 editor
scoreboard players operation #t editor += #s editor
scoreboard players operation #t editor /= 10000 const
scoreboard players operation #t editor *= 2 const
scoreboard players set #r33 editor 10000
scoreboard players operation #r33 editor -= #t editor
# —— 非对角项（共用 #a = 前一项乘积、#b = 后一项乘积）——
scoreboard players operation #a editor = #q1 editor
scoreboard players operation #a editor *= #q2 editor
scoreboard players operation #b editor = #q4 editor
scoreboard players operation #b editor *= #q3 editor
scoreboard players operation #r12 editor = #a editor
scoreboard players operation #r12 editor -= #b editor
scoreboard players operation #r12 editor /= 10000 const
scoreboard players operation #r12 editor *= 2 const
scoreboard players operation #r21 editor = #a editor
scoreboard players operation #r21 editor += #b editor
scoreboard players operation #r21 editor /= 10000 const
scoreboard players operation #r21 editor *= 2 const
scoreboard players operation #a editor = #q1 editor
scoreboard players operation #a editor *= #q3 editor
scoreboard players operation #b editor = #q4 editor
scoreboard players operation #b editor *= #q2 editor
scoreboard players operation #r13 editor = #a editor
scoreboard players operation #r13 editor += #b editor
scoreboard players operation #r13 editor /= 10000 const
scoreboard players operation #r13 editor *= 2 const
scoreboard players operation #r31 editor = #a editor
scoreboard players operation #r31 editor -= #b editor
scoreboard players operation #r31 editor /= 10000 const
scoreboard players operation #r31 editor *= 2 const
scoreboard players operation #a editor = #q2 editor
scoreboard players operation #a editor *= #q3 editor
scoreboard players operation #b editor = #q4 editor
scoreboard players operation #b editor *= #q1 editor
scoreboard players operation #r23 editor = #a editor
scoreboard players operation #r23 editor -= #b editor
scoreboard players operation #r23 editor /= 10000 const
scoreboard players operation #r23 editor *= 2 const
scoreboard players operation #r32 editor = #a editor
scoreboard players operation #r32 editor += #b editor
scoreboard players operation #r32 editor /= 10000 const
scoreboard players operation #r32 editor *= 2 const
# —— 缩放：把「锚点 scale ×4」**按三轴分别**折进矩阵（R' = R·S，S = diag(sx,sy,sz)，均以 1e4 为单位）——
#   做法 = 「矩阵的第 j 列整体乘 s_j」：等价于先把 (P−C) 各轴分别按 s 缩放、再旋转 + 平移
#   默认 scale [0.25,0.25,0.25] ⇒ 各轴 2500×4 = 10000 ⇒ ×1（不缩放）；某轴设 0.5 ⇒ 该轴 ×2、0.125 ⇒ ×0.5
#   夹取：逐轴读失败 ⇒ 兜底 2500（= 默认 0.25，⇒ ×1）；某轴 ≤ 0 ⇒ 该轴当 ×1（免得把选区压成一条线）；
#         每轴上限 4 倍（scale ≤ 1.0）—— 折进后矩阵项 ≤ 4e4，配合 |Δ| ≤ 100 格时
#         定点乘积 ≤ 4e8、三轴和 ≤ 1.2e9 < 2^31 ✓（再大就有溢出风险，所以夹住）
#   注意 ×4 是「换算基准」：scale 是展示实体的显示大小，0.25 是数据包给锚点的默认边长
scoreboard players set #scl1 editor 2500
scoreboard players set #scl2 editor 2500
scoreboard players set #scl3 editor 2500
execute store result score #scl1 editor run data get entity @e[tag=editor_anchor,type=item_display,limit=1] transformation.scale[0] 10000
execute store result score #scl2 editor run data get entity @e[tag=editor_anchor,type=item_display,limit=1] transformation.scale[1] 10000
execute store result score #scl3 editor run data get entity @e[tag=editor_anchor,type=item_display,limit=1] transformation.scale[2] 10000
scoreboard players operation #scl1 editor *= 4 const
scoreboard players operation #scl2 editor *= 4 const
scoreboard players operation #scl3 editor *= 4 const
execute if score #scl1 editor matches ..0 run scoreboard players set #scl1 editor 10000
execute if score #scl2 editor matches ..0 run scoreboard players set #scl2 editor 10000
execute if score #scl3 editor matches ..0 run scoreboard players set #scl3 editor 10000
execute if score #scl1 editor matches 40001.. run scoreboard players set #scl1 editor 40000
execute if score #scl2 editor matches 40001.. run scoreboard players set #scl2 editor 40000
execute if score #scl3 editor matches 40001.. run scoreboard players set #scl3 editor 40000
# —— 第 1 列（x 列）乘 #scl1 ——
scoreboard players operation #r11 editor *= #scl1 editor
scoreboard players operation #r11 editor /= 10000 const
scoreboard players operation #r21 editor *= #scl1 editor
scoreboard players operation #r21 editor /= 10000 const
scoreboard players operation #r31 editor *= #scl1 editor
scoreboard players operation #r31 editor /= 10000 const
# —— 第 2 列（y 列）乘 #scl2 ——
scoreboard players operation #r12 editor *= #scl2 editor
scoreboard players operation #r12 editor /= 10000 const
scoreboard players operation #r22 editor *= #scl2 editor
scoreboard players operation #r22 editor /= 10000 const
scoreboard players operation #r32 editor *= #scl2 editor
scoreboard players operation #r32 editor /= 10000 const
# —— 第 3 列（z 列）乘 #scl3 ——
scoreboard players operation #r13 editor *= #scl3 editor
scoreboard players operation #r13 editor /= 10000 const
scoreboard players operation #r23 editor *= #scl3 editor
scoreboard players operation #r23 editor /= 10000 const
scoreboard players operation #r33 editor *= #scl3 editor
scoreboard players operation #r33 editor /= 10000 const
