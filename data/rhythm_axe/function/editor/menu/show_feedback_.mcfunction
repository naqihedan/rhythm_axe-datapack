#arg:fb,btn_undo,btn_redo,fb_count
# 显示反馈（宏插入纯文本；fb 必须是固定文案，不含引号）
# btn_undo / btn_redo：整段按钮组件 JSON 串 —— 可用 = aqua 带点击事件（8 撤销 / 9 重做）；不可用 = 灰色且无 click_event
# fb_count 可选：提供时在文案后显示 " N 个音符"（用于批量编辑数量反馈）
$execute if data storage rhythm_axe:prop fb_count run tellraw @s [{"text":"[编辑器] ","color":"yellow"},{"text":"$(fb) ","color":"yellow"},{"score":{"name":"#fb_count","objective":"editor"},"color":"white"},{"text":" 个音符","color":"yellow"},{"text":" ","color":"white"},$(btn_undo),{"text":" ","color":"white"},$(btn_redo)]
$execute unless data storage rhythm_axe:prop fb_count run tellraw @s [{"text":"[编辑器] ","color":"yellow"},{"text":"$(fb) ","color":"yellow"},$(btn_undo),{"text":" ","color":"white"},$(btn_redo)]
