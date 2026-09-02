#arg:cursor
# 主菜单标题行：{谱面标题} - {谱面作者}，mapid：{谱面id}
# 标题用宏传（26.x nbt interpret 不解析会显示原始 JSON；title 存字符串=JSON 组件，宏展开为组件参数）
$data modify storage rhythm_axe:prop title set from storage rhythm_axe:maps.editor history[$(cursor)].title
# ★ title 若为复合 {text:...}，宏 $(title) 传不了（标题行不显示）→ 清洗为字符串
execute if data storage rhythm_axe:prop title.text run data modify storage rhythm_axe:prop title set from storage rhythm_axe:prop title.text
function rhythm_axe:editor/menu/main_header_line with storage rhythm_axe:prop
