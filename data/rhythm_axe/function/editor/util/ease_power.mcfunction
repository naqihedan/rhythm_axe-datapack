# ========== 缓动幂运算（编辑器版副本） ==========
# 移植自 utilization/display_animation/easing/power.mcfunction（原版用 display_calc 计分板），
# 这里改用 editor 计分板 + 独立临时名 #ez_*，避免与编辑器视觉的 #c_yaw / #nsz / #note_dist 抢板。
#
# 输入（editor 计分板）：
#   #ez_n     = 当前序号（0 起）
#   #ez_total = 总间隔数（= 音符数 - 1；为 0 时直接输出 0）
#   #ez_power = 幂次 1~5
#   #ez_type  = 缓动类型 1 缓入 / 2 缓出 / 3 缓入缓出
# 输出：
#   #ez_ratio = 缓动进度 0~10000（万分比）
#
# 类型 1（缓入）：ratio = (n/total)^power
# 类型 2（缓出）：ratio = 1 - (1 - n/total)^power
# 类型 3（缓入缓出）：前半 = (2n/total)^power / 2，后半 = 1 - (2-2n/total)^power / 2
# 每步乘法后立即除以 10000，防整数溢出。

# 自备常量（不依赖别的计分板常量表）
scoreboard players set #ez_2 editor 2
scoreboard players set #ez_5k editor 5000
scoreboard players set #ez_10k editor 10000

# 总数 0（只有一个音符）⇒ 进度 0，直接返回
scoreboard players set #ez_ratio editor 0
execute unless score #ez_total editor matches 1.. run return 0

# ===== 基础进度 x = n * 10000 / total =====
scoreboard players operation #ez_x editor = #ez_n editor
scoreboard players operation #ez_x editor *= #ez_10k editor
scoreboard players operation #ez_x editor /= #ez_total editor

# ===== 类型 3：半程分界点 half = total / 2 =====
execute if score #ez_type editor matches 3 run scoreboard players operation #ez_half editor = #ez_total editor
execute if score #ez_type editor matches 3 run scoreboard players operation #ez_half editor /= #ez_2 editor
# 类型 3：把 x 缩放到 [0,10000]
execute if score #ez_type editor matches 3 if score #ez_n editor <= #ez_half editor run scoreboard players operation #ez_x editor *= #ez_2 editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor run scoreboard players operation #ez_x editor *= #ez_2 editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor run scoreboard players operation #ez_x editor -= #ez_10k editor

# ===== 幂运算 x_pow = x^power =====
execute if score #ez_power editor matches 1 run scoreboard players operation #ez_xp editor = #ez_x editor

execute if score #ez_power editor matches 2 run scoreboard players operation #ez_t editor = #ez_x editor
execute if score #ez_power editor matches 2 run scoreboard players operation #ez_t editor *= #ez_x editor
execute if score #ez_power editor matches 2 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_power editor matches 2 run scoreboard players operation #ez_xp editor = #ez_t editor

execute if score #ez_power editor matches 3 run scoreboard players operation #ez_t editor = #ez_x editor
execute if score #ez_power editor matches 3 run scoreboard players operation #ez_t editor *= #ez_x editor
execute if score #ez_power editor matches 3 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_power editor matches 3 run scoreboard players operation #ez_t editor *= #ez_x editor
execute if score #ez_power editor matches 3 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_power editor matches 3 run scoreboard players operation #ez_xp editor = #ez_t editor

execute if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor = #ez_x editor
execute if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor *= #ez_x editor
execute if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor *= #ez_x editor
execute if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor *= #ez_x editor
execute if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_power editor matches 4 run scoreboard players operation #ez_xp editor = #ez_t editor

execute if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor = #ez_x editor
execute if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor *= #ez_x editor
execute if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor *= #ez_x editor
execute if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor *= #ez_x editor
execute if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor *= #ez_x editor
execute if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_power editor matches 5 run scoreboard players operation #ez_xp editor = #ez_t editor

