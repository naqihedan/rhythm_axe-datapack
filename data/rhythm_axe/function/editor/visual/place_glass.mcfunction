# 玻璃（4）定位：@s = 展示实体；段①（playhead<=time）缓动出生→判定；段②（time<playhead）镜像缓动穿过
execute if score #playhead editor <= @s editor_n_time run scoreboard players set #seg editor 1
execute if score #playhead editor > @s editor_n_time run scoreboard players set #seg editor 2
execute if score #playhead editor <= @s editor_n_time run function rhythm_axe:editor/visual/place_glass_s1
execute if score #playhead editor > @s editor_n_time run function rhythm_axe:editor/visual/place_glass_s2
