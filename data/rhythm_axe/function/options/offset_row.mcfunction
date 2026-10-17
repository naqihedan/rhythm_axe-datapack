#arg: label, key, obj, lo, hi, b1, b2, b3, b4, b5, b6
# 设置面板 · 「全局音乐偏移」专用行生成器（宏）：名称：[-5][-1] 值 [+1][+5] 【输入数值】 [🎶]
#   五个数值按钮：b1=−5 / b2=−1 / b3=+1 / b4=+5 / b5=【输入数值】（打开对话框）
#   b6 = [🎶] 音符击打音效开关的 trigger 值（12706）；颜色随 options.hitsound_on（1=蓝 0=红）
#   到边界时 −/＋ 变红（点不动，同 num_row 风格）；【输入数值】永远可点（黄色）
#   ⚠ 参数经 storage rhythm_axe:op_ui 传入（不用 compound 参数）——
#     这样 check_all_panel_coverage.py 的「注入型按钮值」审计（param_keys + data modify set value <数字>）能识别到 b1..b5。
scoreboard players set #sop_v menu 0
$execute store result score #sop_v menu run scoreboard players get $(key) $(obj)
# −5 / −1：value <= lo 时红（点不动）
data modify storage rhythm_axe:op_ui minus5 set value '{"text":"[-5]","color":"red"}'
$execute unless score #sop_v menu matches ..$(lo) run data modify storage rhythm_axe:op_ui minus5 set value '{"text":"[-5]","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set $(b1)"},"hover_event":{"action":"show_text","value":"$(label) −5（$(lo) ~ $(hi)）"}}'
data modify storage rhythm_axe:op_ui minus1 set value '{"text":"[-1]","color":"red"}'
$execute unless score #sop_v menu matches ..$(lo) run data modify storage rhythm_axe:op_ui minus1 set value '{"text":"[-1]","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set $(b2)"},"hover_event":{"action":"show_text","value":"$(label) −1（$(lo) ~ $(hi)）"}}'
# +1 / +5：value >= hi 时红（点不动）
data modify storage rhythm_axe:op_ui plus1 set value '{"text":"[+1]","color":"red"}'
$execute unless score #sop_v menu matches $(hi).. run data modify storage rhythm_axe:op_ui plus1 set value '{"text":"[+1]","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set $(b3)"},"hover_event":{"action":"show_text","value":"$(label) +1（$(lo) ~ $(hi)）"}}'
data modify storage rhythm_axe:op_ui plus5 set value '{"text":"[+5]","color":"red"}'
$execute unless score #sop_v menu matches $(hi).. run data modify storage rhythm_axe:op_ui plus5 set value '{"text":"[+5]","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set $(b4)"},"hover_event":{"action":"show_text","value":"$(label) +5（$(lo) ~ $(hi)）"}}'
# 【输入数值】：永远可点（黄色，打开对话框直接填数）
$data modify storage rhythm_axe:op_ui inputbtn set value '{"text":"【输入数值】","color":"yellow","click_event":{"action":"run_command","command":"/trigger menu_click set $(b5)"},"hover_event":{"action":"show_text","value":"直接输入偏移量（整数，$(lo) ~ $(hi) ms）"}}'
# [🎶] 音符击打音效开关（2026-10-17）：开=青色 关=红色；点击值 b6（=12706）
scoreboard players set #hs_off menu 0
execute if score hitsound_on options matches 0 run scoreboard players set #hs_off menu 1
$data modify storage rhythm_axe:op_ui hsbtn set value '{"text":"[🎶]","color":"aqua","click_event":{"action":"run_command","command":"/trigger menu_click set $(b6)"},"hover_event":{"action":"show_text","value":"音符打击音：启用（点击禁用）"}}'
$execute if score #hs_off menu matches 1 run data modify storage rhythm_axe:op_ui hsbtn set value '{"text":"[🎶]","color":"red","click_event":{"action":"run_command","command":"/trigger menu_click set $(b6)"},"hover_event":{"action":"show_text","value":"音符打击音：禁用（点击启用）"}}'
function rhythm_axe:options/offset_emit with storage rhythm_axe:op_ui
