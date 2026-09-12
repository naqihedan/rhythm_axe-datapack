# 清空 maps.editor 的全部键与 editor 计分板镜像（供 init_state / exit 复用）
data remove storage rhythm_axe:maps.editor mapid
data remove storage rhythm_axe:maps.editor active
data remove storage rhythm_axe:maps.editor player
data remove storage rhythm_axe:maps.editor history
data remove storage rhythm_axe:maps.editor history_cursor
data remove storage rhythm_axe:maps.editor saved_cursor
data remove storage rhythm_axe:maps.editor clipboard
data remove storage rhythm_axe:maps.editor selection
data remove storage rhythm_axe:maps.editor select_tool
data remove storage rhythm_axe:maps.editor time_select
data remove storage rhythm_axe:maps.editor playhead
data remove storage rhythm_axe:maps.editor next_note_id
data remove storage rhythm_axe:maps.editor playing
data remove storage rhythm_axe:maps.editor play_speed
data remove storage rhythm_axe:maps.editor timeline_length
data remove storage rhythm_axe:maps.editor metronome
data remove storage rhythm_axe:maps.editor tool_group
data remove storage rhythm_axe:maps.editor tool_page
data remove storage rhythm_axe:maps.editor tool_note_type
data remove storage rhythm_axe:maps.editor tool_cursor_x
data remove storage rhythm_axe:maps.editor tool_cursor_y
data remove storage rhythm_axe:maps.editor tool_cursor_z
data remove storage rhythm_axe:maps.editor editing
data remove storage rhythm_axe:maps.editor delete_confirm
data remove storage rhythm_axe:maps.editor input
data remove storage rhythm_axe:maps.editor panel_temp
data remove storage rhythm_axe:maps.editor current_panel
data remove storage rhythm_axe:maps.editor feedback
data remove storage rhythm_axe:maps.editor history_labels
data remove storage rhythm_axe:maps.editor op_label
data remove storage rhythm_axe:maps.editor last_label
# 各面板行级剪贴板与切换目标（退出编辑器/切换谱面时一并清空）
data remove storage rhythm_axe:maps.editor timing_clip
data remove storage rhythm_axe:maps.editor event_clip
data remove storage rhythm_axe:maps.editor note_clip
data remove storage rhythm_axe:maps.editor pending_mapid
scoreboard players reset #playhead editor
scoreboard players reset #metronome editor
scoreboard players reset #history_cursor editor
scoreboard players reset #hist_limit editor
scoreboard players reset #timeline_length editor
# 关闭 mod 可视化时间轴覆盖层（退出编辑器/切换谱面时）
scoreboard players set editor_timeline_gui options 0
