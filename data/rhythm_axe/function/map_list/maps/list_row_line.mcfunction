#arg: row, title_comp, artist, charter, mapid, ind, pv_val, pv_icon, pv_color
# 总表单行输出（宏叶子）：{缩进}[▶/⏸] {标题} - {曲师} by {谱师} {mapid}
#   · [▶/⏸] = 点一下「选中这张谱面并开始预览」（再点一次=只停预览）——值 = 100000 + 页内序×100 + 列码 0（列码 0 = 开关类）
#   · 中括号 = 「这是按钮」；颜色由 pv_color 给：未选中 yellow、选中 gold（在 list_row 里算好）
#   · 图标是纯文本字形（▶/⏸，**不带 VS16**）—— 带 VS16 的 emoji 字形在部分资源包里渲染成怪符号
#   · ★ 2026-10-01 新增谱师：格式「歌曲名 - 曲师 by 谱师」（charter 缺失/空 → 显示 (未知谱师)）
#   · 选中的行前面带缩进 $(ind)（空串或两个全角空格），同时它是下面操作行三个按钮的作用对象
#   · 行尾不再挂【游玩】【编辑】【排行榜】（2026-10-01 用户定：改放到下面操作行）
# 说明：artist / charter 用宏注入（裸文本/JSON 组件都能显示）；⚠️ 名字里若含双引号会破坏本行 JSON，
#       必要时请把作者/谱师写成 JSON 组件字符串（如 {"text":"A\"B"}）。
$tellraw @s [{"text":"$(ind)"},{"text":"[$(pv_icon)]","color":"$(pv_color)","click_event":{"action":"run_command","command":"/trigger menu_click set $(pv_val)"},"hover_event":{"action":"show_text","value":"选中这张谱面并预览（再点一次停止预览）"}},{"text":" "},$(title_comp),{"text":" - ","color":"dark_gray"},{"text":"$(artist)","color":"gray"},{"text":" by ","color":"dark_gray"},{"text":"$(charter)","color":"gray"},{"text":"  "},{"text":"$(mapid)","color":"dark_gray"}]
