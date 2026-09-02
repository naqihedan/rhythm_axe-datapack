# 事件系统诊断（游戏运行中手动运行：/function rhythm_axe:test/debug_events）
# 用法：/reload → /function rhythm_axe:test/build_test_map → 开始游玩后运行
tellraw @a ["","=== 事件系统诊断 ==="]
# 1. runtime.events 是否被 merge 进来（start 把 maps.<mapid> 全量 merge 到 runtime）
execute if data storage rhythm_axe:runtime events run tellraw @a ["",{"text":"runtime.events 存在","color":"green"}]
execute unless data storage rhythm_axe:runtime events run tellraw @a ["",{"text":"runtime.events 不存在！(merge 失败或 maps.test.events 为空)","color":"red"}]
# 2. 谱面存储里 events 是否构建成功
execute if data storage rhythm_axe:maps.test events run tellraw @a ["",{"text":"maps.test.events 存在","color":"green"}]
execute unless data storage rhythm_axe:maps.test events run tellraw @a ["",{"text":"maps.test.events 不存在！(build_test_map 的 events append 失败)","color":"red"}]
# 3. 第一个事件内容（确认结构 time/commands）
execute if data storage rhythm_axe:runtime events run tellraw @a ["",{"text":"runtime.events[0]: ","color":"yellow"},{"nbt":"events[0]","storage":"rhythm_axe:runtime"}]
# 4. 游标与时间
execute store result score #dbg_ec play_state run scoreboard players get #event_cursor play_state
tellraw @a ["",{"text":"#event_cursor: ","color":"yellow"},{"score":{"objective":"play_state","name":"#event_cursor"}},{"text":"   |   time: ","color":"yellow"},{"score":{"objective":"play_state","name":"time"}}]
