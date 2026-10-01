# 时间点列表【删除】前置：点击值 = (1000+行序)×100 + 7 → prop.index
# ★ 列表行的删除是【直接删】（自带历史快照、可用【撤销】找回），不加确认框（2026-10-01 用户确认）
scoreboard players operation #temp editor = #click_value editor
scoreboard players operation #temp editor /= 100 const
scoreboard players remove #temp editor 1000
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute store result storage rhythm_axe:prop index int 1 run scoreboard players get #temp editor
function rhythm_axe:editor/menu/timing/list/timing_list_delete_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop index
