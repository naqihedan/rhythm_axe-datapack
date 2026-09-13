#arg:xcomp,ecomp,pcomp
# 动画类型行渲染（宏叶子；驱动器 note_panel 填好 prop 组件后 `function ... note_anim_row with storage rhythm_axe:prop` 调用）
# xcomp=[x] 重置(14010)（红=已修改可点 / 灰=未修改）
# ecomp=缓动类型文字（缓入/缓出/缓入缓出；**批量模式下该项未修改时显示 -**）
# pcomp=缓动强度数值（**批量模式下该项未修改时显示 -**）
$tellraw @s [$(xcomp),{"text":"      ","color":"white"},{"text":"动画类型：","color":"white"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12701"},"hover_event":{"action":"show_text","value":"上一个缓动（1缓入/2缓出/3缓入缓出）"}},$(ecomp),{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12702"},"hover_event":{"action":"show_text","value":"下一个缓动"}},{"text":" [-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12703"},"hover_event":{"action":"show_text","value":"强度 -1（1-5，1=线性）"}},$(pcomp),{"text":"[+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12704"},"hover_event":{"action":"show_text","value":"强度 +1"}}]
