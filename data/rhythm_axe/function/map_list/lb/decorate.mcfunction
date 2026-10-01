# 排行榜单行修饰（非宏，直接读/写 rhythm_axe:prop）
#   输入：prop.score（分数）、prop.health（这条成绩当时的血量百分比，旧数据可能没有）
#   输出：prop.rating / prop.rating_color（评级）、prop.score_color（分数颜色）
# ★ 评级阈值来自 options 的 SS/S/A/B/C（**动态**：改设置里的评级线，排行榜立刻跟着变），与结算界面同一套。
#   按**升序**逐档覆盖，最后写进去的就是达到的最高档。
data modify storage rhythm_axe:prop rating set value "Failed"
data modify storage rhythm_axe:prop rating_color set value "gray"
data modify storage rhythm_axe:prop score_color set value "white"
scoreboard players set #lb_sc menu 0
execute store result score #lb_sc menu run data get storage rhythm_axe:prop score
execute if score #lb_sc menu >= C options run data modify storage rhythm_axe:prop rating set value "C"
execute if score #lb_sc menu >= C options run data modify storage rhythm_axe:prop rating_color set value "gray"
execute if score #lb_sc menu >= B options run data modify storage rhythm_axe:prop rating set value "B"
execute if score #lb_sc menu >= B options run data modify storage rhythm_axe:prop rating_color set value "blue"
execute if score #lb_sc menu >= A options run data modify storage rhythm_axe:prop rating set value "A"
execute if score #lb_sc menu >= A options run data modify storage rhythm_axe:prop rating_color set value "green"
execute if score #lb_sc menu >= S options run data modify storage rhythm_axe:prop rating set value "S"
execute if score #lb_sc menu >= S options run data modify storage rhythm_axe:prop rating_color set value "yellow"
execute if score #lb_sc menu >= SS options run data modify storage rhythm_axe:prop rating set value "SS"
execute if score #lb_sc menu >= SS options run data modify storage rhythm_axe:prop rating_color set value "gold"
# 分数颜色 = 这条成绩当时的血量百分比，取色与结算界面上下边框完全一致：
#   100=金 / 80..99=黄 / 50..79=绿 / 1..49=蓝 / 0=灰；旧数据没有 health ⇒ 保持白色（未知）
execute unless data storage rhythm_axe:prop health run return 0
scoreboard players set #lb_h menu 0
execute store result score #lb_h menu run data get storage rhythm_axe:prop health
execute if score #lb_h menu matches 100.. run data modify storage rhythm_axe:prop score_color set value "gold"
execute if score #lb_h menu matches 80..99 run data modify storage rhythm_axe:prop score_color set value "yellow"
execute if score #lb_h menu matches 50..79 run data modify storage rhythm_axe:prop score_color set value "green"
execute if score #lb_h menu matches 1..49 run data modify storage rhythm_axe:prop score_color set value "blue"
execute if score #lb_h menu matches ..0 run data modify storage rhythm_axe:prop score_color set value "gray"
