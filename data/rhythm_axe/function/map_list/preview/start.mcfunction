# 开始预览（全局状态 + **只发给正在看总表的人**的音源）
# 前置（调用方 sel/select 写好）：prop.music / prop.pv_start / prop.pv_len
#   （谱面字段 music / preview_start / preview_len 的副本；preview_start = 从第几刻起播、preview_len = 播多少刻）
# ★ 停止时机：schedule 的**时间参数可以宏注入**（见 preview/arm）⇒ 不用再「每 5 刻自检一次」比截止刻，
#   而是把 preview_len 直接当成延时（`$(pv_len)t`），到点由 preview/stop 自己停（误差 0 刻）。
# 时长兜底（缺失 / ≤0 → 200 刻）：保证拼出来的是合法时间（如 `200t`），不会出现 `0t`/`-1t`
scoreboard players set #prev_len menu 0
execute store result score #prev_len menu run data get storage rhythm_axe:prop pv_len
execute if score #prev_len menu matches ..0 run data modify storage rhythm_axe:prop pv_len set value 200
data modify storage rhythm_axe:map_list prev set value 1b
function rhythm_axe:map_list/preview/arm with storage rhythm_axe:prop
# 出声：谱面没 music 字段就只切状态（提示一下，不算错）
execute unless data storage rhythm_axe:prop music run tellraw @s [{"text":"[大厅] ","color":"gold"},{"text":"这张谱面没有设置音乐文件，预览不会出声","color":"gray"}]
execute if data storage rhythm_axe:prop music run function rhythm_axe:map_list/preview/play with storage rhythm_axe:prop
