# 【用起点到播放头】（值 10306）：把「预览起点 → 当前播放头」的时差填进**暂存**预览时长
#   两个量最终都是**大厅口径**（1 刻 = 50ms），所以先统一到音乐毫秒再相减：
#       预览时长(刻) = round(当前音乐毫秒 ÷ 50) − 预览起点(刻)
#   当前音乐毫秒取 mod 算好的 rhythm_axe:editor_time.head_ms
#   （⚠️ 编辑器内 1 刻 ≠ 50ms —— tick rate 随时间点变，所以不能拿播放头刻直接当毫秒用）
#   ⚠️ 当前播放头位置 ≤ 预览起点 ⇒ **什么都不做**（用户要求：静默，不改数据）
#   ⚠️ 只改暂存 panel_temp.preview_len —— 和 10303/10304 一样，要点【保存设置】才写进谱面
scoreboard players set #plen_have editor 0
scoreboard players set #plen_ms editor 0
execute store result score #plen_ms editor run data get storage rhythm_axe:editor_time head_ms
execute if score #plen_ms editor matches 1.. run scoreboard players set #plen_have editor 1
# 读不到 head_ms（旧版 mod / 未进编辑器）→ 退化为「播放头刻 × 50ms」
execute if score #plen_have editor matches 0 run execute store result score #plen_ms editor run data get storage rhythm_axe:maps.editor playhead
execute if score #plen_have editor matches 0 run scoreboard players operation #plen_ms editor *= 50 const
# 毫秒 → 50ms 单位的刻（四舍五入）
scoreboard players add #plen_ms editor 25
scoreboard players operation #plen_ms editor /= 50 const
# 减去预览起点 → 时差（刻）
scoreboard players set #plen_start editor 0
execute store result score #plen_start editor run data get storage rhythm_axe:maps.editor panel_temp.preview_start
scoreboard players operation #plen_ms editor -= #plen_start editor
# ≤0（播放头没到起点）→ 静默返回，一个键都不动
execute if score #plen_ms editor matches ..0 run return 0
# 与 10303/10304 的值域保持一致（1..12000 刻）
execute if score #plen_ms editor matches 12001.. run scoreboard players set #plen_ms editor 12000
execute store result storage rhythm_axe:maps.editor panel_temp.preview_len int 1 run scoreboard players get #plen_ms editor
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
