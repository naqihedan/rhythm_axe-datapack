#arg:cursor
# 切换确认的当前谱面信息行：复制 title 到 prop 后由子宏显示（title 宏传解析）
$data modify storage rhythm_axe:prop title set from storage rhythm_axe:maps.editor history[$(cursor)].title
# ★ title 若为复合 {text:...}，宏 $(title) 传不了（确认行不显示）→ 清洗为字符串
execute if data storage rhythm_axe:prop title.text run data modify storage rhythm_axe:prop title set from storage rhythm_axe:prop title.text
function rhythm_axe:editor/menu/switch/switch_title_line with storage rhythm_axe:prop