execute unless score #ez_power editor matches 1..5 run scoreboard players operation #ez_xp editor = #ez_x editor

# ===== 类型 2 / 类型 3 后半段：rev_pow = (10000 - x)^power =====
execute if score #ez_type editor matches 2 run scoreboard players operation #ez_xr editor = #ez_10k editor
execute if score #ez_type editor matches 2 run scoreboard players operation #ez_xr editor -= #ez_x editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor run scoreboard players operation #ez_xr editor = #ez_10k editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor run scoreboard players operation #ez_xr editor -= #ez_x editor

execute if score #ez_type editor matches 2 run scoreboard players operation #ez_rp editor = #ez_xr editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor run scoreboard players operation #ez_rp editor = #ez_xr editor

# power = 2
execute if score #ez_type editor matches 2 if score #ez_power editor matches 2 run scoreboard players operation #ez_t editor = #ez_xr editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 2 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 2 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 2 run scoreboard players operation #ez_rp editor = #ez_t editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 2 run scoreboard players operation #ez_t editor = #ez_xr editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 2 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 2 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 2 run scoreboard players operation #ez_rp editor = #ez_t editor

# power = 3
execute if score #ez_type editor matches 2 if score #ez_power editor matches 3 run scoreboard players operation #ez_t editor = #ez_xr editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 3 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 3 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 3 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 3 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 3 run scoreboard players operation #ez_rp editor = #ez_t editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 3 run scoreboard players operation #ez_t editor = #ez_xr editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 3 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 3 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 3 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 3 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 3 run scoreboard players operation #ez_rp editor = #ez_t editor

# power = 4
execute if score #ez_type editor matches 2 if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor = #ez_xr editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 4 run scoreboard players operation #ez_rp editor = #ez_t editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor = #ez_xr editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 4 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 4 run scoreboard players operation #ez_rp editor = #ez_t editor

# power = 5
execute if score #ez_type editor matches 2 if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor = #ez_xr editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 2 if score #ez_power editor matches 5 run scoreboard players operation #ez_rp editor = #ez_t editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor = #ez_xr editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor *= #ez_xr editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 5 run scoreboard players operation #ez_t editor /= #ez_10k editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor if score #ez_power editor matches 5 run scoreboard players operation #ez_rp editor = #ez_t editor

# 幂次非法（不在 1..5）→ 退化为线性
execute if score #ez_type editor matches 2 unless score #ez_power editor matches 1..5 run scoreboard players operation #ez_rp editor = #ez_xr editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor unless score #ez_power editor matches 1..5 run scoreboard players operation #ez_rp editor = #ez_xr editor

# ===== 按类型输出 ratio =====
# 类型 1（缓入）
execute if score #ez_type editor matches 1 run scoreboard players operation #ez_ratio editor = #ez_xp editor
# 类型 2（缓出）
execute if score #ez_type editor matches 2 run scoreboard players operation #ez_ratio editor = #ez_10k editor
execute if score #ez_type editor matches 2 run scoreboard players operation #ez_ratio editor -= #ez_rp editor
# 类型 3（缓入缓出）前半
execute if score #ez_type editor matches 3 if score #ez_n editor <= #ez_half editor run scoreboard players operation #ez_ratio editor = #ez_xp editor
execute if score #ez_type editor matches 3 if score #ez_n editor <= #ez_half editor run scoreboard players operation #ez_ratio editor /= #ez_2 editor
# 类型 3（缓入缓出）后半
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor run scoreboard players operation #ez_ratio editor = #ez_10k editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor run scoreboard players operation #ez_ratio editor -= #ez_rp editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor run scoreboard players operation #ez_ratio editor /= #ez_2 editor
execute if score #ez_type editor matches 3 if score #ez_n editor > #ez_half editor run scoreboard players add #ez_ratio editor 5000
# 默认线性
execute unless score #ez_type editor matches 1..3 run scoreboard players operation #ez_ratio editor = #ez_x editor
