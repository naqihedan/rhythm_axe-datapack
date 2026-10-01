#arg:title_comp
# 谱面设置面板标题行（title_comp 已由 utilization/title_comp 归一化为可安全注入的文本组件）
# 按钮：10001【对话框编辑文本】/ 10002【生成文本展示实体】/ 10003【复制展示实体文字信息】
# ★ 2026-10-01：删除原【复制 data 指令到聊天栏】—— 标题含引号，嵌进 suggest_command 会破坏整条
#   tellraw JSON，只能给只读的 data get，没有用处。改用「文本展示实体 + Axiom 改字 → 复制成标题」通道：
#   对话框输入框 max_length=128，装不下长/复杂组件，见 editor/menu/map/ops/map_title_display_*
$tellraw @s [{"text":"标题：","color":"gray"},$(title_comp),{"text":"  [对话框编辑文本]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 10001"},"hover_event":{"action":"show_text","value":"打开对话框编辑标题（限 128 字符；长/复杂组件请用下一行的展示实体通道）"}},{"text":"\n  【生成文本展示实体】","color":"green","click_event":{"action":"run_command","command":"/trigger editor_click set 10002"},"hover_event":{"action":"show_text","value":"在面前生成一个文本展示实体（可用 Axiom 等工具改文字）"}},{"text":"  【复制展示实体文字信息】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 10003"},"hover_event":{"action":"show_text","value":"把展示实体的文字设为谱面标题（需点【保存设置】才生效）"}}]
