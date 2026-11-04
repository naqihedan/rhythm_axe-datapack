#arg:nid
# 熄灭同 note_id 的音符视觉（select_mark_glow / time_select_tag 的反操作）：
#   展示实体 Glowing=0b + 移除 glow_color_override；交互实体移除 editor_note_selected 标签。
# ★ 2026-11-04 补：原来「查找选区内筛选」把不命中音符移出选区时只 `data remove …notes[i].selected`，
#   完全没碰实体 ⇒ 世界里的音符仍然发着黄光（用户实测：列表只剩 7 个混凝土、却看到被移除的 3 个音符盒还在发黄光）。
#   凡是「把音符移出选区」的路径都必须同时熄灯，否则「选中标记 / 选区数组 / 世界视觉」三者会不同步。
# 实体不存在（音符未出生/已消失）时选择器空匹配，无副作用。
$execute as @e[tag=editor_n_$(nid),type=item_display] run data modify entity @s Glowing set value 0b
$execute as @e[tag=editor_n_$(nid),type=item_display] run data remove entity @s glow_color_override
$tag @e[type=interaction,tag=editor_n_$(nid)] remove editor_note_selected