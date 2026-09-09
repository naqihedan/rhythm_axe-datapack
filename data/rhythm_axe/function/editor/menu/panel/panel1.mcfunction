# 面板 1：主菜单（打开各列表/工具/查找/保存/退出/另存/删除谱面/回收站/撤销重做/音符流速）。
# main.mcfunction 设 current_panel=1。注：8/9 撤销重做、20..29 时间控件、903 由 consume 顶层统一处理（任意面板可用），此处不重复。
# 入口白名单守卫
execute unless score #click_value editor matches 1..15 unless score #click_value editor matches 131..132 unless score #click_value editor matches 137..138 unless score #click_value editor matches 139..142 unless score #click_value editor matches 150..151 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 1..15 unless score #click_value editor matches 131..132 unless score #click_value editor matches 137..138 unless score #click_value editor matches 139..142 unless score #click_value editor matches 150..151 run return fail

# 打开各面板 / 工具
execute if score #click_value editor matches 1 run function rhythm_axe:editor/menu/main
execute if score #click_value editor matches 2 run function rhythm_axe:editor/menu/map/panel/map_panel_open
execute if score #click_value editor matches 3 run function rhythm_axe:editor/menu/timing/list/timing_list_open
execute if score #click_value editor matches 4 run function rhythm_axe:editor/menu/event/list/event_list_open
execute if score #click_value editor matches 5 run function rhythm_axe:editor/tool/give_note_tool
execute if score #click_value editor matches 6 run function rhythm_axe:editor/tool/give_timeline_tool
execute if score #click_value editor matches 7 run function rhythm_axe:editor/menu/metronome_toggle
execute if score #click_value editor matches 14 run function rhythm_axe:editor/menu/note/list/note_list_open
execute if score #click_value editor matches 15 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute if score #click_value editor matches 10 run function rhythm_axe:editor/menu/find/find_open
execute if score #click_value editor matches 11 run function rhythm_axe:editor/menu/save_now
execute if score #click_value editor matches 12 run function rhythm_axe:editor/exit
execute if score #click_value editor matches 13 run function rhythm_axe:editor/menu/save_as/save_as
# 删除谱面（进面板 16）/ 回收站（进面板 17）
execute if score #click_value editor matches 137 run function rhythm_axe:editor/menu/map/panel/map_delete_confirm
execute if score #click_value editor matches 138 run function rhythm_axe:editor/menu/trash/trash_panel_open

# —— 主菜单音符流速（131 降低 / 132 提高，读改全局 note_speed，下界 1；调整后刷新世界音符）——
execute if score #click_value editor matches 131 run scoreboard players remove note_speed options 1
execute if score #click_value editor matches 132 run scoreboard players add note_speed options 1
execute if score #click_value editor matches 131..132 if score note_speed options matches ..0 run scoreboard players set note_speed options 1
execute if score #click_value editor matches 131..132 run function rhythm_axe:editor/refresh
execute if score #click_value editor matches 131..132 run function rhythm_axe:editor/menu/main
# 主菜单音符流速直接设值（139/140/141/142 = 2/4/8/16；调整后刷新世界音符）
execute if score #click_value editor matches 139 run scoreboard players set note_speed options 2
execute if score #click_value editor matches 140 run scoreboard players set note_speed options 4
execute if score #click_value editor matches 141 run scoreboard players set note_speed options 8
execute if score #click_value editor matches 142 run scoreboard players set note_speed options 16
execute if score #click_value editor matches 139..142 run function rhythm_axe:editor/refresh
execute if score #click_value editor matches 139..142 run function rhythm_axe:editor/menu/main

# —— 主菜单撤销/重做（150/151）：仅主菜单；撤销/重做后强制回主菜单 ——
execute if score #click_value editor matches 150 run function rhythm_axe:editor/file/undo
execute if score #click_value editor matches 150 run data modify storage rhythm_axe:maps.editor current_panel set value 1
execute if score #click_value editor matches 150 run function rhythm_axe:editor/menu/resume
execute if score #click_value editor matches 151 run function rhythm_axe:editor/file/redo
execute if score #click_value editor matches 151 run data modify storage rhythm_axe:maps.editor current_panel set value 1
execute if score #click_value editor matches 151 run function rhythm_axe:editor/menu/resume
