# 聊天栏主菜单：标题-作者 + 谱面/编辑/文件按钮 + 时间控件
# 文本组件 26.x 命名：click_event（run_command 用 command）、hover_event（show_text 用 value）
function rhythm_axe:editor/menu/clear_lines
function rhythm_axe:editor/menu/show_feedback
# 显示主菜单即视为处于编辑状态（保证 active 检查通过，避免直接调 main 后点按钮被拦截）
data modify storage rhythm_axe:maps.editor active set value 1b
data modify storage rhythm_axe:maps.editor current_panel set value 1
tellraw @s [{"text":"=========编辑器主菜单==========","color":"gold","bold":true}]
# 标题/作者行（history 游标动态，用宏展开）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/menu/main_header with storage rhythm_axe:prop
# 播放进度 bossbar：编辑器打开期间一直显示
function rhythm_axe:editor/menu/bossbar_show_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
tellraw @s [\
    {"text":"【编辑谱面信息】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10001"},"hover_event":{"action":"show_text","value":"标题/作者/音乐/血量等"}},\
    {"text":"【时间点列表】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10002"},"hover_event":{"action":"show_text","value":"打开时间点列表"}},\
    {"text":"【事件列表】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10003"},"hover_event":{"action":"show_text","value":"打开事件点列表"}},\
]
tellraw @s [\
    {"text":"【当前活跃音符列表】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10101"},"hover_event":{"action":"show_text","value":"查看当前存活音符"}},\
    {"text":"  【已选择音符列表】","color":"gold","click_event":{"action":"run_command","command":"/trigger editor_click set 10102"},"hover_event":{"action":"show_text","value":"查看被选中的音符（框选/左键选中）"}}\
]
# 物品栏工具行
# 音符工具：胡萝卜钓竿，手持看向前方 3 格右键放置音符（time=播放头，属性继承同类最近音符）
tellraw @s [\
    {"text":"【音符工具】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 10201"},"hover_event":{"action":"show_text","value":"给予胡萝卜钓竿工具：看向前方 3 格，右键在方块中心放置音符"}},\
    {"text":"  【时间轴控件】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 10202"},"hover_event":{"action":"show_text","value":"给予时间轴控件工具：返回开头/前后跳/播放暂停/调速"}}\
]
# 撤销/重做行（无可用快照时红色）★主菜单撤销/重做（150/151）：仅主菜单可点，撤销/重做后返回主菜单
# 操作反馈处的撤销/重做（8/9）保持原行为：撤销/重做后回 undo_panel 操作面板
execute store result score #temp_cursor editor run data get storage rhythm_axe:maps.editor history_cursor
execute store result score #history_size editor run data get storage rhythm_axe:maps.editor history
scoreboard players operation #temp_playhead editor = #history_size editor
scoreboard players remove #temp_playhead editor 1
execute if score #temp_cursor editor matches 1.. if score #temp_cursor editor < #temp_playhead editor run tellraw @s [\
    {"text":"【撤销】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10301"},"hover_event":{"action":"show_text","value":"回退到上一个快照"}},\
    {"text":"  【重做】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10302"},"hover_event":{"action":"show_text","value":"恢复到下一个快照"}},\
    {"text":"  【查找】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10303"},"hover_event":{"action":"show_text","value":"按时间/id 查找时间点、事件、音符"}}\
]
execute if score #temp_cursor editor matches 1.. unless score #temp_cursor editor < #temp_playhead editor run tellraw @s [\
    {"text":"【撤销】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10301"},"hover_event":{"action":"show_text","value":"回退到上一个快照"}},\
    {"text":"  【重做】","color":"red"},\
    {"text":"  【查找】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10303"},"hover_event":{"action":"show_text","value":"按时间/id 查找时间点、事件、音符"}}\
]
execute unless score #temp_cursor editor matches 1.. if score #temp_cursor editor < #temp_playhead editor run tellraw @s [\
    {"text":"【撤销】","color":"red"},\
    {"text":"  【重做】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10302"},"hover_event":{"action":"show_text","value":"恢复到下一个快照"}},\
    {"text":"  【查找】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10303"},"hover_event":{"action":"show_text","value":"按时间/id 查找时间点、事件、音符"}}\
]
execute unless score #temp_cursor editor matches 1.. unless score #temp_cursor editor < #temp_playhead editor run tellraw @s [\
    {"text":"【撤销】","color":"red"},\
    {"text":"  【重做】","color":"red"},\
    {"text":"  【查找】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10303"},"hover_event":{"action":"show_text","value":"按时间/id 查找时间点、事件、音符"}}\
]
tellraw @s [\
    {"text":"【保存谱面】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10401"},"hover_event":{"action":"show_text","value":"把当前内容写入谱面"}},\
    {"text":"  【退出编辑】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10402"},"hover_event":{"action":"show_text","value":"退出编辑器"}},\
    {"text":"  【另存为新谱面】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10403"},"hover_event":{"action":"show_text","value":"复制当前内容为 <原mapid>_copy 的新谱面（未保存，切换编辑）"}},\
    {"text":"  【删除谱面】","color":"red","click_event":{"action":"run_command","command":"/trigger editor_click set 10404"},"hover_event":{"action":"show_text","value":"把谱面移入回收站（可找回）"}},\
    {"text":"  【回收站】","color":"gold","click_event":{"action":"run_command","command":"/trigger editor_click set 10405"},"hover_event":{"action":"show_text","value":"查看回收站（可还原/彻底删除）"}}\
]
# 音符顺序行（行108）：notes 按 time 升序重排 —— 修复批量改判定时间造成的局部逆序
# ★ 2026-09-15 从谱面设置面板迁来（值不变 = 10801）；保存谱面时也会自动执行一遍，本按钮供手动排查
tellraw @s [\
    {"text":"音符顺序：","color":"gray"},\
    {"text":"【整理音符顺序】","color":"gold","click_event":{"action":"run_command","command":"/trigger editor_click set 10801"},"hover_event":{"action":"show_text","value":"把音符数组按判定时间升序重排（修复批量改时间造成的顺序错乱）；保存谱面时会自动执行"}}\
]
# 时间控件行（播放 ▶/⏸ 按状态显示）+ 速度按钮：同一行，按钮组件经 prop 注入宏 play_row
execute store result score #temp editor run data get storage rhythm_axe:maps.editor playing
data modify storage rhythm_axe:prop pb set value '{"text":" ▶ ","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 23"},"hover_event":{"action":"show_text","value":"播放"}}'
execute if score #temp editor matches 1 run data modify storage rhythm_axe:prop pb set value '{"text":" ⏸ ","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 23"},"hover_event":{"action":"show_text","value":"暂停"}}'
# 速度按钮（显示当前速度；默认 100% 兜底，防 play_speed 异常值导致宏参数缺失而整行不渲染）
execute store result score #temp editor run data get storage rhythm_axe:maps.editor play_speed 100
data modify storage rhythm_axe:prop speed_btn set value '{"text":"【100%】","color":"light_purple","click_event":{"action":"run_command","command":"/trigger editor_click set 27"},"hover_event":{"action":"show_text","value":"切换到 25%"}}'
execute if score #temp editor matches 25 run data modify storage rhythm_axe:prop speed_btn set value '{"text":"【25%】","color":"light_purple","click_event":{"action":"run_command","command":"/trigger editor_click set 27"},"hover_event":{"action":"show_text","value":"切换到 50%"}}'
execute if score #temp editor matches 50 run data modify storage rhythm_axe:prop speed_btn set value '{"text":"【50%】","color":"light_purple","click_event":{"action":"run_command","command":"/trigger editor_click set 27"},"hover_event":{"action":"show_text","value":"切换到 75%"}}'
execute if score #temp editor matches 75 run data modify storage rhythm_axe:prop speed_btn set value '{"text":"【75%】","color":"light_purple","click_event":{"action":"run_command","command":"/trigger editor_click set 27"},"hover_event":{"action":"show_text","value":"切换到 100%"}}'
function rhythm_axe:editor/menu/play_row with storage rhythm_axe:prop
data remove storage rhythm_axe:prop pb
data remove storage rhythm_axe:prop speed_btn
# 播放进度条行（51 格 '='：已播放黄绿 / 播放头黄 / 未播放灰；第 51 格点击直跳结尾）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/menu/progress/line with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
# 节拍器行：节拍器开关 + 判定开关 + 播放进度「当前刻/最终刻」（刻数用 #prog_head / #prog_end，由 progress/line 一并算好）
# 26.x 下 if data ... value 1b 解析报错 → 用复合标签 {metronome:1b} 判断（常见问题：布尔值用复合标签匹配）
data modify storage rhythm_axe:prop met set value '{"text":"【节拍器：关】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 10501"},"hover_event":{"action":"show_text","value":"点击开启节拍器"}}'
execute if data storage rhythm_axe:maps.editor {metronome:1b} run data modify storage rhythm_axe:prop met set value '{"text":"【节拍器：开】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10501"},"hover_event":{"action":"show_text","value":"点击关闭节拍器"}}'
# 游玩测试开关（值 10502，与节拍器同行）：开=试听时按真实游玩语义判定（需命中/看向/点击）；关=自动预览（等同 auto）
data modify storage rhythm_axe:prop jm set value '{"text":"【游玩测试：关】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 10502"},"hover_event":{"action":"show_text","value":"当前：试听时音符自动判定（等同 auto）。点击开启【游玩测试】——像真实游玩一样要命中/看向/点击"}}'
execute if score editor_note_judge options matches 1 run data modify storage rhythm_axe:prop jm set value '{"text":"【游玩测试：开】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10502"},"hover_event":{"action":"show_text","value":"当前：【游玩测试】进行中——音符要在判定窗内被命中/看向/点击才播音符事件（不计成绩/连击）。点击关闭"}}'
data modify storage rhythm_axe:prop end set value '{"text":"/","color":"gray"},{"score":{"name":"#prog_end","objective":"editor"},"color":"white"},{"text":" 刻","color":"gray"}'
execute unless score #prog_end editor matches 1.. run data modify storage rhythm_axe:prop end set value '{"text":"/","color":"gray"},{"text":"未定义","color":"red"},{"text":" 刻","color":"gray"}'
function rhythm_axe:editor/menu/metronome_row with storage rhythm_axe:prop
data remove storage rhythm_axe:prop met
data remove storage rhythm_axe:prop jm
data remove storage rhythm_axe:prop end
# 行107：事件播放 + 音符判定文字反馈（聊天栏 / hotbar）三个开关，位于音符流速行上方
# ★【事件播放】（10701）= options.editor_play_events：同时管【谱面事件点 events[]】与【音符击打事件 hit_events】
#   （2026-09-23 把原 editor_note_hitevents 并入本开关）
# ★【音符聊天反馈】（10702）= options.feedback_chat、【音符hotbar反馈】（10703）= options.feedback_actionbar：
#   编辑器真实判定的文字反馈与游玩共用这一对全局开关（见 editor/judge/feedback_text）
# 先写「关」再按分值覆盖为「开」：即使计分项未定义也不会误显示为开（不用 store result，避免沿用上一次的 #temp）
data modify storage rhythm_axe:prop ep set value '{"text":"【事件播放：关】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 10701"},"hover_event":{"action":"show_text","value":"当前已关闭：试听经过事件点不执行 events[]，经过音符判定时刻不执行 hit_events。点击开启"}}'
execute if score editor_play_events options matches 1 run data modify storage rhythm_axe:prop ep set value '{"text":"【事件播放：开】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10701"},"hover_event":{"action":"show_text","value":"启用谱面时间播放与音符击打事件"}}'
data modify storage rhythm_axe:prop fc set value '{"text":"【音符聊天反馈：关】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 10702"},"hover_event":{"action":"show_text","value":"当前已关闭：音符判定反馈不显示在聊天栏。点击开启"}}'
execute if score feedback_chat options matches 1 run data modify storage rhythm_axe:prop fc set value '{"text":"【音符聊天反馈：开】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10702"},"hover_event":{"action":"show_text","value":"音符判定反馈（Bad/Good/Perfect/Miss）显示在聊天栏；与游玩共用 options.feedback_chat"}}'
data modify storage rhythm_axe:prop fh set value '{"text":"【音符hotbar反馈：关】","color":"gray","click_event":{"action":"run_command","command":"/trigger editor_click set 10703"},"hover_event":{"action":"show_text","value":"当前已关闭：音符判定反馈不显示在物品栏上方。点击开启"}}'
execute if score feedback_actionbar options matches 1 run data modify storage rhythm_axe:prop fh set value '{"text":"【音符hotbar反馈：开】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10703"},"hover_event":{"action":"show_text","value":"音符判定反馈（含虚拟血量/连击）显示在物品栏上方；与游玩共用 options.feedback_actionbar"}}'
function rhythm_axe:editor/menu/event_row with storage rhythm_axe:prop
data remove storage rhythm_axe:prop ep
data remove storage rhythm_axe:prop fc
data remove storage rhythm_axe:prop fh
# 音符流速（读改全局 note_speed；调低显示更多音符、调高聚焦一小段；调整后刷新世界音符状态）
execute store result score #temp editor run scoreboard players get note_speed options
tellraw @s [\
    {"text":"音符流速：","color":"gray"},\
    {"text":"[-]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10601"},"hover_event":{"action":"show_text","value":"降低流速（显示更多音符）"}},\
    {"score":{"name":"#temp","objective":"editor"},"color":"white"},\
    {"text":" [+]","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10602"},"hover_event":{"action":"show_text","value":"提高流速（聚焦少量音符）"}},\
    {"text":"  【2】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 10603"},"hover_event":{"action":"show_text","value":"流速设为 2"}},\
    {"text":"【4】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 10604"},"hover_event":{"action":"show_text","value":"流速设为 4"}},\
    {"text":"【8】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 10605"},"hover_event":{"action":"show_text","value":"流速设为 8"}},\
    {"text":"【16】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 10606"},"hover_event":{"action":"show_text","value":"流速设为 16"}}\
]
tellraw @s [{"text":"（修改经面板暂存，【保存谱面】才写入谱面）","color":"gray","italic":true}]
