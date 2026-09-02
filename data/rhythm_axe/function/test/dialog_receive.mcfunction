# 测试：对话框提交的字符串接收（验证特殊字符转义与长度上限）
#arg: value
# 宏参数 value = 提交的输入字符串；函数以提交玩家身份运行（@s = 玩家）
# 把收到的字符串写入 storage，用 data get 与输入原文对比，可判断转义是否完好
$data modify storage rhythm_axe:test last_input set value "$(value)"
tellraw @s [{"text":"[测试] 收到的字符串: ","color":"green"},{"nbt":"last_input","storage":"rhythm_axe:test","color":"white"}]
