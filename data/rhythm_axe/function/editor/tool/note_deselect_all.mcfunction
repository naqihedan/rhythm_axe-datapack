# 蹲下右键音符：取消所有选中 —— ★ 直接照抄面板 10【取消选中】(11305) 的效果：只清空，不重建音符、不进撤销历史
# 前置：@s = 玩家（editor_active）
function rhythm_axe:editor/menu/note/selected/sel_clear_all_visual
data modify storage rhythm_axe:maps.editor feedback set value "已取消所有选中"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
function rhythm_axe:editor/menu/show_feedback
