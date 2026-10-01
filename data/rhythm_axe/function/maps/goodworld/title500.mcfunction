# 500 刻标题：YO! DJ PUMP THIS PARTY
# 从上到下每 4 刻生成一个，各自 3 刻内从缩放 0 放大到目标大小
kill @e[tag=background]
kill @e[tag=title]

# 1) 背景和YO!立即生成，其后每 4 刻一个；DJ 8 刻
function rhythm_axe:maps/goodworld/title500_1
function rhythm_axe:maps/goodworld/title500_2
schedule function rhythm_axe:maps/goodworld/title500_3 4t
schedule function rhythm_axe:maps/goodworld/title500_4 12t
schedule function rhythm_axe:maps/goodworld/title500_5 16t
schedule function rhythm_axe:maps/goodworld/title500_6 20t
schedule function rhythm_axe:maps/goodworld/title500_7 24t
schedule function rhythm_axe:maps/goodworld/title500_final 30t