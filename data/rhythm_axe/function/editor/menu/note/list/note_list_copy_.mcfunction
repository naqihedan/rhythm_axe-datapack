#arg:cursor,index
# 复制该音符信息到剪贴板（行级：整音符副本）
# ★ 2026-09-30 用户要求：不再用裸 tellraw 弹提示，改走面板反馈（由调用方重开列表面板渲染，显示在十行换行下方）
#   复制不产生撤销快照 → 打 no_undo → show_feedback 走纯文本反馈（渲染后自行清 feedback/no_undo）
$data modify storage rhythm_axe:maps.editor note_clip set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(index)]
data modify storage rhythm_axe:maps.editor feedback set value "已复制音符信息"
data modify storage rhythm_axe:maps.editor no_undo set value 1b
