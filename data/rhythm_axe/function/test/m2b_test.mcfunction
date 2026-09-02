# M2-B 测试：验证寿命递减与寿命→等级换算
# 用法：/function rhythm_axe:test/m2b_test
# 说明：构建测试谱面并开始游戏；游戏期间每个音符的交互实体 note_life 每刻递减
#       可在游戏结束后用 /scoreboard players get @e[tag=note_interaction,limit=1] note_life 查看

# 构建测试谱面（若尚未构建）
function rhythm_axe:test/build_test_map
# 开始游戏
function rhythm_axe:play/start_of_game/start_of_game {mapid:"test"}

# 提示
tellraw @a [{"text":"[M2-B] ","color":"gold","bold":true},{"text":"寿命系统已启动：交互实体 note_life 从 32 每刻递减","color":"white"}]
tellraw @a [{"text":"[M2-B] ","color":"gold","bold":true},{"text":"测试命令：/scoreboard players get @e[tag=note_interaction,limit=1] note_life","color":"gray"}]
