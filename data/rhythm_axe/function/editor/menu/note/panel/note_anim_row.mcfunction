#arg:xcomp,ecomp,pcomp
# 动画类型行渲染（宏叶子；驱动器 note_panel 填好 prop 组件后 `function ... note_anim_row with storage rhythm_axe:prop` 调用）
# xcomp=[x] 重置(14010)（红=已修改可点 / 灰=未修改）
# ecomp=缓动类型**单按钮**（组件自带 click/hover，点一下循环 缓入→缓出→缓入缓出；**批量模式下该项未修改时显示 【 - 】（黄色）**）
#   ★ 2026-10-02：缓动改为单按钮循环（与面板 20 一致），不再用 [-] / [+] 两个按钮。
#     旧值 12701（上一个）在 note_panel_adjust 里仍保留，聊天栏里的旧行不会失效。
# pcomp=缓动强度数值（仍是 [-] / [+] 两个按钮；**批量模式下未修改时显示 -**）
$tellraw @s [{"text":""},$(xcomp),{"text":"      ","color":"white"},{"text":"动画类型：","color":"white"},$(ecomp),{"text":" [-] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12703"},"hover_event":{"action":"show_text","value":"强度 -1（1-5，1=线性）"}},$(pcomp),{"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 12704"},"hover_event":{"action":"show_text","value":"强度 +1"}}]
