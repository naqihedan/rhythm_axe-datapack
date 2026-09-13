#arg:xcomp,tcomp,mcomp,pcomp
# 判定时间行渲染（宏叶子；驱动器 note_panel 填好 prop 组件后 `function ... note_time_row with storage rhythm_axe:prop` 调用）
# xcomp=[x] 重置(14016)（相对：红=增量非0/灰=0；绝对：红=已改/灰=未改）
# tcomp=[~] 相对绝对切换(13301) / mcomp=[--][-](12003/12001) / pcomp= [+] [++](12002/12004)
# 行尾固定按钮【使用当前时间】(12005)：把判定时间**切换为绝对模式**并设为**当前播放头位置**
$tellraw @s [$(xcomp),$(tcomp),{"text":"判定时间：","color":"white"},$(mcomp),{"score":{"name":"#disp_time","objective":"editor"},"color":"white"},$(pcomp),{"text":"  【使用当前时间】","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 12005"},"hover_event":{"action":"show_text","value":"判定时间设为当前播放头位置（并切换为绝对模式）"}}]
