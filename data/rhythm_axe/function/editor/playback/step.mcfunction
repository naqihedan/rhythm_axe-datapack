# 按拍/小节跳转：前置 prop.kind（beat/bar）与 prop.dir（fwd/back）
execute if data storage rhythm_axe:prop {kind:"beat"} run function rhythm_axe:editor/playback/step_beat
execute if data storage rhythm_axe:prop {kind:"bar"} run function rhythm_axe:editor/playback/step_bar
