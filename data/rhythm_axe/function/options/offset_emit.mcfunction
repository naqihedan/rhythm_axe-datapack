#arg: label, key, obj, minus5, minus1, plus1, plus5, inputbtn, hsbtn
# 设置面板 · 「全局音乐偏移」行输出（宏叶子）：名称：[-5][-1] 值 [+1][+5] 【输入数值】 [🎶]
#   minus5/minus1/plus1/plus5/inputbtn/hsbtn 是 offset_row 已构好的 JSON 组件字符串
#   （hsbtn 为空串 → 渲染成空，不报错）
$tellraw @s [{"text":"$(label)","color":"gray"},{"text":"：","color":"gray"},$(minus5),$(minus1),{"text":" ","color":"gray"},{"score":{"name":"$(key)","objective":"$(obj)"},"color":"white"},{"text":" ","color":"gray"},$(plus1),$(plus5),{"text":"  "},$(inputbtn),{"text":" "},$(hsbtn)]
