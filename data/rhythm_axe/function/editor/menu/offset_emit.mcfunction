#arg: off_m5, off_m1, off_p1, off_p5, off_inp, off_hs
# 编辑器主菜单 · 全局音乐偏移行输出（宏叶子）：全局音乐偏移：[-5][-1] 值 [+1][+5] 【输入数值】 [🎶]
#   off_m5/off_m1/off_p1/off_p5/off_inp/off_hs 是 offset_row 已构好的 JSON 组件字符串
$tellraw @s [{"text":"全局音乐偏移：","color":"gray"},$(off_m5),$(off_m1),{"text":" ","color":"gray"},{"score":{"name":"music_offset","objective":"options"},"color":"white"},{"text":" ","color":"gray"},$(off_p1),$(off_p5),{"text":"  "},$(off_inp),{"text":" "},$(off_hs)]
