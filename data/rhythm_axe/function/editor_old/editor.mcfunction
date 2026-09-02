# ========== 时间轴创建准备 — 入口 ==========
# 由命令方块执行（按钮在唱片机上），@s 为命令方块
# 轨道起始点位于执行位置的 ~-3 ~-1 ~1

# 创建计分板（幂等，已有则跳过）
    scoreboard objectives add editor dummy
    scoreboard objectives add teleport dummy

# 编辑状态检测
    execute if score is_editing editor matches 1 run tellraw @p [{"text":"已有编辑程序正在运行！","color":"red","bold":true}]
    execute if score is_editing editor matches 1 run return 0
    # 标记编辑状态（防止重复进入，超时自动取消）
    scoreboard players set is_editing editor 1

# 初始化时间轴参数
        # bar 小节数
        # beat_per_bar 每小节拍数
        # tick_per_beat 每拍刻数
        # offset 偏移量
        # length 时间轴长度
        # timeline_end 时间轴终点坐标
        # index_line 时间轴行数
        # index_map 谱面索引（未实现）
    scoreboard players set bar editor 8
    scoreboard players set beat_per_bar editor 4
    scoreboard players set tick_per_beat editor 8
    scoreboard players set offset editor 0

    scoreboard players set length editor -1
    scoreboard players set timeline_end teleport -1

    scoreboard players set index_line editor 0
    scoreboard players set index_map editor 0

# 获取index_line
    function rhythm_axe:editor/util/get_index_line
# 生成预览

    # 在轨道起始点生成绿色发光方块展示实体标记（标定起始点+显示时间轴大小）
    # 发光颜色用 glow_color_override（绿色 0x00FF00=65280；超过长度阈值由 scale_prep 改红色）


    # 时间轴预览展示实体 与 时间轴原点
    # 在对位置进行缓动计算过程中会因为计分板而损失精度，所以放弃用tp指令对齐中心消除误差，直接用方块的角落作为最终位置
    # 展示实体的坐标与时间轴起点坐标相同
    # 展示实体的translation要做到一改全改，main reset animate_index_finish 都要改
    summon block_display ~ 0.0 10000.0 {Tags:["timeline_preview"],block_state:{Name:"minecraft:pale_oak_trapdoor"},Glowing:1b,glow_color_override:65280,\
        transformation:{translation:[-3.0d,-0.3d,0.0d],left_rotation:[0.0,0.0,0.0,1.0],right_rotation:[0.0,0.0,0.0,1.0],scale:[7.0,1.0,1.0]}}
    summon marker ~ 0.0 10000 {Tags:["timeline_start"]}
        # 展示实体与时间轴原点的x轴位置 = 9999.5 - ( index_map * 512 + index_line * 8 + 4 )
        scoreboard players operation preview_x editor = index_map editor
        scoreboard players operation preview_x editor *= 512 const
        scoreboard players operation calc editor = index_line editor
        scoreboard players operation calc editor *= 8 const
        scoreboard players operation preview_x editor += calc editor
        scoreboard players operation preview_x editor += 4 const
        scoreboard players operation preview_x editor *= -1 const
        scoreboard players add preview_x editor 9999
        # 写入实体 Pos[0] 
        execute as @e[type=block_display,tag=timeline_preview,limit=1] store result entity @s Pos[0] double 1 \
            run scoreboard players get preview_x editor
        execute as @e[type=marker,tag=timeline_start,limit=1] store result entity @s Pos[0] double 1 \
            run scoreboard players get preview_x editor


    # 存储预览实体初始位置，用于重置
    execute as @e[type=marker,tag=timeline_start,limit=1] store result score preview_origin_x editor run data get entity @s Pos[0]
    execute as @e[type=marker,tag=timeline_start,limit=1] store result score preview_origin_z editor run data get entity @s Pos[2]

    # 展示实体发绿色光（glow_color_override 已在 summon 中设置）

    # 设置玩家偏航俯仰
    execute as @p at @s run tp @s ~ ~ ~ -90 90

    # 存储玩家位置与旋转角度
    execute as @p at @s run summon marker ~ ~ ~ {Tags:["player_origin"]}
    execute as @e[tag=player_origin] at @s run tp @p

    # 清理旧坐骑，召唤新坐骑并骑乘
    kill @e[type=armor_stand,tag=timeline_mount]
    execute at @p run summon armor_stand ~ ~ ~ \
        {Tags:["timeline_mount"],NoGravity:1b,Invisible:1b,Marker:1b}
    execute as @p run ride @s mount @e[type=armor_stand,tag=timeline_mount,limit=1]

    # 计算目标位置,传送玩家（含坐骑）到高空俯视
    # 如果你读到这段话，这里有个TODO：用rotate命令让玩家在传送时朝向也进行缓动。
    function rhythm_axe:editor/util/recalculate
    function rhythm_axe:editor/preview/entity/scale
    function rhythm_axe:editor/preview/mount/preview

# 聊天栏的操控表单
    execute as @p run function rhythm_axe:editor/show_form

# 超时取消
    schedule function rhythm_axe:editor/cancel 1200t


