#arg:minx,maxx,miny,maxy,minz,maxz
# @s = 音符交互实体（存在即活跃）：读 note_id + 当前位置 pos + size/2，判定在选区内则填 selection[] 并高亮
# 判定标准 = 交互实体 pos + size/2（随播放移动）；交互实体存在即活跃 → 天然只选活跃
execute store result score #tmp_nid editor run scoreboard players get @s note_id
execute store result score #px editor run data get entity @s Pos[0]
execute store result score #py editor run data get entity @s Pos[1]
execute store result score #pz editor run data get entity @s Pos[2]
# size/2（Y 校正）：交互实体 width = size
execute store result score #halfy editor run data get entity @s width 1000
scoreboard players operation #halfy editor /= 1000 const
scoreboard players operation #halfy editor /= 2 const
scoreboard players operation #py editor += #halfy editor
# 判定中心在选区内 → #hit
scoreboard players set #hit editor 0
$execute if score #px editor matches $(minx)..$(maxx) if score #py editor matches $(miny)..$(maxy) if score #pz editor matches $(minz)..$(maxz) run scoreboard players set #hit editor 1
# 命中：填 selection + 高亮展示实体 + 标记交互实体为已选中（供右击取消选中判定）
execute if score #hit editor matches 1 run execute store result storage rhythm_axe:prop nid int 1 run scoreboard players get @s note_id
execute if score #hit editor matches 1 run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get @s editor_n_idx
execute if score #hit editor matches 1 run function rhythm_axe:editor/menu/note/selected/sel_select_one with storage rhythm_axe:prop
execute if score #hit editor matches 1 run scoreboard players add #sel_count editor 1
execute if score #hit editor matches 1 run tag @s add editor_note_selected
execute if score #hit editor matches 1 run function rhythm_axe:editor/tool/select/select_mark_glow with storage rhythm_axe:prop
data remove storage rhythm_axe:prop nid
data remove storage rhythm_axe:prop idx
