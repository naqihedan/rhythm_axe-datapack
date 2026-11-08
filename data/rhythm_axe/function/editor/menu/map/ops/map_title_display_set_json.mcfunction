#arg:td_json
# 把 JSON 文本组件字符串写进标题展示实体的 text（宏注入 → 由游戏解析成真组件，颜色/样式全部保留）
# 调用方：editor/menu/map/ops/map_title_display_spawn（此时 #td_json = 1，prop.td_json = 标题字符串）
# ⚠️ 只用于「字符串」标题；复合/列表 NBT 走 `data modify entity … text set from storage`（非宏）
$data modify entity @e[tag=rhythm_axe_title_display,limit=1,sort=nearest] text set value $(td_json)