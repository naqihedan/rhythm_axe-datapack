# 面板 18【粘贴并选中】：粘贴到播放头 + 清空原选中 + 选中粘贴出来的音符，然后重开已选定列表
function rhythm_axe:editor/note/paste/paste_select
# ★ 列表推迟到下一刻渲染：粘贴（含 refresh）与列表渲染同 tick 会撞 200000
schedule function rhythm_axe:editor/menu/note/selected/sel_note_list_open_next 1t
