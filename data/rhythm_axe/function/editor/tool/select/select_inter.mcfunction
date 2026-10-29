#arg:minx,maxx,miny,maxy,minz,maxz
# @s = 音符交互实体（存在即活跃）：读 note_id + 当前位置 pos + size/2，判定在选区内则填 selection[] 并高亮
# 判定标准 = 交互实体 pos + size/2（随播放移动）；交互实体存在即活跃 → 天然只选活跃
# ★ 2026-10-29：边界/坐标统一 ×1000（支持亚方块选区）。
#   宏观参数 minx..maxz 是「已乘 1000」的整数；g_u = 网格尺寸（×1000）。
#   判定范围 = **选区盒子** [min−g/2, max+g/2)（半开）—— 与预览玻璃看到的范围完全一致。
#   ⇒ 档 1（g=1000、角点 k+0.5）时盒子 = [k_min, k_max+1)，音符 x∈[k_min,k_max+1) ⟺ floor(x)∈[k_min,k_max]
#      ⇒ **与旧「整数方块号」判定逐位一致**（含旋转/镜像产生的非 .5 音符）。
function rhythm_axe:editor/tool/select/select_box_bounds
execute store result score #tmp_nid editor run scoreboard players get @s note_id
execute store result score #px editor run data get entity @s Pos[0] 1000
execute store result score #py editor run data get entity @s Pos[1] 1000
execute store result score #pz editor run data get entity @s Pos[2] 1000
# size/2（Y 校正，×1000）：交互实体 width = size
execute store result score #halfy editor run data get entity @s width 1000
scoreboard players operation #halfy editor /= 2 const
scoreboard players operation #py editor += #halfy editor
# 判定中心在盒子内 → #hit（半开区间：bl ≤ p < bh）
scoreboard players set #hit editor 1
execute if score #px editor < #bl_x editor run scoreboard players set #hit editor 0
execute if score #px editor >= #bh_x editor run scoreboard players set #hit editor 0
execute if score #hit editor matches 1 if score #py editor < #bl_y editor run scoreboard players set #hit editor 0
execute if score #hit editor matches 1 if score #py editor >= #bh_y editor run scoreboard players set #hit editor 0
execute if score #hit editor matches 1 if score #pz editor < #bl_z editor run scoreboard players set #hit editor 0
execute if score #hit editor matches 1 if score #pz editor >= #bh_z editor run scoreboard players set #hit editor 0
# 命中：填 selection + 高亮展示实体 + 标记交互实体为已选中（供右击取消选中判定）
execute if score #hit editor matches 1 run execute store result storage rhythm_axe:prop nid int 1 run scoreboard players get @s note_id
execute if score #hit editor matches 1 run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get @s editor_n_idx
execute if score #hit editor matches 1 run function rhythm_axe:editor/menu/note/selected/sel_select_one with storage rhythm_axe:prop
execute if score #hit editor matches 1 run scoreboard players add #sel_count editor 1
execute if score #hit editor matches 1 run tag @s add editor_note_selected
execute if score #hit editor matches 1 run function rhythm_axe:editor/tool/select/select_mark_glow with storage rhythm_axe:prop
data remove storage rhythm_axe:prop nid
data remove storage rhythm_axe:prop idx
