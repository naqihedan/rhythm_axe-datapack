#arg:glow_sel,minx,maxx,miny,maxy,minz,maxz,g_u
# 把黄绿玻璃更新为选区**盒子**（★ 2026-10-29 起支持亚方块精度）
#   盒子 = [min − g/2, max + g/2]（g = 网格尺寸 ×1000，宏参 g_u）
#   ⇒ 档 3（g=1000、角点 k+0.5）时盒子 = [k1, k2+1] ⇒ 宽 |Δ|+1、中心不变，
#      **与旧「整数方块 + 边长 n=max−min+1」实现逐位一致**（默认档零行为变化）
#   参数：minx..maxz = 两角 min/max（×1000）；g_u = 网格尺寸（×1000）
#   写法：全部走 `execute store result`（glow_note / axis_fx 已验证可用），不用临时 marker
# 先算盒子边界（与 select_inter 的判定范围共用同一份算法）
function rhythm_axe:editor/tool/select/select_box_bounds
scoreboard players operation #bx editor = #bh_x editor
scoreboard players operation #bx editor -= #bl_x editor
scoreboard players operation #by editor = #bh_y editor
scoreboard players operation #by editor -= #bl_y editor
scoreboard players operation #bz editor = #bh_z editor
scoreboard players operation #bz editor -= #bl_z editor
# 中心 ×1000 = (bl + bh) / 2（两数之和必为偶数：格距/半格都是整数毫米）
scoreboard players operation #ccx editor = #bl_x editor
scoreboard players operation #ccx editor += #bh_x editor
scoreboard players operation #ccx editor /= 2 const
scoreboard players operation #ccy editor = #bl_y editor
scoreboard players operation #ccy editor += #bh_y editor
scoreboard players operation #ccy editor /= 2 const
scoreboard players operation #ccz editor = #bl_z editor
scoreboard players operation #ccz editor += #bh_z editor
scoreboard players operation #ccz editor /= 2 const
# ★ 2026-10-29：实体 Pos 比视觉位置低 1 格（translation:[0,1,0] 补偿，防止点到 Axiom 的展示实体小工具）
#   ⇒ 写 Pos[1] 前把中心减 1000（= 1.00 格）；X/Z 不受影响
scoreboard players remove #ccy editor 1000
$execute store result entity @e[tag=$(glow_sel),limit=1] Pos[0] double 0.001 run scoreboard players get #ccx editor
$execute store result entity @e[tag=$(glow_sel),limit=1] Pos[1] double 0.001 run scoreboard players get #ccy editor
$execute store result entity @e[tag=$(glow_sel),limit=1] Pos[2] double 0.001 run scoreboard players get #ccz editor
$execute store result entity @e[tag=$(glow_sel),limit=1] transformation.scale[0] float 0.001 run scoreboard players get #bx editor
$execute store result entity @e[tag=$(glow_sel),limit=1] transformation.scale[1] float 0.001 run scoreboard players get #by editor
$execute store result entity @e[tag=$(glow_sel),limit=1] transformation.scale[2] float 0.001 run scoreboard players get #bz editor