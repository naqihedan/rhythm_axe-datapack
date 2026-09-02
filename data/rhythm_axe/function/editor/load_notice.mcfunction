# 重进存档提示（load 时调用）：编辑器状态持久化在命令存储中，重进存档仍保留
# 仅在编辑器确实开过（history_cursor 存在）时提示，避免残留计分板误报
execute if data storage rhythm_axe:maps.editor history_cursor run function rhythm_axe:editor/load_notice_go
