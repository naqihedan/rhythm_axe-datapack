# 播放 tick 清理：@s = 编辑器音符展示实体；kill 自身 + 同 note_id 的交互实体
scoreboard players operation #tmp_nid editor = @s note_id
# ★ 2026-09-20：kill 前先清 editor_n_* 计分项（kill 不清计分板项。播放时每个音符经过都会被本文件 kill，
#   不清就是「每播放一遍残留一整套」——实测堆到 133 万项 / 104MB，详见 note_scores_reset_）
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #tmp_nid editor run function rhythm_axe:editor/visual/note_scores_reset_
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #tmp_nid editor run kill @s
function rhythm_axe:editor/visual/note_scores_reset_
kill @s
