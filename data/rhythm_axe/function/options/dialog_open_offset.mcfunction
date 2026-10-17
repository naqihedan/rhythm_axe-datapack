# 打开「全局音乐偏移」输入对话框（设置面板页 0 行 127 的【输入数值】按钮 12705 调用）
# 清来源标记：从设置面板打开 → 提交后重绘设置面板（编辑器打开时由 editor/menu/offset_input 置回）
data remove storage rhythm_axe:prop offset_ui
dialog show @s rhythm_axe:options_music_offset
