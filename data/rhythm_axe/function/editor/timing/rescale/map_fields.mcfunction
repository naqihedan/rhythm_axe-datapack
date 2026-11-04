# ④ 谱面级刻字段：end_time（受【音乐对齐】开关 10701 控制）
# 前置：#rs_num/#rs_den/#rs_a/#rs_has_b/#rs_b/#rs_delta、prop.cursor（由 rescale/run 备好）
# ★ end_time 直接决定「谱面什么时候结束」，必须跟着换算。
#
# ★★ 播放头（maps.editor.playhead）**故意不缩放**（2026-10-29 实测结论）：
#   ① 它属于「编辑器会话状态」，不在 history 快照里 ⇒ 撤销无法还原（实测：撤销后 playhead
#      停在缩放后的 112，而谱面已回到 12tpb 的 168 语义 ⇒ 播放头落在错误位置）。
#   ② 它的唯一用途是「重开编辑器时回到上次位置」，缩放与否都不影响音频对齐
#      （真正影响对齐的是 notes/timing_points/end_time，那些都缩放好了）。
#   ③ tpb 也就是分辨率变了，用户在旧/新坐标系里看到的光标位置本来就该重新定位。
#   ⇒ 保持原值，避免「改了回不去」的不一致。若将来要做，必须先把播放头纳入快照。
# ⚠️ 本文件**不能出现 return**（return 会终止整条调用链）。
scoreboard players set #rs_fin editor 0
execute if score editor_scale_time options matches 1 run scoreboard players set #rs_fin editor 1

# ── end_time（未定义则跳过，保持「未定义 = 进度条红色」语义）──
scoreboard players set #rs_have_end editor 0
execute if score #rs_fin editor matches 1 run function rhythm_axe:editor/timing/rescale/end_leaf with storage rhythm_axe:prop
execute if score #rs_have_end editor matches 1 run scoreboard players operation #rs_t editor = #rs_end_v editor
execute if score #rs_have_end editor matches 1 run function rhythm_axe:editor/timing/rescale/fval
execute if score #rs_have_end editor matches 1 if score #rs_ft editor matches ..-1 run scoreboard players set #rs_ft editor 0
execute if score #rs_have_end editor matches 1 run function rhythm_axe:editor/timing/rescale/end_write with storage rhythm_axe:prop
scoreboard players reset #rs_fin editor
scoreboard players reset #rs_have_end editor