# 已设入点（state=1，等待出点）时，把出点同步到当前播放头（★ mod 侧把「出入点同刻」当只有入点画，故刚点完不显示出点）
#   ★ 由 function/tick.mcfunction 在「编辑器打开 + 暂停中」时每 tick 调用 →
#     快进/快退、跳到开头/结尾、播放切回暂停……凡是暂停状态下播放头的位置变化，出点都会跟手
#   ★ 只更新出点标记，**不做区间判定、不改变选中**（真正选中仍需蹲右键点第二下）
#   注意：本函数每 tick 都会跑，务必保持轻量、不要 @s / 不要 tellraw
scoreboard players set #ts_state editor 0
execute store result score #ts_state editor run data get storage rhythm_axe:maps.editor time_select.state
# 只在「已设入点、还没定出点」时生效
execute unless score #ts_state editor matches 1 run return 0
execute unless data storage rhythm_axe:maps.editor time_select.in run return 0
data modify storage rhythm_axe:maps.editor time_select.out set from storage rhythm_axe:maps.editor playhead
