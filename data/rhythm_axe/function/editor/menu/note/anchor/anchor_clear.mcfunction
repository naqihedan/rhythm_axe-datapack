# 清除锚点（清空选区 / 退出编辑器 / 切换谱面）：实体与「被改过」标记一起消失
#   → 下次选中音符时按包围盒中心重新生成（= 回到自动跟随）
# 由 sel_clear_all_visual / clear_state（init_state 打开谱面、exit_do 退出编辑器）调用；sel_rebuild 在空选区时也会兜底调
kill @e[tag=editor_anchor]
data remove storage rhythm_axe:prop anc_cursor
