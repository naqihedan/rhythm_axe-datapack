# 编辑器主菜单行110 · 【输入数值】：打开全局音乐偏移输入对话框
#   复用设置面板注册的 rhythm_axe:options_music_offset（同一项设置，不另建 JSON ⇒ 无需重启世界）
#   prop.offset_ui = 来源标记：提交函数据此重绘「编辑器主菜单」而不是「设置面板」；取消也清掉
data modify storage rhythm_axe:prop offset_ui set value 1b
dialog show @s rhythm_axe:options_music_offset
