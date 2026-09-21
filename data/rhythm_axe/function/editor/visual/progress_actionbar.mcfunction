# 播放进度 actionbar（当前刻/总刻数；总刻数=bossbar max=谱面设置 end_time）
# 仅用于「一次性」提示：快进/快退/回到开头、打开谱面收尾（finish_open）
# ★ 2026-09-20 不再在播放中每 tick 调用（见 visual/tick 注释）：
#   每刻刷新会把 actionbar 顶掉，真实判定的 PERFECT/GOOD/MISS 文字刚显示就被进度覆盖。
#   播放中的进度改看 bossbar（一直可见）+ 主菜单节拍器行的「当前刻/最终刻」。
execute store result score #temp editor run bossbar get rhythm_axe:editor_progress max
execute if score #temp editor matches 1.. run title @a[tag=editor_active] actionbar [{"text":"播放进度：","color":"gray"},{"score":{"name":"#playhead","objective":"editor"},"color":"gold"},{"text":" / ","color":"gray"},{"score":{"name":"#temp","objective":"editor"},"color":"gold"},{"text":" 刻","color":"gray"}]
execute if score #temp editor matches ..0 run title @a[tag=editor_active] actionbar [{"text":"播放进度：","color":"gray"},{"score":{"name":"#playhead","objective":"editor"},"color":"gold"},{"text":" 刻","color":"gray"}]
