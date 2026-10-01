# 停止预览（全局状态 + 停音源）。调用点：再次点 ⏸️ / 时长到（preview/arm 的延时回调）/ 收起总表 / 去游玩 / 去编辑 / 开始游戏
# ⚠️ 只对「正在看总表」的人停：
#   ① 别把别人正在游玩的那一局的音乐一起停掉；② 没看总表的人本来就没收到过预览音
#   （一局在跑时根本不会开始预览 —— sel/select 有守卫）
# 清掉待执行的延时回调：手动停时它已无意义（被它自己到点触发时也无害）；schedule clear 按函数名清，安全
schedule clear rhythm_axe:map_list/preview/stop
execute if data storage rhythm_axe:map_list {prev:1b} run stopmusic @a[tag=maplist_view]
data remove storage rhythm_axe:map_list prev
