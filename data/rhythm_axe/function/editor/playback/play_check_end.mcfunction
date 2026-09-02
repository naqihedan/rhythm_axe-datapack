#arg:cursor
# 播放前检查：若播放头已到/超过谱面结束时间（end_time 存在时），回到开头
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].end_time
execute if score #temp editor matches 1.. if score #playhead editor >= #temp editor run function rhythm_axe:editor/menu/jump/jump_start
