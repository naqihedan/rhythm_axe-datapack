#arg:xcomp,tcomp,mcomp,vcomp
# 基础寿命行渲染（宏叶子；驱动器 note_panel 填好 prop 组件后 `function ... note_bl_row with storage rhythm_axe:prop` 调用）
# xcomp=[x] 重置(14001) / tcomp=[~] 相对绝对切换(13306) / mcomp=[--][-](12603/12601) / vcomp=数值（相对=增量，绝对=设定值）
$tellraw @s [$(xcomp),$(tcomp),{"text":"基础寿命：","color":"white"},$(mcomp),$(vcomp),{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12602"},"hover_event":{"action":"show_text","value":"基础寿命 +1"}},{"text":"[++]","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 12604"},"hover_event":{"action":"show_text","value":"基础寿命 +tpb（当前播放头时间点）"}}]
