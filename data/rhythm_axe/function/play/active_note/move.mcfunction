# 交互实体跟随展示实体视觉位置（@s = 展示实体，at 其位置）
# 视觉位置 = 展示实体 Pos + transformation.translation
# 【解耦】展示实体 interpolation_duration:1 渲染插值使视觉比 NBT 晚约1刻，
#   故交互实体移到"上一刻"的视觉位置（存展示实体实体关联计分板 note_prev_*，
#   summon 时初始化为初始视觉位置），使判定箱与视觉对齐。
# 配对的交互实体用 note_id 计分板匹配（play_state 计分板）

# 混凝土：跳过（混凝土展示实体 translation 是局部坐标，不能当世界偏移累加到 Pos；
#   其交互实体由 concrete/tick 每 tick 直接跟随长条头端位置；2026-08-09 回退）
execute if entity @s[tag=note_concrete] run return fail

# 读取展示实体当前视觉位置（×100 存储）
# ★ 普通/玻璃 translation 是局部（沿路径，局部 +z 朝运动方向）→ 世界偏移 = 局部z × (-start/dist)
#   之前直接 Pos + translation（不旋转）会错（朝向 bug）；混凝土已跳过本函数
#   start=[0,0,0] 时 dist=0，除以 0 计分板结果为 0（不崩溃），偏移恒 0（音符不动）
# ★ 阶段A（性能轮）：改读计分板替代 data get entity（Pos 固定 = summon 快照的 note_base_*；
#   局部 z = display_animation/step（非线性音符）或 glass 的 note_cur_tz 每 tick 写）——省每音符每 tick 4 次 NBT 读
scoreboard players operation #vx play_state = @s note_base_x
scoreboard players operation #vy play_state = @s note_base_y
scoreboard players operation #vz play_state = @s note_base_z
# 局部 z：非线性 = note_cur_tz（display_animation/step 每 tick 写，混凝土除外）；线性 = 服务器按统一公式算
#   （阶段C 客户端插值不写 NBT，note_cur_tz 无值；统一模型见 play/note/motion/init）
#   统一公式 z(t) = -dist + (dist+end)×t/D，t=note_lin_t（0 起每 tick +1），D=note_lin_dur，end=note_lin_end
#   普通：end=0、D=lt-1 → t=lt-1 到位判定位置（补偿客户端首 tick 不渲染，视觉到位=time=节拍）
#   玻璃：end=dist×dur/lt、D=lt+dur-1 → t≈lt 恰过判定位置 0（与普通音符同步）
#   t≥D 时 clamp 到 +end（普通停判定位置；玻璃停出窗处）
# ★ 混凝土不走此统一公式（前面已 return fail，交互由 concrete/tick 跟随长条头端；2026-08-09 回退）
execute if entity @s[tag=note_linear] run scoreboard players operation #m_t display_calc = @s note_lin_t
execute if entity @s[tag=note_linear] if score #m_t display_calc > @s note_lin_dur run scoreboard players operation #m_t display_calc = @s note_lin_dur
# S = dist + end
execute if entity @s[tag=note_linear] run scoreboard players operation #m_s display_calc = @s note_c_dist
execute if entity @s[tag=note_linear] run scoreboard players operation #m_s display_calc += @s note_lin_end
# (dist+end)×t / D
execute if entity @s[tag=note_linear] run scoreboard players operation #m_s display_calc *= #m_t display_calc
execute if entity @s[tag=note_linear] run scoreboard players operation #m_s display_calc /= @s note_lin_dur
# z = -dist + (dist+end)×t/D
execute if entity @s[tag=note_linear] run scoreboard players operation #tz play_state = #m_s display_calc
execute if entity @s[tag=note_linear] run scoreboard players operation #tz play_state -= @s note_c_dist
execute unless entity @s[tag=note_linear] run scoreboard players operation #tz play_state = @s note_cur_tz
# wx = -tz × sx / dist（start = note_c_sx/sy/sz，dist = note_c_dist）
scoreboard players operation #wx display_calc = @s note_c_sx
scoreboard players operation #wx display_calc *= -1 const
scoreboard players operation #wx display_calc *= #tz play_state
scoreboard players operation #wx display_calc /= @s note_c_dist
scoreboard players operation #vx play_state += #wx display_calc
scoreboard players operation #wy display_calc = @s note_c_sy
scoreboard players operation #wy display_calc *= -1 const
scoreboard players operation #wy display_calc *= #tz play_state
scoreboard players operation #wy display_calc /= @s note_c_dist
scoreboard players operation #vy play_state += #wy display_calc
scoreboard players operation #wz display_calc = @s note_c_sz
scoreboard players operation #wz display_calc *= -1 const
scoreboard players operation #wz display_calc *= #tz play_state
scoreboard players operation #wz display_calc /= @s note_c_dist
scoreboard players operation #vz play_state += #wz display_calc

