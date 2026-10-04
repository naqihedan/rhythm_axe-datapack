# 判定时间【使用当前时间】(12005)
# 绝对模式：判定时间 = 当前播放头（下界 0），语义与旧版一致；批量时补打 batch_set.time（视为已改，【确认】写回）
# 相对模式：增量 = 当前播放头 − 最早音符时间（最早音符 = 本次编辑对象里判定时间最早的那个：
#            单个音符 = 该音符本身；批量 = 选区中时间最早的音符）→ 使「第一个音符」正好落到播放头
# ★ 不再切换相对/绝对模式：按当前所处模式就地写入
scoreboard players set #uh_rel editor 0
execute store result score #uh_rel editor run data get storage rhythm_axe:maps.editor editing.rel.on.time
# 当前播放头
scoreboard players set #uh_ph editor 0
execute store result score #uh_ph editor run data get storage rhythm_axe:maps.editor playhead

# —— 绝对模式（与旧行为一致）——
execute if score #uh_rel editor matches 0 if score #uh_ph editor matches ..-1 run scoreboard players set #uh_ph editor 0
execute if score #uh_rel editor matches 0 run execute store result storage rhythm_axe:maps.editor editing.temp.time int 1 run scoreboard players get #uh_ph editor
execute if score #uh_rel editor matches 0 if data storage rhythm_axe:maps.editor editing.batch run data modify storage rhythm_axe:maps.editor editing.batch_set.time set value 1b

# —— 相对模式：增量 = 播放头 − 最早音符时间 ——
# 最早音符时间：单个音符 = editing.temp.time（【确认】时以其为基准）；批量 = 选区第一个（按 notes 顺序升序）音符的 time
scoreboard players set #uh_ref editor 0
execute if score #uh_rel editor matches 1 unless data storage rhythm_axe:maps.editor editing.batch run execute store result score #uh_ref editor run data get storage rhythm_axe:maps.editor editing.temp.time
execute if score #uh_rel editor matches 1 if data storage rhythm_axe:maps.editor editing.batch run function rhythm_axe:editor/menu/note/panel/note_use_head_first_time
scoreboard players operation #uh_delta editor = #uh_ph editor
scoreboard players operation #uh_delta editor -= #uh_ref editor
execute if score #uh_rel editor matches 1 run execute store result storage rhythm_axe:maps.editor editing.rel.delta.time int 1 run scoreboard players get #uh_delta editor

# 重渲面板（与其它字段按钮一致：就地刷新，不改面板/光标）
function rhythm_axe:editor/menu/note/panel/note_panel
