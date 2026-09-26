#arg: title_comp, artist
# 房间页页头第二层：输出 ========= 标题 - 作者 =========（标题走组件、作者裸文本注入，同 list_row_line 约定）
$tellraw @s [{"text":"=========  ","color":"dark_gray"},$(title_comp),{"text":" - ","color":"dark_gray"},{"text":"$(artist)","color":"gray"},{"text":"  =========","color":"dark_gray"}]
