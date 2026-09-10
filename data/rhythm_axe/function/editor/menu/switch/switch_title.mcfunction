#arg:cursor
# 切换确认的当前谱面信息行：复制 title 到 prop 后由 util/title_comp 生成标题组件再由子宏显示
data remove storage rhythm_axe:prop title
$data modify storage rhythm_axe:prop title set from storage rhythm_axe:maps.editor history[$(cursor)].title
# 兜底：title 缺失/为空时给占位
execute unless data storage rhythm_axe:prop title run data modify storage rhythm_axe:prop title set value "(无标题)"
execute if data storage rhythm_axe:prop {title:""} run data modify storage rhythm_axe:prop title set value "(无标题)"
data modify storage rhythm_axe:prop src set value "rhythm_axe:prop"
execute if data storage rhythm_axe:prop title run function rhythm_axe:utilization/title_comp with storage rhythm_axe:prop
function rhythm_axe:editor/menu/switch/switch_title_line with storage rhythm_axe:prop
