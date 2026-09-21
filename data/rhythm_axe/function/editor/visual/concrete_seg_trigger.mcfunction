# 混凝土密度段判定（**自动预览模式**：等同游玩 auto，每段到点自动判 P）
# @s = 混凝土展示实体；rel == seg×density 由 tick_one 保证（段 0 = time 首段）
# ★ 游玩测试模式（options.editor_note_judge=1）不走这里 —— 改走 judge/concrete_check（判定区域 + 分段 + 保护1/2）
# ★ 不打 editor_n_triggered（混凝土多段、每段独立；普通音符的 trigger 才打该 tag）
function rhythm_axe:editor/visual/concrete_feedback
# 段计数 +1（下段判定）
scoreboard players add @s editor_n_seg 1
