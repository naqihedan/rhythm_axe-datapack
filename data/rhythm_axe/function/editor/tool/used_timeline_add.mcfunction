# 事件点/时间点工具右键（@s = 玩家，已由 use__ 分派到本函数）
# 站立=添加事件点（命令方块矿车）、蹲下=添加时间点（时钟）。添加后打开对应设置面板（显示刚创建的元素）。
# 时间点工具完全继承上一个时间点（time=播放头；其他字段继承，无上一个则默认）；事件点工具不继承（time=播放头，commands=[]）。

# 播放头为 time
execute store result storage rhythm_axe:prop time int 1 run scoreboard players get #playhead editor

# 蹲下 → 时间点工具
execute if entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/tool/used_timeline_add_timing
execute unless entity @s[predicate=rhythm_axe:sneaking] run function rhythm_axe:editor/tool/used_timeline_add_event
