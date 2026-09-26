# 射线单步（@s = 探针，at @s 由 ray_drive 保证；前置：#coop_hit=0）
# ① 命中判定：以探针为中心 1³ 格（positioned -0.5 + dx/dy/dz=0 ⇒ 覆盖 1 格、按 hitbox 相交）
execute positioned ~-0.5 ~-0.5 ~-0.5 if entity @a[tag=!coop_self,dx=0,dy=0,dz=0,sort=nearest,limit=1] run scoreboard players set #coop_hit editor 1
execute if score #coop_hit editor matches 1 positioned ~-0.5 ~-0.5 ~-0.5 as @a[tag=!coop_self,dx=0,dy=0,dz=0,sort=nearest,limit=1] run function rhythm_axe:editor/tool/coop/hit_one
# ② 未命中才前进 0.4 格（^ 相对探针自身朝向 = 使用者的视线方向）
execute if score #coop_hit editor matches 0 run tp @s ^ ^ ^0.4