# 取上一刻视觉位置（实体关联计分板；summon 已初始化）
execute store result score #pvx play_state run scoreboard players get @s note_prev_x
execute store result score #pvy play_state run scoreboard players get @s note_prev_y
execute store result score #pvz play_state run scoreboard players get @s note_prev_z
# 线性音符（阶段C，方案3 2026-08-08）：插值参数在生成 tick 预置，客户端实际收到时（晚约 1 tick）才开始插值
#   → 视觉比 move 当前算的位置晚 1 tick（用户实测"展示实体比交互实体晚了一刻"）。
#   ★ 恢复 prev 解耦（交互 = 上一刻视觉位置）追平视觉：move 每 tick 交互写 note_prev_*（上一刻 #vx），
#     与视觉同步。（原"跳过 prev"只适用于视觉无延迟的旧方案；方案3 下会让交互比视觉早 1 tick）
# 注：note_prev_* 由 summon 初始化为出生位置，move 末尾存当前 #vx → 交互实体滞后 1 tick = 追平客户端插值延迟
# 交互实体 Pos 为脚底、展示实体 Pos 为方块中心 → y 减去 音符尺寸×0.5（×100 尺度：scale×100/2）
#   使交互实体碰撞箱（脚底起向上 height）完全包裹展示模型（设计：交互实体嵌套展示实体、中心同一）
scoreboard players operation #tmp_scale play_state = @s note_half_size
scoreboard players operation #pvy play_state -= #tmp_scale play_state

# 配对：找到与当前展示实体相同 note_id 的交互实体，写其 Pos（用上一刻位置）
# ★ 抽子函数优化（性能轮）：每展示实体只遍历 1 次交互实体（原 3 次），Pos×3 在函数内一次写完；
#   子函数执行后外层 @s 恢复为展示实体（run function 不改变外层执行者）
scoreboard players operation #nid play_state = @s note_id
execute as @e[type=interaction,tag=note_interaction] if score @s note_id = #nid play_state run function rhythm_axe:play/active_note/move_write_pair
# 玻璃判定中心 marker 跟随（位置 = 玻璃中心，y 不减 size/2）
# ★ 扫掠段整体退 1 刻（2026-08-08 用户实测"玻璃判定早1刻"）：
#   展示实体渲染晚 1 刻 → 视觉当前帧 F(T)=P(T-1)（NBT 提前值），玻璃这一刻走的路径=[P(T-2),P(T-1)]。
#   原 marker 扫掠段=[P(T-1),P(T)]（起点=上一刻/终点=当前刻）超前视觉路径 1 刻 → 判定早 1 刻。
#   修复：起点用 note_prev2_*（上上一刻 P(T-2)）、终点用 note_prev_*（上一刻 P(T-1)）。
scoreboard players operation #pvx2 play_state = @s note_prev2_x
scoreboard players operation #pvy2 play_state = @s note_prev2_y
scoreboard players operation #pvz2 play_state = @s note_prev2_z
# #pvy 上面已被减去 size/2（交互实体脚底），marker 需加回 → #pvy_c = #pvy + #tmp_scale = 中心
scoreboard players operation #pvy_c play_state = #pvy play_state
scoreboard players operation #pvy_c play_state += #tmp_scale play_state
execute if entity @s[tag=note_stained_glass] as @e[type=marker,tag=note_glass_center] if score @s note_id = #nid play_state run function rhythm_axe:play/active_note/move_write_marker

# 存当前视觉位置为上一刻（供下一刻使用）；旧上一刻滚为上上一刻（玻璃扫掠段起点）
scoreboard players operation @s note_prev2_x = @s note_prev_x
scoreboard players operation @s note_prev2_y = @s note_prev_y
scoreboard players operation @s note_prev2_z = @s note_prev_z
scoreboard players operation @s note_prev_x = #vx play_state
scoreboard players operation @s note_prev_y = #vy play_state
scoreboard players operation @s note_prev_z = #vz play_state
