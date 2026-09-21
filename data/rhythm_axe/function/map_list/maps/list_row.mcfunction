#arg: i, row, mapid
# 总表单行"准备"（宏叶子，非递归）：取标题/作者 → 生成标题组件 → 拼两个按钮值 → 交给 list_row_line 输出。
# 拆两层的原因：payload（title_comp / artist）是**运行时**读出来的值，不能当同一个函数的宏参，
# 只能放进 prop 由下一次 `with storage` 调用解析（本库既有约定：包装器写 prop + 宏叶子读 prop）。
data remove storage rhythm_axe:prop title
data remove storage rhythm_axe:prop artist
$data modify storage rhythm_axe:prop title set from storage rhythm_axe:maps.$(mapid) title
$data modify storage rhythm_axe:prop artist set from storage rhythm_axe:maps.$(mapid) artist
execute unless data storage rhythm_axe:prop title run data modify storage rhythm_axe:prop title set value "(无标题)"
execute if data storage rhythm_axe:prop {title:""} run data modify storage rhythm_axe:prop title set value "(无标题)"
execute unless data storage rhythm_axe:prop artist run data modify storage rhythm_axe:prop artist set value "(未知作者)"
execute if data storage rhythm_axe:prop {artist:""} run data modify storage rhythm_axe:prop artist set value "(未知作者)"
# 标题组件归一化（复用编辑器的三分支助手：JSON 组件字符串 / 裸纯文本 / 复合·列表 NBT）
$data modify storage rhythm_axe:prop src set value "rhythm_axe:maps.$(mapid)"
function rhythm_axe:utilization/title_comp with storage rhythm_axe:prop
# 按钮值（规范 v2：值 = (1000+页内序)×100 + 列码 = 100000 + 页内序×100 + 列码）
#   页内序 0..9 是**单位数**、列码两位（01 游玩 / 03 编辑）⇒ 固定 6 位："100" + 页内序 + 列码。
#   ⚠️ 前缀必须是 "100" 而不是 "1000"（写成 1000$(row)01 会拼出 7 位 1000401 这种越界值，点了报「不属于当前面板」）。
#   例：页内序 0 ⇒ 100001 / 100003；页内序 4 ⇒ 100401 / 100403
$data modify storage rhythm_axe:prop play_val set value 100$(row)01
$data modify storage rhythm_axe:prop edit_val set value 100$(row)03
function rhythm_axe:map_list/maps/list_row_line with storage rhythm_axe:prop
