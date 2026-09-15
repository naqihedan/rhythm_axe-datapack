#arg:cursor
# 清掉本过场「自己」已占用的刻位，让 apply_editor 可以**重复执行**（幂等）。
# 下面这些刻位 = 本过场历来几版用过的刻位并集：
#   · 步长 48（3480, 3528…4536）= 曾用过的「每 48 刻一句」版（23 句）
#   · 步长 96（3480, 3576…4536）= 现行「每 96 刻一句」版（12 句）——它是步长 48 集合的子集，
#     所以无需单独补行；改间距时只要新步长仍是原步长的整数倍，这份表就不用动。
#   · 步长 100（3580, 3680…4580）= 最早的「直接装进 maps.lament_rain」版（12 句）的旧刻位
# ⚠️ 按 time 删除（一刻只能有一个事件点，所以按刻位删是明确的）；本谱面这些刻位目前
#    只放过本过场的自动事件，不会误伤手放的普通事件。删完后 apply_one 会用编辑器自己的
#    「一刻一个 + 升序插入」重新铺 12 条，整段仍只占一份快照（可一次撤销）。
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:3480}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:3528}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:3576}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:3580}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:3624}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:3672}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:3680}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:3720}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:3768}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:3780}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:3816}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:3864}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:3880}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:3912}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:3960}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:3980}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4008}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4056}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4080}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4104}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4152}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4180}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4200}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4248}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4280}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4296}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4344}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4380}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4392}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4440}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4480}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4488}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4536}]
$data remove storage rhythm_axe:maps.editor history[$(cursor)].events[{time:4580}]
