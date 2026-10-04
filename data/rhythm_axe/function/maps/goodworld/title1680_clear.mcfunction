# title1680 自清：动画走完后删掉本次标题。
# 用专属 tag title1680（不是 title1680_move —— 那个在动画后就摘掉了；也不是 title —— 会误杀期间新起的标题）。
kill @e[tag=title1680]
scoreboard objectives remove title1680_time
