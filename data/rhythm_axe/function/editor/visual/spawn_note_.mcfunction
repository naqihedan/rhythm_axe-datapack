# 遍历单步（宏叶子）：只处理 notes[$(note_idx)] 这一个音符，**不递归**（推进由 spawn_drive 负责）
# 音符存在 → 交给 spawn_one_；不存在（越界）→ 置 #vis_stop=1 结束遍历
# ★ 2026-09-14：原先这里与 spawn_one_/spawn_next_ 形成纯宏递归链（实测有 ~1.47 倍重复执行）。
#arg: cursor, note_idx
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].id run function rhythm_axe:editor/visual/spawn_one_ with storage rhythm_axe:prop
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)].id run scoreboard players set #vis_stop editor 1
