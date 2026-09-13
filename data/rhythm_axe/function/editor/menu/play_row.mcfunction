#arg: pb,speed_btn
# 主菜单播放控件行：【返回开头】 + 时间控件 + 播放暂停 $(pb) + 速度按钮 $(speed_btn) + 【跳到结尾】同一行
# 播放控件与速度按钮被两侧按钮夹在中间；两侧各留空格使中段视觉居中（调节空格个数即可）
$tellraw @s [\
    {"text":"【返回开头】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 28"},"hover_event":{"action":"show_text","value":"播放头回到 0 刻"}},\
    {"text":"    ","color":"white"},\
    {"text":"<<<","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 20"},"hover_event":{"action":"show_text","value":"后退一小节"}},\
    {"text":" << ","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 21"},"hover_event":{"action":"show_text","value":"后退一拍"}},\
    {"text":"<","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 22"},"hover_event":{"action":"show_text","value":"后退一刻"}},\
    $(pb),\
    {"text":">","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 24"},"hover_event":{"action":"show_text","value":"前进一刻"}},\
    {"text":" >> ","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 25"},"hover_event":{"action":"show_text","value":"前进一拍"}},\
    {"text":">>>","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 26"},"hover_event":{"action":"show_text","value":"前进一小节"}},\
    {"text":"   ","color":"white"},\
    $(speed_btn),\
    {"text":"    ","color":"white"},\
    {"text":"【跳到结尾】","color":"yellow","click_event":{"action":"run_command","command":"/trigger editor_click set 29"},"hover_event":{"action":"show_text","value":"播放头跳到谱面结束时间"}}\
]
