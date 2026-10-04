# 交互实体跟随更新（O(1) tag 查找）——由 place 在「需要跟随」时调用
# 前置：place 已算好 #ix/#iy/#iz（世界坐标 ×1000）；@s = 音符展示实体
execute store result storage rhythm_axe:prop pnid int 1 run scoreboard players get @s note_id
function rhythm_axe:editor/visual/place_inter_pair with storage rhythm_axe:prop
