#arg:minx,maxx,miny,maxy,minz,maxz
# 选区判定：遍历音符交互实体（存在即活跃），读 note_id + pos+size/2，在选区内则填 selection[] 并高亮
# 直接遍历交互实体，无需 note_id 匹配（交互实体自带 note_id）
execute as @e[type=interaction,tag=editor_note] run function rhythm_axe:editor/tool/select/select_inter with storage rhythm_axe:prop
