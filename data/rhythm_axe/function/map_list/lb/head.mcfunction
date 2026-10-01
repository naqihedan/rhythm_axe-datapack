#arg:mapid,title_comp,artist,charter
# 排行榜标题行：谱面：{标题} - {曲师} - {谱面作者}（mapid）
# ⚠️ 标题组件必须**原样宏注入**（同 list_row_line / main_header_line 的做法）：
#    title_comp 可能是 JSON 组件串（{"nbt":"title","storage":"..","interpret":true}）、复合或列表，
#    若在外面包一层 {"nbt":"title_comp","storage":"rhythm_axe:prop","interpret":true}，
#    游戏会把那个字符串当普通文本显示出来（内层 nbt 组件**不会**再解析）—— 2026-10-01 实测踩坑。
# ⚠️ artist / charter 同 list_row_line：裸文本注入；作者名里若含双引号会破坏本行 JSON，
#    这种情况请把该字段写成 JSON 组件字符串（如 {"text":"A\"B"}）。
$tellraw @s [{"text":"谱面：","color":"gray"},$(title_comp),{"text":" - ","color":"dark_gray"},{"text":"$(artist)","color":"aqua"},{"text":" - ","color":"dark_gray"},{"text":"$(charter)","color":"gold"},{"text":"（$(mapid)）","color":"dark_gray"}]
