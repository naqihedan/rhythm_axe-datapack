#arg: met,jm,end
# 主菜单节拍器行：节拍器开关 $(met) + 判定开关 $(jm) + 播放进度「当前刻/最终刻」$(end)（同一行）
# 刻数用计分板组件直接显示 #prog_head（当前刻）/ #prog_end（最终刻，由 progress/line 算好）
$tellraw @s [$(met),{"text":"  ","color":"white"},$(jm),{"text":"    ","color":"white"},{"score":{"name":"#prog_head","objective":"editor"},"color":"white"},$(end)]
