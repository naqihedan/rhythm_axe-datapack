# note_panel_flip_time 的「下一刻执行」包装：schedule 拉起时执行者是服务端（没有 @s），先切回正在用编辑器的玩家再干活。
execute as @a[tag=editor_active] run function rhythm_axe:editor/menu/note/panel/note_panel_flip_time_go