#arg: met,jm,mus,end
# 主菜单节拍器行：节拍器开关 $(met) + 判定开关 $(jm) + 音乐进度 $(mus) + 播放进度「当前刻/最终刻」$(end)（同一行）
#   · $(mus) = 「分:秒.百分秒 / 分:秒.百分秒」（当前刻 / 最终刻）—— 放在「当前刻/最终刻」左边
#   · 换算：1 刻 = 50ms，分量由 editor/util/tick_to_time 算好（分数前缀 #mu / #me）
#   · 刻数用计分板组件直接显示 #prog_head（当前刻）/ #prog_end（最终刻，由 progress/line 算好）
$tellraw @s [{"text":""},$(met),{"text":"  ","color":"white"},$(jm),{"text":"    ","color":"white"},$(mus),{"text":"    ","color":"white"},{"score":{"name":"#prog_head","objective":"editor"},"color":"white"},$(end)]
