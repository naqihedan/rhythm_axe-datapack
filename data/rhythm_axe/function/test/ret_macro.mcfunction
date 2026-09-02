#arg:index
# 测试2：宏函数里 execute if score ... run return 0（宏行，注入 $(index) 恒真前缀使其合法）
# 调用前先 scoreboard players set #t editor 5；若 return 生效则不打印 MACRO-REACHED
$execute if data storage rhythm_axe:maps.editor history[$(index)].notes if score #t editor matches 1.. run return 0
tellraw @s [{"text":"MACRO-REACHED","color":"red"}]
