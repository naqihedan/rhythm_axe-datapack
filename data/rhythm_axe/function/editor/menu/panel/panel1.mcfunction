# 面板 1：主菜单。规范v2：值 = 行号×100 + 低位码，行号 ≥100（固定控件行从 100 起）。
# 行100: 10001 编辑谱面信息 / 10002 时间点列表 / 10003 事件列表
# 行101: 10101 活跃音符列表 / 10102 已选音符列表
# 行102: 10201 音符工具 / 10202 时间轴控件
# 行103: 10301 撤销 / 10302 重做 / 10303 查找
# 行104: 10401 保存 / 10402 退出 / 10403 另存 / 10404 删除谱面 / 10405 回收站
# 行105: 10501 节拍器
# 行106: 10601/10602 流速减/加；10603..10606 流速设 2/4/8/16
# 注：20..29 时间控件由 consume 顶层处理；8/9 撤销重做、903 亦顶层。value 1=返回主菜单(供其它面板/刷新用)。
# main.mcfunction 设 current_panel=1。
execute unless score #click_value editor matches 1 unless score #click_value editor matches 10000..10999 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 1 unless score #click_value editor matches 10000..10999 run return fail

execute if score #click_value editor matches 1 run function rhythm_axe:editor/menu/main
execute if score #click_value editor matches 10001 run function rhythm_axe:editor/menu/map/panel/map_panel_open
execute if score #click_value editor matches 10002 run function rhythm_axe:editor/menu/timing/list/timing_list_open
execute if score #click_value editor matches 10003 run function rhythm_axe:editor/menu/event/list/event_list_open
execute if score #click_value editor matches 10101 run function rhythm_axe:editor/menu/note/list/note_list_open
execute if score #click_value editor matches 10102 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute if score #click_value editor matches 10201 run function rhythm_axe:editor/tool/give_note_tool
execute if score #click_value editor matches 10202 run function rhythm_axe:editor/tool/give_timeline_tool
execute if score #click_value editor matches 10301 run function rhythm_axe:editor/file/undo
execute if score #click_value editor matches 10301 run data modify storage rhythm_axe:maps.editor current_panel set value 1
execute if score #click_value editor matches 10301 run function rhythm_axe:editor/menu/resume
execute if score #click_value editor matches 10302 run function rhythm_axe:editor/file/redo
execute if score #click_value editor matches 10302 run data modify storage rhythm_axe:maps.editor current_panel set value 1
execute if score #click_value editor matches 10302 run function rhythm_axe:editor/menu/resume
execute if score #click_value editor matches 10303 run function rhythm_axe:editor/menu/find/find_open
execute if score #click_value editor matches 10401 run function rhythm_axe:editor/menu/save_now
execute if score #click_value editor matches 10402 run function rhythm_axe:editor/exit
execute if score #click_value editor matches 10403 run function rhythm_axe:editor/menu/save_as/save_as
execute if score #click_value editor matches 10404 run function rhythm_axe:editor/menu/map/panel/map_delete_confirm
execute if score #click_value editor matches 10405 run function rhythm_axe:editor/menu/trash/trash_panel_open
execute if score #click_value editor matches 10501 run function rhythm_axe:editor/menu/metronome_toggle

# 行106：音符流速（10601 降低 / 10602 提高，下界 1；10603..10606 直接设值）
execute if score #click_value editor matches 10601 run scoreboard players remove note_speed options 1
execute if score #click_value editor matches 10602 run scoreboard players add note_speed options 1
execute if score #click_value editor matches 10601..10602 if score note_speed options matches ..0 run scoreboard players set note_speed options 1
execute if score #click_value editor matches 10601..10602 run function rhythm_axe:editor/refresh
execute if score #click_value editor matches 10601..10602 run function rhythm_axe:editor/menu/main
execute if score #click_value editor matches 10603 run scoreboard players set note_speed options 2
execute if score #click_value editor matches 10604 run scoreboard players set note_speed options 4
execute if score #click_value editor matches 10605 run scoreboard players set note_speed options 8
execute if score #click_value editor matches 10606 run scoreboard players set note_speed options 16
execute if score #click_value editor matches 10603..10606 run function rhythm_axe:editor/refresh
execute if score #click_value editor matches 10603..10606 run function rhythm_axe:editor/menu/main
