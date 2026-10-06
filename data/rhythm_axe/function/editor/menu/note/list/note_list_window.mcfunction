# 计算音符列表本次遍历的「数组下标窗口」[#note_lo, #note_hi)
# ★ 2026-10-06 性能：列表只显示**当前存活**音符 —— 存活 ⟺ 出生刻 ≤ 播放头 ≤ 消失刻，
#   而出生刻 = time − 前导、消失刻 = time + 尾长 ⇒ 存活音符的 time ∈ [播放头 − 最大尾长, 播放头 + 最大前导]。
#   notes[] 按 time 升序（editor/util/order_repair 维护）⇒ 用 insert_find 二分定位该时间区间的下标区间，
#   只遍历窗口内的音符（1243 音符实测：窗口内只有几十个，取代原先 3 趟 ×1243 的全表宏遍历 ≈450ms）。
#   上界缓存 vis_lead_max / vis_trail_max 由 refresh 遍历时统计（只增不减 ⇒ 偏保守）；
#   缺缓存（刚 reload / 还没打开过谱面）→ 退回全表（行为与旧实现一致）。
#   ⚠ 窗口只能宽不能窄：列表的出生/消失公式与视觉公式略有差异（线性提前 4 刻、玻璃后段按流速缩放），
#     故两侧各留 8 刻安全余量。
# 前置：prop.cursor（工作副本下标）已设置；本函数不改动它
# 输出：#note_lo / #note_hi（左闭右开），供 note_list_render / note_list_row_advance / row2 使用
#   缺缓存时：#note_lo=0、#note_hi=数组长度（走 note_list_count）
scoreboard players set #note_lo editor 0
scoreboard players set #note_hi editor 0
execute unless data storage rhythm_axe:editor.runtime vis_lead_max run function rhythm_axe:editor/menu/note/list/note_list_count with storage rhythm_axe:prop
execute unless data storage rhythm_axe:editor.runtime vis_lead_max run scoreboard players operation #note_hi editor = #note_total editor
execute unless data storage rhythm_axe:editor.runtime vis_lead_max run return 0
# 缺尾长缓存 → 按 0 处理（下界只靠 8 刻余量，仍偏保守）
execute unless data storage rhythm_axe:editor.runtime vis_trail_max run data modify storage rhythm_axe:editor.runtime vis_trail_max set value 0
# ── 下界：首个 time ≥ 播放头 − 最大尾长 − 8 的下标
#   （insert_find 返回「首个 time > new_time」⇒ new_time 再减 1，使「相等」也纳入）
execute store result score #nl_time editor run scoreboard players get #playhead editor
execute store result score #nl_span editor run data get storage rhythm_axe:editor.runtime vis_trail_max
scoreboard players add #nl_span editor 9
scoreboard players operation #nl_time editor -= #nl_span editor
data modify storage rhythm_axe:prop list_name set value "notes"
execute store result storage rhythm_axe:prop new_time int 1 run scoreboard players get #nl_time editor
function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
execute store result score #note_lo editor run data get storage rhythm_axe:prop index
# ── 上界（开区间）：首个 time > 播放头 + 最大前导 + 8 的下标
execute store result score #nl_time editor run scoreboard players get #playhead editor
execute store result score #nl_span editor run data get storage rhythm_axe:editor.runtime vis_lead_max
scoreboard players add #nl_span editor 8
scoreboard players operation #nl_time editor += #nl_span editor
execute store result storage rhythm_axe:prop new_time int 1 run scoreboard players get #nl_time editor
function rhythm_axe:editor/util/insert_find with storage rhythm_axe:prop
execute store result score #note_hi editor run data get storage rhythm_axe:prop index
# 清理临时（prop.cursor 归调用方管理，此处不动）
data remove storage rhythm_axe:prop list_name
data remove storage rhythm_axe:prop new_time
data remove storage rhythm_axe:prop insert_mode
data remove storage rhythm_axe:prop insert_index
data remove storage rhythm_axe:prop i
