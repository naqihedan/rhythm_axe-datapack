# [已废弃 2026-09-14 性能重构] 逻辑已内联进 spawn_one_ 的「快速②」（未出生：哨兵记 #vis_next 后 return）。
#   无调用者；保留仅为便于回滚。
# 未出生分支：记录第一个未出生 idx 到 #vis_next（播放游标起点；哨兵 999999 保证只记首次），再继续遍历
# 未出生音符不生成引导线实体（A 尚未出生，引出的线是悬空的；A 出生时由 spawn_go_/tick_birth 再生成）
#arg: cursor, note_idx
execute if score #vis_next editor matches 999999 run scoreboard players operation #vis_next editor = #vis_idx editor
function rhythm_axe:editor/visual/spawn_next_ with storage rhythm_axe:prop
