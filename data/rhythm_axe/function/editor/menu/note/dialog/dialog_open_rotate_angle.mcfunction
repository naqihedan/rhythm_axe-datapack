# 打开「自定义旋转角度」对话框（JSON：editor_rotate_angle.json；提交 → dialog_submit_rotate_angle）
# 入口：底部翻转/旋转组【自定义角度】= 11515（面板 10 / 18 共用）
# 对话框只负责收角度；提交后由 dialog_submit_rotate_angle_core 查 trig_table 得 cos/sin，
# 再走与预设按钮完全相同的 note_panel_rotate（中心 = 锚点、按 [X][Y][Z] 轴、[S] 连带起始位置）。
dialog show @s rhythm_axe:editor_rotate_angle
