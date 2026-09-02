# 播放头跳转：前置 prop.direction（fwd/back）与 prop.ticks（>=0）
execute if data storage rhythm_axe:prop {direction:"fwd"} run function rhythm_axe:editor/playback/seek_fwd
execute if data storage rhythm_axe:prop {direction:"back"} run function rhythm_axe:editor/playback/seek_back
data remove storage rhythm_axe:prop direction
data remove storage rhythm_axe:prop ticks
