# 获取index_line
# index_line = abs((玩家当前x轴位置 - 9999 ) % (512 * index_map) // 8 )
    # 获取玩家X坐标
    execute as @p store result score calc editor run data get entity @s Pos[0] 1
    # 减去9999
    scoreboard players operation calc editor -= 10000 const
    scoreboard players add calc editor 1
    # 取绝对值
    execute if score calc editor matches ..-1 run scoreboard players operation calc editor *= -1 const
    # 计算 segment = 512 * index_map
    scoreboard players operation index_map editor *= 512 const
    # 计算 (calc % segment) / 8
    execute if score index_map editor matches 1.. run scoreboard players operation calc editor %= index_map editor
    scoreboard players operation index_line editor = calc editor
    scoreboard players operation index_line editor /= 8 const
    # 恢复index_map原值
    scoreboard players operation index_map editor /= 512 const

title @a actionbar [{"text":"所在行：",color:green},{"score":{name:"index_line",objective:editor}}]