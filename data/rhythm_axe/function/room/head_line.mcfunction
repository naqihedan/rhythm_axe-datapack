#arg: room_mapid
# 房间页页头第一层（宏叶子，payload 来自 rhythm_axe:map_list）：取标题/作者 → 归一出组件 → 转第二层输出
#   顺带把 #rm_x（= 该谱面 player_count）算好：缺字段/非正数一律按 1（与格式默认值一致）
data remove storage rhythm_axe:prop title
data remove storage rhythm_axe:prop artist
data remove storage rhythm_axe:prop src
data remove storage rhythm_axe:prop title_comp
$data modify storage rhythm_axe:prop title set from storage rhythm_axe:maps.$(room_mapid) title
$data modify storage rhythm_axe:prop artist set from storage rhythm_axe:maps.$(room_mapid) artist
execute unless data storage rhythm_axe:prop title run data modify storage rhythm_axe:prop title set value "(无标题)"
execute if data storage rhythm_axe:prop {title:""} run data modify storage rhythm_axe:prop title set value "(无标题)"
execute unless data storage rhythm_axe:prop artist run data modify storage rhythm_axe:prop artist set value "(未知作者)"
execute if data storage rhythm_axe:prop {artist:""} run data modify storage rhythm_axe:prop artist set value "(未知作者)"
$data modify storage rhythm_axe:prop src set value "rhythm_axe:maps.$(room_mapid)"
# 标题组件归一化（复用编辑器的三分支助手）
function rhythm_axe:utilization/title_comp with storage rhythm_axe:prop
# player_count → #rm_x
scoreboard players set #rm_x menu 1
$execute if data storage rhythm_axe:maps.$(room_mapid) player_count run execute store result score #rm_x menu run data get storage rhythm_axe:maps.$(room_mapid) player_count
execute if score #rm_x menu matches ..0 run scoreboard players set #rm_x menu 1
function rhythm_axe:room/head_line_out with storage rhythm_axe:prop
data remove storage rhythm_axe:prop title
data remove storage rhythm_axe:prop artist
data remove storage rhythm_axe:prop src
data remove storage rhythm_axe:prop title_comp
