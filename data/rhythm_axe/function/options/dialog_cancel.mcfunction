# 对话框取消：仅提示，不改动任何设置（设置面板专用，与编辑器 dialog_cancel 分开）
# 清来源标记（防：在编辑器里打开后取消 → 下次从设置面板提交时错重绘编辑器）
data remove storage rhythm_axe:prop offset_ui
tellraw @s [{"text":"[设置] ","color":"gray"},{"text":"已取消输入","color":"yellow"}]
