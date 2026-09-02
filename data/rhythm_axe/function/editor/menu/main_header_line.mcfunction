#arg:title,cursor
# 主菜单标题行（title 宏传=JSON 组件，解析显示；artist/mapid 用 nbt 组件显示字符串）
$tellraw @s [$(title),{"text":" - ","color":"white"},{"nbt":"history[$(cursor)].artist","storage":"rhythm_axe:maps.editor","color":"aqua"},{"text":"，mapid：","color":"gray"},{"nbt":"mapid","storage":"rhythm_axe:maps.editor","color":"white"}]
