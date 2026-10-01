# 离开「共享大厅」的视图（@s = 玩家）：切到别的面板 / 进编辑器 / 开始游戏时调
# 作用：清掉两个视图标记，之后别人切歌/改成绩时就不会把总表/排行榜刷到正在看别的东西的人身上
#   （总表与排行榜渲染开头都会清屏，刷错人等于洗掉他的面板与聊天）
# ⚠️ 预览音只发给 tag=maplist_view 的人（见 preview/play）：移除 tag 前必须先停自己这一份，
#   否则 tag 一掉就再也点名不到他，音乐会一直响到播完（只 stop @s，别误伤别人）
execute if entity @s[tag=maplist_view] run stopmusic @s
tag @s remove maplist_view
tag @s remove lb_view
