#arg:title,cursor
# 切换确认信息行：您当前正在编辑 {标题}-{作者}（mapid:{mapid}）
$tellraw @s [{"text":"您当前正在编辑 ","color":"gray"},$(title),{"text":" - ","color":"white"},{"nbt":"history[$(cursor)].artist","storage":"rhythm_axe:maps.editor","color":"aqua"},{"text":"（mapid:","color":"gray"},{"nbt":"mapid","storage":"rhythm_axe:maps.editor","color":"white"},{"text":"）","color":"gray"}]
