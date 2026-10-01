# 【使用当前时间】（值 10305）：把「当前音乐位置」换算成预览起点（刻）填进暂存 panel_temp.preview_start
#   ⚠️ 不能直接把播放头刻赋给预览起点：预览起点这个「刻」在大厅预览里是 **50ms/刻**
#      （无 tick rate 调整），而编辑器内 1 刻 ≠ 50ms（tick rate 随时间点变）⇒ 先要当前音乐的**真实毫秒**：
#        rhythm_axe:editor_time.head_ms（mod 每刻按工作副本时间点分段算好，见 TimelineSync）
#        preview_start = 音乐毫秒 ÷ 50（四舍五入到刻）
#   读不到 head_ms（旧版 mod / 未进编辑器）时退化为直接用播放头刻（等价按 50ms/刻 估算）
scoreboard players set #pv_have editor 0
scoreboard players set #pv_ms editor 0
execute store result score #pv_ms editor run data get storage rhythm_axe:editor_time head_ms
execute if score #pv_ms editor matches 1.. run scoreboard players set #pv_have editor 1
execute if score #pv_have editor matches 0 run execute store result score #pv_ms editor run data get storage rhythm_axe:maps.editor playhead
execute if score #pv_have editor matches 1 run scoreboard players add #pv_ms editor 25
execute if score #pv_have editor matches 1 run scoreboard players operation #pv_ms editor /= 50 const
execute if score #pv_ms editor matches ..-1 run scoreboard players set #pv_ms editor 0
execute store result storage rhythm_axe:maps.editor panel_temp.preview_start int 1 run scoreboard players get #pv_ms editor
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
