#arg:title
# 裸纯文本标题 → 字面文本组件（宏拼接）。
# 只用于 title 确认是**字符串**且不是 JSON 组件的场合，由 utilization/title_comp 调用。
# ⚠️ 文本里请勿包含 双引号/反斜杠（会破坏 JSON）；要彩色/富文本请改用 JSON 组件写法。
$data modify storage rhythm_axe:prop title_comp set value '{"text":"$(title)","color":"white"}'
