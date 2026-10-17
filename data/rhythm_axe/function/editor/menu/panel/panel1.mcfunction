# 面板 1：主菜单。规范v2：值 = 行号×100 + 低位码，行号 ≥100（固定控件行从 100 起）。
# 行100: 10001 编辑谱面信息 / 10002 时间点列表 / 10003 事件列表
# 行101: 10101 活跃音符列表 / 10102 已选音符列表
# 行102: 10201 音符工具 / 10202 时间轴控件
# 行103: 10301 撤销 / 10302 重做 / 10303 查找
# 行104: 10401 保存 / 10402 退出 / 10403 另存 / 10404 删除谱面 / 10405 回收站（10406 重置谱面最高分已于 2026-10-01 移除，改到排行榜页的 [x]）
# 行105: 10501 节拍器 / 10502 判定开关（试听时音符真实判定，见《真实判定模式》）
# 行106: 10601/10602 编辑器流速减/加；10603..10606 编辑器流速设 2/4/8/16（★ 2026-10-17 起读写 options.editor_note_speed，与游玩流速 options.note_speed 分开）
# 行107: 10701 事件播放开关 / 10702 音符聊天反馈开关 / 10703 音符hotbar反馈开关（渲染在行106 上方，见 main.mcfunction）
# 行108: 10801 整理音符顺序（notes 按 time 升序重排；2026-09-15 从面板 2 迁来，保存谱面时也会自动执行一遍）
# 行109: 10905 领取协作工具（把协作工具放进背包第 1 格；2026-09-26 起不再随打开编辑器自动发放）
# 行110: 11001..11006 全局音乐偏移（★ 2026-10-17 新增，渲染在流速行下方）：11001 −5 / 11002 −1 / 11003 +1 / 11004 +5 / 11005 【输入数值】 / 11006 [🎶] 音符击打音效开关
#   ⚠ 11001/11002 与面板 2【人数 ±】数值相同 —— 面板隔离（按 current_panel 分发）下不会互串，与仓库其它跨面板同值同模式
# 行1150: 115001..115051 播放进度条 51 格（前 50 格等分 end_time，第 51 格跳结尾；值 = 1150×100 + 两位格号，前导零避开共用组 11501..11509）
# 注：20..29 时间控件由 consume 顶层处理；8/9 撤销重做、903 亦顶层。value 1=返回主菜单(供其它面板/刷新用)。
# main.mcfunction 设 current_panel=1。
execute unless score #click_value editor matches 1 unless score #click_value editor matches 10000..10999 unless score #click_value editor matches 11001..11006 unless score #click_value editor matches 115001..115051 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 1 unless score #click_value editor matches 10000..10999 unless score #click_value editor matches 11001..11006 unless score #click_value editor matches 115001..115051 run return fail

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
# 行105 列02【判定开关】（10502）：切换 options.editor_note_judge（0=自动预览 1=真实判定）
execute if score #click_value editor matches 10502 run function rhythm_axe:editor/menu/judge_toggle

# 行108【整理音符顺序】（10801；2026-09-15 从谱面设置面板迁到主菜单，值不变）
execute if score #click_value editor matches 10801 run function rhythm_axe:editor/menu/note/order_fix

# 行109【领取协作工具】（10905，2026-09-26）：把协作工具交给会话主（原先在 init_state 打开编辑器时自动发，
#   会无条件占掉背包第 1 格 ⇒ 改为自愿领取）；领取后右键队友=邀请、蹲下右键=踢出
execute if score #click_value editor matches 10905 run function rhythm_axe:editor/tool/give_coop_tool

# 行107：事件播放（10701，同时管谱面事件点 events[] 与音符击打事件 hit_events）/ 音符聊天反馈（10702）/ 音符hotbar反馈（10703）
execute if score #click_value editor matches 10701 run function rhythm_axe:editor/menu/event_play_toggle
execute if score #click_value editor matches 10702 run function rhythm_axe:editor/menu/note_feedback_chat_toggle
execute if score #click_value editor matches 10703 run function rhythm_axe:editor/menu/note_feedback_hotbar_toggle

# 行106：编辑器音符流速（10601 降低 / 10602 提高，下界 1；10603..10606 直接设值）
# ★ 2026-10-17：改用 options.editor_note_speed（游玩流速仍为 options.note_speed）
execute if score #click_value editor matches 10601 run scoreboard players remove editor_note_speed options 1
execute if score #click_value editor matches 10602 run scoreboard players add editor_note_speed options 1
execute if score #click_value editor matches 10601..10602 if score editor_note_speed options matches ..0 run scoreboard players set editor_note_speed options 1
execute if score #click_value editor matches 10601..10602 run function rhythm_axe:editor/refresh
execute if score #click_value editor matches 10601..10602 run schedule function rhythm_axe:editor/menu/main_next 1t
execute if score #click_value editor matches 10603 run scoreboard players set editor_note_speed options 2
execute if score #click_value editor matches 10604 run scoreboard players set editor_note_speed options 4
execute if score #click_value editor matches 10605 run scoreboard players set editor_note_speed options 8
execute if score #click_value editor matches 10606 run scoreboard players set editor_note_speed options 16
execute if score #click_value editor matches 10603..10606 run function rhythm_axe:editor/refresh
execute if score #click_value editor matches 10603..10606 run schedule function rhythm_axe:editor/menu/main_next 1t

# 行110：全局音乐偏移（11001 −5 / 11002 −1 / 11003 +1 / 11004 +5 / 11005 【输入数值】）
#   值存 options.music_offset（与设置面板行 127 同一项，单位 ms，正=音乐延后、负=音乐提前）；只影响音乐播放，不需要 refresh
#   ⚠ 不能写成一个 11001..11004 的大范围再分 delta（宏参数每行同值会串），逐个值各调一次
#   ⚠ 11005 打开对话框后不 return，落到本文件末尾无额外动作（对话框由 dialog 自管）
execute if score #click_value editor matches 11001 run function rhythm_axe:editor/menu/offset_step {delta:-5}
execute if score #click_value editor matches 11002 run function rhythm_axe:editor/menu/offset_step {delta:-1}
execute if score #click_value editor matches 11003 run function rhythm_axe:editor/menu/offset_step {delta:1}
execute if score #click_value editor matches 11004 run function rhythm_axe:editor/menu/offset_step {delta:5}
execute if score #click_value editor matches 11001..11004 run schedule function rhythm_axe:editor/menu/main_next 1t
execute if score #click_value editor matches 11005 run function rhythm_axe:editor/menu/offset_input
# 11006 = [🎶] 音符击打音效开关（翻转 options.hitsound_on，重绘主菜单）
execute if score #click_value editor matches 11006 run function rhythm_axe:editor/menu/hitsound_toggle

# 行1150：播放进度条（115001..115051）→ 播放头跳到该格左端时刻（第 51 格 = 结尾；跳转后暂停、刷新主菜单）
execute if score #click_value editor matches 115001..115051 run data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute if score #click_value editor matches 115001..115051 run function rhythm_axe:editor/menu/progress/click with storage rhythm_axe:prop
