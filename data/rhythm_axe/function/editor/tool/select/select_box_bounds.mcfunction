# 选区盒子边界（就地由 #minx..#maxz + #g_u 算出 #bl_x/#bh_x/#bl_y/#bh_y/#bl_z/#bh_z，×1000）
#   盒子 = [min − g/2, max + g/2]
#   ★ 统一的「选区 = 你看到的盒子」口径：
#      · 档 1（g=1000、角点 k+0.5）⇒ 盒子 = [k_min, k_max+1]
#        ~ 玻璃：中心 (k_min+k_max+1)/2、缩放 k_max−k_min+1 ⇒ **与旧整数方块实现逐位一致**
#        ~ 判定：音符 x ∈ [k_min, k_max+1) ⟺ floor(x) ∈ [k_min, k_max] ⇒ **与旧判定逐位一致**
#          （对旋转/镜像产生的非 .5 音符也一致，所以档 1 是严格零回归）
#   g/2 恒为整数（g ∈ {100,250,500,1000} ⇒ 半格 {50,125,250,500}），无取整误差
scoreboard players operation #g_half editor = #g_u editor
scoreboard players operation #g_half editor /= 2 const
scoreboard players operation #bl_x editor = #minx editor
scoreboard players operation #bl_x editor -= #g_half editor
scoreboard players operation #bh_x editor = #maxx editor
scoreboard players operation #bh_x editor += #g_half editor
scoreboard players operation #bl_y editor = #miny editor
scoreboard players operation #bl_y editor -= #g_half editor
scoreboard players operation #bh_y editor = #maxy editor
scoreboard players operation #bh_y editor += #g_half editor
scoreboard players operation #bl_z editor = #minz editor
scoreboard players operation #bl_z editor -= #g_half editor
scoreboard players operation #bh_z editor = #maxz editor
scoreboard players operation #bh_z editor += #g_half editor