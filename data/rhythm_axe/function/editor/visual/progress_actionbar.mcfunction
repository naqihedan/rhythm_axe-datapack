# 播放进度 actionbar（当前刻/总刻数；总刻数=bossbar max=谱面设置 end_time）
# 播放每 tick 与时间控件（快进/快退/回到开头）共用
execute store result score #temp editor run bossbar get rhythm_axe:editor_progress max
execute if score #temp editor matches 1.. run title @a[tag=editor_active] actionbar [{"text":"播放进度：","color":"gray"},{"score":{"name":"#playhead","objective":"editor"},"color":"gold"},{"text":" / ","color":"gray"},{"score":{"name":"#temp","objective":"editor"},"color":"gold"},{"text":" 刻","color":"gray"}]
execute if score #temp editor matches ..0 run title @a[tag=editor_active] actionbar [{"text":"播放进度：","color":"gray"},{"score":{"name":"#playhead","objective":"editor"},"color":"gold"},{"text":" 刻","color":"gray"}]
