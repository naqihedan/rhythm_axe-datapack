# 批量复制选中音符到剪贴板（面板 10）：把 selection 的所有音符字段复制进 clipboard.notes
# 复用 editor/note/copy/copy（缺省 note_ids=selection）；复制后重开列表以刷新（剪贴板有内容 → 粘贴按钮可用）
function rhythm_axe:editor/note/copy/copy
function rhythm_axe:editor/menu/note/list/note_list_open
