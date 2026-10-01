#arg: label, key, obj, minus, plus
# 设置面板 · 数值行输出（宏叶子）：名称：[-]值[+]；minus / plus 是已构好的 JSON 组件字符串
$tellraw @s [{"text":"$(label)","color":"gray"},{"text":"：","color":"gray"},$(minus),{"score":{"name":"$(key)","objective":"$(obj)"},"color":"white"},$(plus)]
