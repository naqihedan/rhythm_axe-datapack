# 时间轴翻转收尾（下一刻执行，独立命令链）：重建世界视觉（refresh 内含 sel_rebuild + 补光）→ 反馈 → 下一小刻再回面板
# 前置：#from editor 已由 note_panel_flip_time 设置（计分板跨刻保留）
# ★ 为什么推迟：refresh 要在整表上重建全部音符实体、面板列表渲染要遍历整表 + 输出 40 行，单条命令链各自都接近
#   maxCommandChainLength=200000。实测：refresh 单独跑 0 超限、列表渲染单独跑 0 超限，但两者同刻 = 超限被截断
#   （截断尾部正好是 sel_rebuild → selection 不重建 → 下一次点击翻转时顺序游标找不到音符 → 对称轴跑到 max）。
#   所以 refresh 与列表渲染各占一刻：本函数 refresh，面板渲染 schedule 到再下一刻。
function rhythm_axe:editor/refresh
scoreboard players add #content_ver editor 1
execute store result storage rhythm_axe:maps.editor content_ver int 1 run scoreboard players get #content_ver editor
data modify storage rhythm_axe:maps.editor feedback set value "已翻转时间轴"
schedule function rhythm_axe:editor/menu/note/panel/note_panel_return_next 1t
