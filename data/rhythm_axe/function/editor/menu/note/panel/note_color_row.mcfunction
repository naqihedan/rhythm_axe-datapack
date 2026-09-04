#arg:xcomp,cname
# 颜色行：行首 [x]（红=已修改/灰=未修改）+ 标签 + [-] + 颜色名 + [+]
$tellraw @s [$(xcomp),{"text":"      ","color":"white"},{"text":"颜色：","color":"white"},{"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 770"},"hover_event":{"action":"show_text","value":"上一个颜色（0 无 / 1-16 色）"}},$(cname),{"text":" [+] ","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 771"},"hover_event":{"action":"show_text","value":"下一个颜色"}}]
