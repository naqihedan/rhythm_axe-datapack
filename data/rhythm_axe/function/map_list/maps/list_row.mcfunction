#arg: i, row, mapid
# 总表单行"准备"（宏叶子，非递归）：取标题/曲师/谱师 → 生成标题组件 → 算行首 ▶/⏸ 的值与图标 → 输出。
# 拆两层的原因：payload（title_comp / artist / charter）是**运行时**读出来的值，不能当同一个函数的宏参，
# 只能放进 prop 由下一次 `with storage` 调用解析（本库既有约定：包装器写 prop + 宏叶子读 prop）。
data remove storage rhythm_axe:prop title
data remove storage rhythm_axe:prop artist
data remove storage rhythm_axe:prop charter
$data modify storage rhythm_axe:prop title set from storage rhythm_axe:maps.$(mapid) title
$data modify storage rhythm_axe:prop artist set from storage rhythm_axe:maps.$(mapid) artist
$data modify storage rhythm_axe:prop charter set from storage rhythm_axe:maps.$(mapid) charter
execute unless data storage rhythm_axe:prop title run data modify storage rhythm_axe:prop title set value "(无标题)"
execute if data storage rhythm_axe:prop {title:""} run data modify storage rhythm_axe:prop title set value "(无标题)"
execute unless data storage rhythm_axe:prop artist run data modify storage rhythm_axe:prop artist set value "(未知曲师)"
execute if data storage rhythm_axe:prop {artist:""} run data modify storage rhythm_axe:prop artist set value "(未知曲师)"
# ★ 2026-10-01 新增谱师（charter）：总表行显示为「歌曲名 - 曲师 by 谱师」
execute unless data storage rhythm_axe:prop charter run data modify storage rhythm_axe:prop charter set value "(未知谱师)"
execute if data storage rhythm_axe:prop {charter:""} run data modify storage rhythm_axe:prop charter set value "(未知谱师)"
# 标题组件归一化（复用编辑器的三分支助手：JSON 组件字符串 / 裸纯文本 / 复合·列表 NBT）
$data modify storage rhythm_axe:prop src set value "rhythm_axe:maps.$(mapid)"
function rhythm_axe:utilization/title_comp with storage rhythm_axe:prop
# 行首按钮值（规范 v2：值 = (1000+页内序)×100 + 列码 = 100000 + 页内序×100 + 列码）
#   列码 0 = 开关类（这里的 ▶/⏸）；页内序 0..9 是单位数 ⇒ 固定 6 位："100" + 页内序 + "00"
#   ⚠️ 前缀必须是 "100" 而不是 "1000"（写成 1000$(row)00 会拼出 7 位越界值，点了报「不属于当前面板」）
$data modify storage rhythm_axe:prop pv_val set value 100$(row)00
# 默认：未选中（不缩进）、未预览（▶）、黄色（黄色 = 可点）
#   选中 = 这一行的 mapid 就是全局选中项 map_list.sel；预览中 = 选中项且 map_list.prev = 1b
#   颜色规则（2026-10-01 用户定）：未选中黄、选中金，且统一用中括号包起来表示「这是个按钮」
#   ★ 2026-10-01：图标用**纯文本字形**（▶ U+25B6 / ⏸ U+23F8），不带 emoji 变体选择符 VS16（U+FE0F）——
#     带 VS16 的字形在部分资源包里会渲染成怪符号/方框（用户实测）
#   ⚠️ 下面几行**不能**带行首 `$`：宏行必须真的引用一个 $(…) 参数（见《AI常见问题》）
data modify storage rhythm_axe:prop pv_icon set value "▶"
data modify storage rhythm_axe:prop pv_color set value "yellow"
data modify storage rhythm_axe:prop ind set value ""
$execute if data storage rhythm_axe:map_list {sel:"$(mapid)"} run data modify storage rhythm_axe:prop ind set value "　　"
$execute if data storage rhythm_axe:map_list {sel:"$(mapid)"} run data modify storage rhythm_axe:prop pv_color set value "gold"
$execute if data storage rhythm_axe:map_list {sel:"$(mapid)"} if data storage rhythm_axe:map_list {prev:1b} run data modify storage rhythm_axe:prop pv_icon set value "⏸"
function rhythm_axe:map_list/maps/list_row_line with storage rhythm_axe:prop
