#arg:title_comp,cursor
# 主菜单标题行（title_comp 已由 utilization/title_comp 归一化为可安全注入的文本组件；artist/mapid 用 nbt 组件）
$tellraw @s [{"text":""},$(title_comp),{"text":" - ","color":"white"},{"nbt":"history[$(cursor)].artist","storage":"rhythm_axe:maps.editor","color":"aqua"},{"text":" - ","color":"white"},{"nbt":"history[$(cursor)].charter","storage":"rhythm_axe:maps.editor","color":"gold"},{"text":"，mapid：","color":"gray"},{"nbt":"mapid","storage":"rhythm_axe:maps.editor","color":"white"}]
