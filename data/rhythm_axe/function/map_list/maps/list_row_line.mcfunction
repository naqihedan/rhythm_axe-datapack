#arg: row, title_comp, artist, play_val, edit_val, mapid
# 总表单行输出（宏叶子）：{标题} - {作者}【游玩】【编辑】{mapid}
# 说明：artist 用宏注入（裸文本/JSON 组件都能显示）；⚠️ 作者名里若含双引号会破坏本行 JSON，
#       必要时请把作者写成 JSON 组件字符串（如 {"text":"A\"B"}）。
$tellraw @s [$(title_comp),{"text":" - ","color":"dark_gray"},{"text":"$(artist)","color":"gray"},{"text":"  "},{"text":"【游玩】","color":"green","click_event":{"action":"run_command","command":"/trigger menu_click set $(play_val)"},"hover_event":{"action":"show_text","value":"开始游玩这张谱面"}},{"text":"  "},{"text":"【编辑】","color":"aqua","click_event":{"action":"run_command","command":"/trigger menu_click set $(edit_val)"},"hover_event":{"action":"show_text","value":"进入编辑器编辑这张谱面"}},{"text":"  "},{"text":"$(mapid)","color":"dark_gray"}]
