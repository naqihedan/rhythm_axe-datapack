# 播放 tick 清理：@s = 编辑器音符展示实体；kill 自身 + 同 note_id 的交互实体
scoreboard players operation #tmp_nid editor = @s note_id
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #tmp_nid editor run kill @s
kill @s
