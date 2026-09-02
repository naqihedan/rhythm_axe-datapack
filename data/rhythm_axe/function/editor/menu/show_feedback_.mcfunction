#arg:fb,btn_label,btn_val
# 显示反馈（宏插入纯文本；fb 必须是固定文案，不含引号）
# btn_label=【撤销】/【重做】按钮文本；btn_val=对应 trigger 值（8 撤销 / 9 重做）；按钮行为一致：撤销/重做最新操作
$tellraw @s [{"text":"[编辑器] ","color":"yellow"},{"text":"$(fb)","color":"yellow"},{"text":"$(btn_label)","color":"aqua","click_event":{"action":"run_command","command":"/trigger editor_click set $(btn_val)"},"hover_event":{"action":"show_text","value":"撤销/重做上一步操作"}}]
