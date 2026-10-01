#arg: label, m_color, p_color, m_val, p_val, tz_kind
# 谱面设置里「预览起点 / 预览时长」行（宏叶子）：{标签} [-] {值} [+] {换算时长}
#   · 值 = 刻（#temp editor，调用方已 store 好）；右边是换算后的时间，格式看 tz_kind
#   · m_color / p_color：green = 还能调 / red = 已到下限（上限）——红色仍带 click，处理端会钳制，只是点了不再变
#   · tz_kind = "start" → 分:秒.百分秒（如 1:23.05）；其它 → 秒.百分秒（如 10.00）
#   · 时间分量由 editor/util/tick_to_time 算好（分数前缀 #tz）
#   · 调用完清 prop（本行专属的 6 个键）
$execute if data storage rhythm_axe:prop {tz_kind:"start"} run tellraw @s [\
{"text":"$(label)","color":"gray"},\
{"text":"[-]","color":"$(m_color)","click_event":{"action":"run_command","command":"/trigger editor_click set $(m_val)"},"hover_event":{"action":"show_text","value":"减少（已是下限时变红）"}},\
{"score":{"name":"#temp","objective":"editor"},"color":"gold"},\
{"text":"[+]","color":"$(p_color)","click_event":{"action":"run_command","command":"/trigger editor_click set $(p_val)"},"hover_event":{"action":"show_text","value":"增加（已是上限时变红）"}},\
{"text":" "},\
{"score":{"name":"#tz_m","objective":"editor"},"color":"white"},\
{"text":":","color":"white"},\
{"score":{"name":"#tz_s10","objective":"editor"},"color":"white"},\
{"score":{"name":"#tz_s1","objective":"editor"},"color":"white"},\
{"text":".","color":"white"},\
{"score":{"name":"#tz_c10","objective":"editor"},"color":"white"},\
{"score":{"name":"#tz_c1","objective":"editor"},"color":"white"},\
{"text":"  "},\
{"text":"【使用当前时间】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 10305"},"hover_event":{"action":"show_text","value":"把当前播放刻填进预览起点"}}\
]
$execute unless data storage rhythm_axe:prop {tz_kind:"start"} run tellraw @s [\
{"text":"$(label)","color":"gray"},\
{"text":"[-]","color":"$(m_color)","click_event":{"action":"run_command","command":"/trigger editor_click set $(m_val)"},"hover_event":{"action":"show_text","value":"减少（已是下限时变红）"}},\
{"score":{"name":"#temp","objective":"editor"},"color":"gold"},\
{"text":"[+]","color":"$(p_color)","click_event":{"action":"run_command","command":"/trigger editor_click set $(p_val)"},"hover_event":{"action":"show_text","value":"增加（已是上限时变红）"}},\
{"text":" "},\
{"score":{"name":"#tz_ls","objective":"editor"},"color":"white"},\
{"text":".","color":"white"},\
{"score":{"name":"#tz_lc10","objective":"editor"},"color":"white"},\
{"score":{"name":"#tz_lc1","objective":"editor"},"color":"white"},\
{"text":"  "},\
{"text":"【截到播放头】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 10306"},"hover_event":{"action":"show_text","value":"预览时长 = 起点到当前播放头的时差（播放头还在起点之前时不动）"}}\
]
data remove storage rhythm_axe:prop label
data remove storage rhythm_axe:prop m_color
data remove storage rhythm_axe:prop p_color
data remove storage rhythm_axe:prop m_val
data remove storage rhythm_axe:prop p_val
data remove storage rhythm_axe:prop tz_kind
