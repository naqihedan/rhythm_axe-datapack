# 暂停瞬间回填「应在的位置」（@s = 音符展示实体）
# ★ 背景（2026-10-07 修）：editor_should_*（Axiom 手动偏移检测用）只在 visual/place 里写，
#   而 place 只在**播放中**运行（visual/tick = 播放中每刻）；play_inter_apply 里又把它改成
#   「仅非播放时写」⇒ 两条合起来 = 基本永远不写 ⇒ 播放中新出生的音符没有 editor_should_*，
#   暂停后 shift+左击报「无法读取偏移（音符未定位/缺少应该在的位置）」。
# ⇒ 暂停时补一次：值直接取展示实体的 editor_n_vx/vy/vz 缓存
#   （= 上一刻 place 算出的「应在位置」，播放中每刻更新；暂停后音符冻结，故这份快照一直有效）。
# ★ 只调 place_inter_should（只写 editor_should_*，**不写 Pos**）——
#   Pos 与 should 之差就是 Axiom 手动偏移，覆盖 Pos 会把用户拖出来的偏移抹掉。
# ★★ Y 要减 size/2：展示实体的 editor_n_vy 是**视觉中心**（= 交互脚底 + size/2，见 place 末尾那三行），
#    而 editor_should_y 要的是**交互实体的 Y（底部中心）** ⇒ 必须减掉，否则 should_y 大 size/2、
#    算出的偏移 Y 小 size/2，应用后音符会低 size/2。
scoreboard players operation #ix editor = @s editor_n_vx
scoreboard players operation #iy editor = @s editor_n_vy
scoreboard players operation #iz editor = @s editor_n_vz
scoreboard players operation #tmp_v editor = @s editor_n_size
scoreboard players operation #tmp_v editor /= 2 const
scoreboard players operation #iy editor -= #tmp_v editor
execute store result storage rhythm_axe:prop pnid int 1 run scoreboard players get @s note_id
function rhythm_axe:editor/visual/should_fill_pair with storage rhythm_axe:prop
