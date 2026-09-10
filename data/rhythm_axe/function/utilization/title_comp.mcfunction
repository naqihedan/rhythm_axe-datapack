#arg:src
# 生成"标题组件" rhythm_axe:prop.title_comp，供各显示点用宏 $(title_comp) 注入 tellraw / bossbar 名称。
# src：title 所在的存储名（编辑器暂存阶段为 rhythm_axe:prop；游玩阶段为 rhythm_axe:runtime）。
#
# 标题值有三种形态，分别处理：
#   (a) JSON 文本组件字符串（{"text":...} / [{...}] / "..."）→ 原样宏注入，由 tellraw 直接解析（最稳，保留样式）
#   (b) 裸纯文本（如 测试谱面，对话框直接输入）→ 合成字面组件 {"text":"...","color":"white"}
#       （把裸文本当组件注入会让整条 tellraw JSON 非法 → 整行连同作者/mapid 一起消失）
#   (c) 复合/列表 NBT（如 lament_rain 的逐字渐变标题）→ {"nbt":...,"interpret":true}
#       交给游戏把 NBT 解析成文本组件；解析失败只显示为空，不会报错
# 类型判定：取 title 首字符（set string 子串）；非字符串时该命令失败、保持两位哨兵 "??"，从而走 (c) 分支。
# 注意本函数**不能**声明 #arg:title——title 可能是复合/列表，非字符串无法作为宏参数传入。
# 输出：rhythm_axe:prop.title_comp
# (c) 默认：非字符串（列表/复合）→ nbt + interpret
$data modify storage rhythm_axe:prop title_comp set value '{"nbt":"title","storage":"$(src)","interpret":true}'
data modify storage rhythm_axe:prop title_ch set value "??"
data modify storage rhythm_axe:prop title_ch set string storage rhythm_axe:prop title 0 1
# (a) 字符串且以 { [ " 开头 → 已是 JSON 组件，原样注入
execute if data storage rhythm_axe:prop {title_ch:"{"} run data modify storage rhythm_axe:prop title_comp set from storage rhythm_axe:prop title
execute if data storage rhythm_axe:prop {title_ch:"["} run data modify storage rhythm_axe:prop title_comp set from storage rhythm_axe:prop title
execute if data storage rhythm_axe:prop {title_ch:"\""} run data modify storage rhythm_axe:prop title_comp set from storage rhythm_axe:prop title
# (b) 字符串且非 JSON 开头 → 字面纯文本组件
execute unless data storage rhythm_axe:prop {title_ch:"??"} unless data storage rhythm_axe:prop {title_ch:"{"} unless data storage rhythm_axe:prop {title_ch:"["} unless data storage rhythm_axe:prop {title_ch:"\""} run function rhythm_axe:utilization/title_plain with storage rhythm_axe:prop
data remove storage rhythm_axe:prop title_ch
