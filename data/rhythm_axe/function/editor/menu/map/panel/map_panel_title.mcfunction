#arg:title
# 谱面设置面板标题行（title 宏传=JSON 组件，解析显示）
# ★ 复制按钮不能把 $(title) 嵌进 suggest_command 的命令字符串：标题是 JSON 组件含双引号，
#   宏纯文本注入会破坏整条 tellraw 的 JSON（导致标题行整体不显示），故用不嵌入标题的 data get。
$tellraw @s [{"text":"标题：","color":"gray"},$(title),{"text":" [编辑文本]","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set 101"},"hover_event":{"action":"show_text","value":"编辑标题"}},{"text":"  【复制data指令到聊天栏】","color":"aqua","click_event":{"action":"suggest_command","command":"/data get storage rhythm_axe:maps.editor panel_temp.title"},"hover_event":{"action":"show_text","value":"复制当前标题的 data 指令（标题含引号，无法安全嵌入 set 命令）"}}]
