# 诊断函数：清理残留音符 + 手动生成一个混凝土 + 检查参数（排查 lt=0 / 看不到音符）
# 运行：/function rhythm_axe:test/debug_summon
# 预期：cur_note.note_base_life=16、展示实体 lt=16、life=16、交互实体 life=16；若上方有红色报错 = summon 某行失败
# 清理残留（上次中断/残留的音符实体与旧诊断实体）
# ★ kill 前必须 reset：本版本实体删除不自动清分，直接 kill 会残留坐标分（note_prev_* / note_c_dist = 坐标×100，如 1600）
scoreboard players reset @e[tag=note]
scoreboard players reset @e[tag=test_min]
scoreboard players reset @e[tag=test_n98]
kill @e[tag=note]
kill @e[tag=test_min]
kill @e[tag=test_n98]
# 手动设置 cur_note（等效于 spawn_one 处理后的状态）
data modify storage rhythm_axe:runtime cur_note set value {id:98,type:3,mapid:"test",pos_x:0.0,pos_y:1.5,pos_z:4.0,start_x:0.0,start_y:0.0,start_z:16.0,size:1.0,time:0,note_base_life:16,duration:9,density:8,position:[0.0,1.5,4.0],start_pos:[0.0,0.0,16.0]}
execute store result score #dbg_life play_state run data get storage rhythm_axe:runtime cur_note.note_base_life
tellraw @a [{"text":"[诊断] cur_note.note_base_life=","color":"green"},{"score":{"objective":"play_state","name":"#dbg_life"}}]
# 调用 summon（宏函数）
function rhythm_axe:play/note/summon with storage rhythm_axe:runtime cur_note
# 检查生成实体参数（若实体存在）
execute as @e[tag=test_n98,type=item_display] run tellraw @a [{"text":"[诊断] 展示实体 lt=","color":"gold"},{"score":{"objective":"note_c_lt","name":"@s"}}]
execute as @e[tag=test_n98,type=item_display] run tellraw @a [{"text":"[诊断] 展示实体 life=","color":"gold"},{"score":{"objective":"note_life","name":"@s"}}]
execute as @e[tag=test_n98,type=interaction] run tellraw @a [{"text":"[诊断] 交互实体 life=","color":"aqua"},{"score":{"objective":"note_life","name":"@s"}}]
tellraw @a [{"text":"[诊断] 完成：若上方有红色报错=summon某行失败；lt/life 应为 16","color":"green"}]
