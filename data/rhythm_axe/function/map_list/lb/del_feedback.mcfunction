#arg:name
# 删除成功的反馈（宏叶子：名字原样注入，避免 {"nbt":"name"} 把字符串渲染成带引号的 "[name]"）
$tellraw @s [{"text":"[排行榜] ","color":"gold"},{"text":"已删除 ","color":"gray"},{"text":"$(name)","color":"white"},{"text":" 的这条成绩","color":"gray"}]
