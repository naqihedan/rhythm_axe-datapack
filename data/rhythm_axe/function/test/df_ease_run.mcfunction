# 临时测试叶子：算一个 n 并打印，n+1 递归
function rhythm_axe:editor/util/ease_power
tellraw @s [{"text":"  n="},{"score":{"name":"#ez_n","objective":"editor"}},{"text":" → "},{"score":{"name":"#ez_ratio","objective":"editor"}}]
scoreboard players add #ez_n editor 1
execute if score #ez_n editor <= #ez_total editor run function rhythm_axe:test/df_ease_run
