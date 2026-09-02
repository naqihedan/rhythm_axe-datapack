# 音符设置面板返回来源（从哪来回哪去：10 活跃列表 / 18 已选定列表 / 1 主菜单 / 其它兜底回活跃列表）；前置：#from editor 已读来源面板
execute if score #from editor matches 18 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute if score #from editor matches 10 run function rhythm_axe:editor/menu/note/list/note_list_open
execute if score #from editor matches 1 run function rhythm_axe:editor/menu/main
execute unless score #from editor matches 18 unless score #from editor matches 10 unless score #from editor matches 1 run function rhythm_axe:editor/menu/note/list/note_list_open
