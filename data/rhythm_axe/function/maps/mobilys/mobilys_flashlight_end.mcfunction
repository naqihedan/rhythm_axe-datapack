# recycle（1392 段 / 1776 段共用）
# ★ 不依赖「marker 正好走完 12 刻」：最尾一发(360t)的 marker 要到 1764 刻才满 12 分，
#   和 end 撞在同一刻，先后不保证；所以这里无条件清干净 + 还原方块。
#   谱面编写规范：调用之后回收自身，不留痕迹。
kill @e[type=minecraft:marker,tag=mobilys_flashlight]
schedule clear rhythm_axe:maps/mobilys/mobilys_flashlight_fire
schedule clear rhythm_axe:maps/mobilys/mobilys_flashlight_maincycle
schedule clear rhythm_axe:maps/mobilys/mobilys_flashlight1776_step
fill -6 2 31 2 0 -5 cyan_stained_glass_pane replace yellow_stained_glass_pane
scoreboard objectives remove mobilys_flashlight