#arg:cursor
# 主菜单标题行：{谱面标题} - {谱面作者}，mapid：{谱面id}
# 标题先复制到 prop 暂存 → 由 utilization/title_comp 生成"标题组件" title_comp 供宏注入
# （JSON 组件字符串直接注入；裸纯文本合成字面组件；复合/列表交给 nbt+interpret 解析）
data remove storage rhythm_axe:prop title
$data modify storage rhythm_axe:prop title set from storage rhythm_axe:maps.editor history[$(cursor)].title
# 兜底：title 缺失/为空时给占位，避免标题行空白
execute unless data storage rhythm_axe:prop title run data modify storage rhythm_axe:prop title set value "(无标题)"
execute if data storage rhythm_axe:prop {title:""} run data modify storage rhythm_axe:prop title set value "(无标题)"
data modify storage rhythm_axe:prop src set value "rhythm_axe:prop"
execute if data storage rhythm_axe:prop title run function rhythm_axe:utilization/title_comp with storage rhythm_axe:prop
function rhythm_axe:editor/menu/main_header_line with storage rhythm_axe:prop
