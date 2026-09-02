# 手动停止谱面（无需宏参数；从 storage runtime 读取当前 mapid）
# 用法：function rhythm_axe:play/end_of_game/stop
# 背景：end_of_game 是宏函数（#arg: mapid），直接无参调用时 $(mapid) 无法解析
#   → $kill @e[tag=map_$(mapid)] 静默失败，音符残留但主循环已停（音符停在原地）。
#   本函数封装：从 runtime.mapid（start 时已写入）读取，再以 with storage 调用 end_of_game。
# 若未在游玩中（无 runtime.mapid），不执行任何操作。
execute if data storage rhythm_axe:runtime mapid run function rhythm_axe:play/end_of_game/end_of_game with storage rhythm_axe:runtime
