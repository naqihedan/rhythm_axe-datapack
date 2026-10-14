# 启动主函数：在区域 A/B 内每刻随机生成一个元件，共 64 次
#   A = x 3~7 / B = x -11~-7 / z -2~31 / y 固定 -1
#   ★ running 守护：已在跑时忽略重复调用（否则会出现两条驱动链、生成翻倍）
execute unless data storage rhythm_axe:g2384 running run function rhythm_axe:maps/goodworld/good2384_start
