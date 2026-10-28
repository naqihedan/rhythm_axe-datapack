# ========== 示例装饰（decor/example）：启动 ==========
# 干什么：4 个彩色方块（白/橙/紫/青）绕场地中心 (6, 5, 19) 水平旋转，半径 2 格；
#   4 帧 × 10 刻 = 周期 40 刻（2 秒 @20tps）转一圈，无缝循环。
# 为什么这么做：
#   ① 4 个方块颜色不同 ⇒ 转了看得出来（全同色的话旋转 90° 后整个集合自映射 = 看着根本没动）；
#   ② 4 帧只用「±2 / 0」的整数偏移 ⇒ 不需要三角函数，纯字面量，
#      最能体现「关键帧 + 客户端插值」这条轻量路线（对比见《世界装饰.md》技术选型）；
#   ③ 4 个实体的 Pos 全在同一锚点、位移写在 transformation.translation ⇒
#      以后要换运动轨迹只改 frames 里的 translation，不用重新 summon。
#
# ★ 本装饰是【自包含】的：不占 load / tick 任何一行。时钟由自己的驱动器自链推进
#   （tick 每刻 schedule 自己）⇒ 跨 /reload、跨存档一直活着、相位连续（不会因 reload 重头演）。
# ★ 代价与要点（新增装饰务必照抄这套写法，详见《节奏地图开发文档/世界装饰.md》）：
#   ① /reload 不清 schedule（TimerQueue 是 SavedData）⇒ 启动前必须先停上一轮的链，
#      否则新旧两条链各推进一次 = 每刻 +2、整段加速（下面第 1 条就是干这个）；
#   ② 计分项必须自己 add（本装饰不依赖任何人来建 decor_t）；
#   ③ 要停演/重演只能靠这个 start 或 clear，没有任何全局钩子帮你。
#
# 【启动/重演】/function rhythm_axe:decor/example/start
# 【立刻收掉】/function rhythm_axe:decor/example/clear

# 建计分项（幂等：已存在只告警）
scoreboard objectives add decor_t dummy

# 清上一轮（全用本装饰自己的东西，不影响别人）：停旧链 → 清时钟 → 清实体
schedule clear rhythm_axe:decor/example/tick
scoreboard players reset #decor_example decor_t
kill @e[tag=decor_example]

# 出生：4 个 block_display 方块，全在锚点 (6, 5, 19)，scale 0.5（半格），
#       初始 translation 就是第 1 帧的位置（避免出生时都挤在锚点闪一下）。
# ★ block_state 是 block_display 的必需字段（item_display 才用 item 字段）。
# ★ view_range 调大（默认 1.0 太小），否则稍远就看不见。
summon minecraft:block_display 6.0 5.0 19.0 {block_state:{Name:"minecraft:white_concrete"}, view_range:10000.0f, Tags:["decor","decor_example","decor_example_0"], transformation:{left_rotation:[0f,0f,0f,1f], right_rotation:[0f,0f,0f,1f], scale:[0.5f,0.5f,0.5f], translation:[2.0f,0.0f,0.0f]}}
summon minecraft:block_display 6.0 5.0 19.0 {block_state:{Name:"minecraft:orange_concrete"}, view_range:10000.0f, Tags:["decor","decor_example","decor_example_1"], transformation:{left_rotation:[0f,0f,0f,1f], right_rotation:[0f,0f,0f,1f], scale:[0.5f,0.5f,0.5f], translation:[0.0f,0.0f,2.0f]}}
summon minecraft:block_display 6.0 5.0 19.0 {block_state:{Name:"minecraft:purple_concrete"}, view_range:10000.0f, Tags:["decor","decor_example","decor_example_2"], transformation:{left_rotation:[0f,0f,0f,1f], right_rotation:[0f,0f,0f,1f], scale:[0.5f,0.5f,0.5f], translation:[-2.0f,0.0f,0.0f]}}
summon minecraft:block_display 6.0 5.0 19.0 {block_state:{Name:"minecraft:cyan_concrete"}, view_range:10000.0f, Tags:["decor","decor_example","decor_example_3"], transformation:{left_rotation:[0f,0f,0f,1f], right_rotation:[0f,0f,0f,1f], scale:[0.5f,0.5f,0.5f], translation:[0.0f,0.0f,-2.0f]}}

# 时钟置 1（= 演出第 1 刻）→ 立刻出第 1 帧 → 启动自链（之后每刻由 tick 自己接着 schedule）
scoreboard players set #decor_example decor_t 1
function rhythm_axe:decor/example/frames
schedule function rhythm_axe:decor/example/tick 1t