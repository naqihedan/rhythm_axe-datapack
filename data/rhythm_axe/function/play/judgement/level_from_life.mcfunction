# 寿命→判定等级 核心函数（M2-B）
# 输入：#life（音符当前寿命）+ #judgement_scale（当前判定缩放 x）
# 输出：#level（0=bad 1=goodE 2=perfectE 3=perfect 4=perfectL 5=goodL 6=miss）
# 窗口（以寿命为坐标，x=判定缩放倍数）：
#   bad      [2x+1, 3x]
#   goodE    [x+1, 2x]
#   perfectE [1, x]
#   PERFECT  0
#   perfectL [-x, -1]
#   goodL    [-2x, -x-1]
#   miss     < -2x
# 实现：先算各边界分数，再链式 matches 判断

# 初始化等级为 miss（6）
scoreboard players set #level play_state 6

# 计算上界 3x（存 #t3）
scoreboard players operation #t3 play_state = #judgement_scale play_state
scoreboard players operation #t3 play_state *= 3 const
# 计算 2x（存 #t2）
scoreboard players operation #t2 play_state = #judgement_scale play_state
scoreboard players operation #t2 play_state *= 2 const
# 计算 x（存 #t1）
scoreboard players operation #t1 play_state = #judgement_scale play_state
# -x（存 #tn1）
scoreboard players operation #tn1 play_state = #t1 play_state
scoreboard players operation #tn1 play_state *= -1 const
# -2x（存 #tn2）
scoreboard players operation #tn2 play_state = #t2 play_state
scoreboard players operation #tn2 play_state *= -1 const

# 边界值：bad 下界 2x+1、goodE 下界 x+1、perfectE 下界 1、perfectL 上界 -1、goodL 上界 -x-1
scoreboard players operation #b_bad_low play_state = #t2 play_state
scoreboard players add #b_bad_low play_state 1
scoreboard players operation #b_goodE_low play_state = #t1 play_state
scoreboard players add #b_goodE_low play_state 1
scoreboard players operation #b_goodL_high play_state = #tn1 play_state
scoreboard players remove #b_goodL_high play_state 1

# 从高到低判断（life 越大越早；bad 最高）
# bad: life 在 [2x+1, 3x]
execute if score #life play_state >= #b_bad_low play_state if score #life play_state <= #t3 play_state run scoreboard players set #level play_state 0
# goodE: life 在 [x+1, 2x]
execute if score #life play_state >= #b_goodE_low play_state if score #life play_state <= #t2 play_state run scoreboard players set #level play_state 1
# perfectE: life 在 [1, x]
execute if score #life play_state >= 1 const if score #life play_state <= #t1 play_state run scoreboard players set #level play_state 2
# PERFECT: life == 0
execute if score #life play_state matches 0 run scoreboard players set #level play_state 3
# perfectL: life 在 [-x, -1]
execute if score #life play_state >= #tn1 play_state if score #life play_state <= -1 const run scoreboard players set #level play_state 4
# goodL: life 在 [-2x, -x-1]
execute if score #life play_state >= #tn2 play_state if score #life play_state <= #b_goodL_high play_state run scoreboard players set #level play_state 5
# 其余（< -2x）保持 miss（6）
