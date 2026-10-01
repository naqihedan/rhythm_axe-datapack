#arg: label, val
# 设置面板 · 布尔行输出（宏叶子）：名称：【开】/【关】；val 是已构好的 JSON 组件字符串
$tellraw @s [{"text":"$(label)","color":"gray"},{"text":"：","color":"gray"},$(val)]
