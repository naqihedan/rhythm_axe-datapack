# 清除锚点（清空选区 / 退出编辑器 / 切换谱面）：实体与「被改过」标记一起消失
#   → 下次选中音符时按包围盒中心重新生成（= 回到自动跟随）
# 由 sel_clear_all_visual（面板 10【取消选中】/ 面板 18【清空选中并返回】/ 蹲下右键全取消 / 时间段选择 / 批量删除剪切等）、
#   clear_state（init_state 打开谱面、exit_do 退出编辑器）、give_note_tool / give_select_tool（重新发工具会清选区）调用；
#   sel_rebuild 在空选区时也会兜底调
kill @e[tag=editor_anchor]
data remove storage rhythm_axe:prop anc_cursor
