# 初始化判定反馈组表（M2-H）
# 存储表结构（storage rhythm_axe:feedback）：
#   sounds[组][情况] = 音效 id 字符串（组 = hitsound 组编号，情况 = spawn/bad/good_early/...）
#   particles[组][情况] = 完整指令字符串（组 = hit_particles 组编号）——粒子指令比 playsound 需要更多自定义参数，
#     所以存一整条可执行指令（如 "particle minecraft:wax_on ~ ~ ~ 1 1 1 1 100 force @a"），播放时直接宏执行；
#     有意允许存非 particle 的其他指令（宏执行不校验）。执行者 = 音符交互实体，位置 = 交互实体位置。
# 情况键共 10 个：spawn / tick / bad / good_early / perfect_early / perfect / perfect_late / good_late / miss / damage
#   （tick = 音符开始运动后每一刻触发；damage = 玻璃撞墙扣血时触发）
# 组 0-4 为各音符类型的默认组（未指定组号时按音符 type 使用；type：0=音符盒 1=木板 2=唱片机 3=混凝土 4=染色玻璃）。
#   每个默认组只在 good_early/perfect_early/perfect/perfect_late/good_late（合格判定）下播放"该方块被挖掘的破坏音效"+对应破坏粒子，其余情况为空。
#   混凝土（3）的破坏粒子颜色随音符 color，由 play/feedback/particle_concrete 动态生成（粒子字段存 function 调用）；染色玻璃（4）仅 damage（撞墙扣血）
#   用玻璃破碎音效 + 按 color 的玻璃破碎粒子（play/feedback/particle_glass），其余情况全空。
# 组 5 预建为空（编辑器全局音效/视效面板可填）。组 6（最后）= 旧默认组（原组 0 全部情况反馈，保留未删）。
data merge storage rhythm_axe:feedback { \
    sounds: [ \
        { \
            spawn: "", \
            tick: "", \
            bad: "", \
            good_early: "minecraft:block.wood.break", \
            perfect_early: "minecraft:block.wood.break", \
            perfect: "minecraft:block.wood.break", \
            perfect_late: "minecraft:block.wood.break", \
            good_late: "minecraft:block.wood.break", \
            miss: "", \
            damage: "" \
        }, \
        { \
            spawn: "", \
            tick: "", \
            bad: "", \
            good_early: "minecraft:block.wood.break", \
            perfect_early: "minecraft:block.wood.break", \
            perfect: "minecraft:block.wood.break", \
            perfect_late: "minecraft:block.wood.break", \
            good_late: "minecraft:block.wood.break", \
            miss: "", \
            damage: "" \
        }, \
        { \
            spawn: "", \
            tick: "", \
            bad: "", \
            good_early: "minecraft:block.wood.break", \
            perfect_early: "minecraft:block.wood.break", \
            perfect: "minecraft:block.wood.break", \
            perfect_late: "minecraft:block.wood.break", \
            good_late: "minecraft:block.wood.break", \
            miss: "", \
            damage: "" \
        }, \
        { \
            spawn: "", \
            tick: "", \
            bad: "", \
            good_early: "minecraft:block.stone.break", \
            perfect_early: "minecraft:block.stone.break", \
            perfect: "minecraft:block.stone.break", \
            perfect_late: "minecraft:block.stone.break", \
            good_late: "minecraft:block.stone.break", \
            miss: "", \
            damage: "" \
        }, \
        { \
            spawn: "", \
            tick: "", \
            bad: "", \
            good_early: "", \
            perfect_early: "", \
            perfect: "", \
            perfect_late: "", \
            good_late: "", \
            miss: "", \
            damage: "minecraft:block.glass.break" \
        }, \
        { \
            spawn: "", \
            tick: "", \
            bad: "", \
            good_early: "", \
            perfect_early: "", \
            perfect: "", \
            perfect_late: "", \
            good_late: "", \
            miss: "", \
            damage: "" \
        }, \
        { \
            spawn: "", \
            tick: "", \
            bad: "minecraft:block.note_block.bass", \
            good_early: "minecraft:block.note_block.hat", \
            perfect_early: "minecraft:block.note_block.pling", \
            perfect: "minecraft:block.note_block.pling", \
            perfect_late: "minecraft:block.note_block.pling", \
            good_late: "minecraft:block.note_block.hat", \
            miss: "minecraft:block.note_block.bass", \
            damage: "minecraft:block.note_block.bass" \
        } \
    ] \
}
data merge storage rhythm_axe:feedback { \
    particles: [ \
        { \
            spawn: "", \
            tick: "", \
            bad: "", \
            good_early: "particle minecraft:block{block_state:\"minecraft:note_block\"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a", \
            perfect_early: "particle minecraft:block{block_state:\"minecraft:note_block\"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a", \
            perfect: "particle minecraft:block{block_state:\"minecraft:note_block\"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a", \
            perfect_late: "particle minecraft:block{block_state:\"minecraft:note_block\"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a", \
            good_late: "particle minecraft:block{block_state:\"minecraft:note_block\"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a", \
            miss: "", \
            damage: "" \
        }, \
        { \
            spawn: "", \
            tick: "", \
            bad: "", \
            good_early: "particle minecraft:block{block_state:\"minecraft:birch_planks\"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a", \
            perfect_early: "particle minecraft:block{block_state:\"minecraft:birch_planks\"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a", \
            perfect: "particle minecraft:block{block_state:\"minecraft:birch_planks\"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a", \
            perfect_late: "particle minecraft:block{block_state:\"minecraft:birch_planks\"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a", \
            good_late: "particle minecraft:block{block_state:\"minecraft:birch_planks\"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a", \
            miss: "", \
            damage: "" \
        }, \
        { \
            spawn: "", \
            tick: "", \
            bad: "", \
            good_early: "particle minecraft:block{block_state:\"minecraft:jukebox\"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a", \
            perfect_early: "particle minecraft:block{block_state:\"minecraft:jukebox\"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a", \
            perfect: "particle minecraft:block{block_state:\"minecraft:jukebox\"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a", \
            perfect_late: "particle minecraft:block{block_state:\"minecraft:jukebox\"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a", \
            good_late: "particle minecraft:block{block_state:\"minecraft:jukebox\"} ~ ~ ~ 0.3 0.3 0.3 0 100 force @a", \
            miss: "", \
            damage: "" \
        }, \
        { \
            spawn: "", \
            tick: "", \
            bad: "", \
            good_early: "function rhythm_axe:play/feedback/particle_concrete", \
            perfect_early: "function rhythm_axe:play/feedback/particle_concrete", \
            perfect: "function rhythm_axe:play/feedback/particle_concrete", \
            perfect_late: "function rhythm_axe:play/feedback/particle_concrete", \
            good_late: "function rhythm_axe:play/feedback/particle_concrete", \
            miss: "", \
            damage: "" \
        }, \
        { \
            spawn: "", \
            tick: "", \
            bad: "", \
            good_early: "", \
            perfect_early: "", \
            perfect: "", \
            perfect_late: "", \
            good_late: "", \
            miss: "", \
            damage: "function rhythm_axe:play/feedback/particle_glass" \
        }, \
        { \
            spawn: "", \
            tick: "", \
            bad: "", \
            good_early: "", \
            perfect_early: "", \
            perfect: "", \
            perfect_late: "", \
            good_late: "", \
            miss: "", \
            damage: "" \
        }, \
        { \
            spawn: "particle minecraft:note ~ ~0.5 ~ 0 0 0 1 0 force @a", \
            tick: "", \
            bad: "particle minecraft:note ~ ~0.5 ~ 0.75 0 0 1 0 force @a", \
            good_early: "particle minecraft:note ~ ~0.5 ~ 0.0 0 0 1 0 force @a", \
            perfect_early: "particle minecraft:note ~ ~0.5 ~ 0.16 0 0 1 0 force @a", \
            perfect: "particle minecraft:note ~ ~0.5 ~ 0.25 0 0 1 0 force @a", \
            perfect_late: "particle minecraft:note ~ ~0.5 ~ 0.16 0 0 1 0 force @a", \
            good_late: "particle minecraft:note ~ ~0.5 ~ 0.0 0 0 1 0 force @a", \
            miss: "particle minecraft:smoke ~ ~0.5 ~ 0.1 0.1 0.1 0.1 10 force @a", \
            damage: "particle minecraft:dust{color: [1.0, 0.0, 0.0], scale: 1.0} ~ ~ ~ 0.2 0.2 0.2 1 20 force @a" \
        } \
    ] \
}
