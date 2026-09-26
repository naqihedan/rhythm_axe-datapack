# 名单行 · 未加入（@s = 在线但不在队伍里的玩家；灰色，点【加入游玩】可加入）
tellraw @a[tag=room_viewer] [{"text":"  ✘ ","color":"dark_gray"},{"selector":"@s","color":"dark_gray"},{"text":"（未加入）","color":"dark_gray"}]
