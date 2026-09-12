#arg:xcomp,tcomp,mcomp,vcomp
# 持续时长行渲染（宏叶子；驱动器 note_panel 填好 prop 组件后 `function ... note_dur_row with storage rhythm_axe:prop` 调用）
# xcomp=[x] 重置 / tcomp=[~] 相对绝对切换（13305）/ mcomp=[--][-] / vcomp=数值（相对=增量，绝对=设定值）
$tellraw @s [$(xcomp),$(tcomp),"      ",{"text":"持续时长：","color":"white"},$(mcomp),$(vcomp),{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12202"},"hover_event":{"action":"show_text","value":"持续 +1"}},{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 12204"},"hover_event":{"action":"show_text","value":"持续 +tpb（当前播放头时间点）"}}]
