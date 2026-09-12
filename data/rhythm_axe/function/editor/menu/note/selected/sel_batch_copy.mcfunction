# 批量复制选中音符到剪贴板（面板 18）：把 selection 的所有音符字段复制进 clipboard.notes
# 复用 editor/note/copy/copy（缺省 note_ids=selection）；复制后重开列表以刷新（剪贴板有内容 → 粘贴按钮可用）
# ★ copy 已改顺序游标（O(n)），不再逐个 find_by_id 全扫，无需 sel_clean_drive
function rhythm_axe:editor/note/copy/copy
function rhythm_axe:editor/menu/note/selected/sel_note_list_open
