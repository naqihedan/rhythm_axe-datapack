
# ── 激光延时发射队列 ──
# schedule 不支持 with，宏参数只能先快照进 storage，由中转函数到点用 with storage 取用。
# 压入任务：delay = 距「上一条」发射的间隔刻数（第一条 = 距现在）；delay 0 = 与上一条【同刻】齐发。

data modify storage rhythm_axe:laser queue append value {delay:0, x:-1.5f, angle:90.0f}
# 2 tick delay
# 2 tick delay
# 2 tick delay

data modify storage rhythm_axe:laser queue append value {delay:8, x:-0.5f, angle:-45.0f}
data modify storage rhythm_axe:laser queue append value {delay:2, x:-1.5f, angle:-45.0f}
data modify storage rhythm_axe:laser queue append value {delay:2, x:-2.5f, angle:-45.0f}
# 2 tick delay

data modify storage rhythm_axe:laser queue append value {delay:4, x:-2.5f, angle:45.0f}
data modify storage rhythm_axe:laser queue append value {delay:2, x:-1.5f, angle:45.0f}
data modify storage rhythm_axe:laser queue append value {delay:2, x:-0.5f, angle:45.0f}
# 2 tick delay

data modify storage rhythm_axe:laser queue append value {delay:4, x:-0.5f, angle:90.0f}
data modify storage rhythm_axe:laser queue append value {delay:2, x:-1.5f, angle:90.0f}
data modify storage rhythm_axe:laser queue append value {delay:2, x:-2.5f, angle:90.0f}
# 2 tick delay

data modify storage rhythm_axe:laser queue append value {delay:4, x:-0.5f, angle:-45.0f}
data modify storage rhythm_axe:laser queue append value {delay:2, x:-1.5f, angle:-45.0f}
data modify storage rhythm_axe:laser queue append value {delay:2, x:-2.5f, angle:-45.0f}
# 2 tick delay

data modify storage rhythm_axe:laser queue append value {delay:4, x:-2.5f, angle:45.0f}
data modify storage rhythm_axe:laser queue append value {delay:2, x:-1.5f, angle:45.0f}
data modify storage rhythm_axe:laser queue append value {delay:2, x:-0.5f, angle:45.0f}
# 2 tick delay

data modify storage rhythm_axe:laser queue append value {delay:4, x:-0.5f, angle:45.0f}
data modify storage rhythm_axe:laser queue append value {delay:0, x:-1.5f, angle:90.0f}
data modify storage rhythm_axe:laser queue append value {delay:0, x:-2.5f, angle:-45.0f}
# 2 tick delay
# 2 tick delay

data modify storage rhythm_axe:laser queue append value {delay:4, x:-2.5f, angle:45.0f}
data modify storage rhythm_axe:laser queue append value {delay:2, x:-1.5f, angle:45.0f}
data modify storage rhythm_axe:laser queue append value {delay:2, x:-0.5f, angle:45.0f}




