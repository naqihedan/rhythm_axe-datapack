#arg: off_label, off_lo, off_hi, off_b1, off_b2, off_b3, off_b4, off_b5, off_b6
# 编辑器主菜单 · 全局音乐偏移行生成器（宏）：名称：[-5][-1] 值 [+1][+5] 【输入数值】 [🎶]
#   外观照设置面板 options/offset_row；按钮走 editor_click（值 = 行110×100 + 列码 → 11001..11006）
#   off_lo / off_hi = 值域闭区间（-500 / 500）；到边界时对应的 −/＋ 变红（不带 click_event，点不动）
#   【输入数值】永远可点（黄色）→ 打开对话框 options_music_offset
#   [🎶] = 音符击打音效开关（off_b6 = 11006；开=蓝 关=红，读 options.hitsound_on）
#   ⚠ 参数经 storage rhythm_axe:prop 传入（同其它编辑器宏约定）
scoreboard players set #off_v editor 0
execute store result score #off_v editor run scoreboard players get music_offset options
data modify storage rhythm_axe:prop off_m5 set value '{"text":"[-5]","color":"red"}'
$execute unless score #off_v editor matches ..$(off_lo) run data modify storage rhythm_axe:prop off_m5 set value '{"text":"[-5]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(off_b1)"},"hover_event":{"action":"show_text","value":"$(off_label) −5 ms（$(off_lo) ~ $(off_hi)）"}}'
data modify storage rhythm_axe:prop off_m1 set value '{"text":"[-1]","color":"red"}'
$execute unless score #off_v editor matches ..$(off_lo) run data modify storage rhythm_axe:prop off_m1 set value '{"text":"[-1]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(off_b2)"},"hover_event":{"action":"show_text","value":"$(off_label) −1 ms（$(off_lo) ~ $(off_hi)）"}}'
data modify storage rhythm_axe:prop off_p1 set value '{"text":"[+1]","color":"red"}'
$execute unless score #off_v editor matches $(off_hi).. run data modify storage rhythm_axe:prop off_p1 set value '{"text":"[+1]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(off_b3)"},"hover_event":{"action":"show_text","value":"$(off_label) +1 ms（$(off_lo) ~ $(off_hi)）"}}'
data modify storage rhythm_axe:prop off_p5 set value '{"text":"[+5]","color":"red"}'
$execute unless score #off_v editor matches $(off_hi).. run data modify storage rhythm_axe:prop off_p5 set value '{"text":"[+5]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set $(off_b4)"},"hover_event":{"action":"show_text","value":"$(off_label) +5 ms（$(off_lo) ~ $(off_hi)）"}}'
$data modify storage rhythm_axe:prop off_inp set value '{"text":"【输入数值】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set $(off_b5)"},"hover_event":{"action":"show_text","value":"直接输入偏移量（整数，$(off_lo) ~ $(off_hi) ms）"}}'
# [🎶] 音符击打音效开关（2026-10-17）：开=青色 关=红；点击值 off_b6（=11006）
scoreboard players set #off_hs editor 0
execute if score hitsound_on options matches 0 run scoreboard players set #off_hs editor 1
$data modify storage rhythm_axe:prop off_hs set value '{"text":"[🎶]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(off_b6)"},"hover_event":{"action":"show_text","value":"音符打击音：启用（点击禁用）"}}'
$execute if score #off_hs editor matches 1 run data modify storage rhythm_axe:prop off_hs set value '{"text":"[🎶]","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set $(off_b6)"},"hover_event":{"action":"show_text","value":"音符打击音：禁用（点击启用）"}}'
function rhythm_axe:editor/menu/offset_emit with storage rhythm_axe:prop
