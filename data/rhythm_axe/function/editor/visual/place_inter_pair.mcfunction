# 配对交互实体写入（O(1) 查找）：交互实体与展示实体**共用** per-note tag `editor_n_<nid>`（summon_ 里已加）
# ★ 2026-10-03 性能（实测归因）：原写法是
#     execute as @e[type=interaction,tag=editor_note] if score @s note_id = #iid editor run …
#   ⇒ 每个音符**每刻**遍历全部在屏交互实体 = O(n²)/刻。52 音符实测约占播放每刻耗时的一半
#     （A/B：屏蔽该行后密集段中位数 63.6ms → 27.4ms）。
#   现在改成：place 先把自己的 note_id 写进 prop.pnid，再调本宏 → 单次 tag 选择器 = O(1)。
#   交互实体数量与音符一一对应（summon 时同 tag 生成、kill 时同 tag 清除），故 limit=1 恒中。
# 前置：place 已算好 #ix/#iy/#iz（世界坐标 ×1000）；prop.pnid = 本音符 id
# ★ 本文件【只能】作为宏函数调用：function rhythm_axe:editor/visual/place_inter_pair with storage rhythm_axe:prop
#arg: pnid
$execute as @e[tag=editor_n_$(pnid),type=interaction,limit=1] run function rhythm_axe:editor/visual/place_inter_apply
