# 线性运动 参数+终点 同刻下发（@s = 展示实体；tag=note_linear_pending note_active=1，active_note ①消费时调用）
# ★ 2026-08-14：插值参数（duration=D、start=0）与终点【同一刻】写入（wiki：同刻多次变更计为单个变更）
#   → 插值时钟从终点到达时才开始：起点=客户端当前渲染状态（出生位置），无起步前跳；
#     出生包与终点包间隔 3 tick，客户端卡顿把两包同刻消费导致"插值起点丢失"的概率进一步降低（见 active_note）
# 普通 end=0（到判定位置）、玻璃 end=+dist×dur/lt（穿过后段），都由 note_lin_end 统一携带
# 混凝土不走客户端插值（display_animation 三段，见 play/note/concrete/*；2026-08-09 回退）
# ★ 2026-09-04 恢复 item：出生时 item=air 隐藏、暂存于 note_show，此处置回实际方块（scale 全程恒定不插值）
execute if data entity @s data.note_show run data modify entity @s item set from entity @s data.note_show
execute if data entity @s data.note_show run data remove entity @s data.note_show
# ★ 临时 storage 路径用 m 不用 merge（merge 是 data modify 操作符，Spyglass/解析器会把路径 merge 误当操作）
#   storage 语法必须带路径（不能直接操作 storage 根）：m = 本音符临时容器
data modify storage rhythm_axe:motion m set value {}
data modify storage rhythm_axe:motion m.transformation set value {translation:[0.0,0.0,0.0]}
execute store result storage rhythm_axe:motion m.transformation.translation[2] float 0.01 run scoreboard players get @s note_lin_end
# scale 终点（note_lin_sz_end 支持，玻璃/普通用不到，保留兼容）
# ★ scale 是数组 [x,y,z]（ListTag），必须用 [0.0,0.0,0.0] 不能用 {x:...}（compound）
execute if score @s note_lin_sz_end matches 1.. run data modify storage rhythm_axe:motion m.transformation.scale set value [0.0,0.0,0.0]
execute if score @s note_lin_sz_end matches 1.. run execute store result storage rhythm_axe:motion m.transformation.scale[0] float 0.01 run data get entity @s transformation.scale[0] 100
execute if score @s note_lin_sz_end matches 1.. run execute store result storage rhythm_axe:motion m.transformation.scale[1] float 0.01 run data get entity @s transformation.scale[1] 100
execute if score @s note_lin_sz_end matches 1.. run execute store result storage rhythm_axe:motion m.transformation.scale[2] float 0.01 run scoreboard players get @s note_lin_sz_end
# ★ 2026-09-04 线性音符出生用 item=air 隐藏（summon 暂存 item 到 note_show、item 设 air）；
#   本函数恢复 item=方块（见上方），scale 恒定，只写 translation 终点 + 插值参数（无"从小到大"放大）
# ★ 插值参数与终点同刻下发（单次变更；start_interpolation 语义=相对"客户端收到更新后下一客户端刻"的延迟刻数，0=立即开始）
execute store result entity @s interpolation_duration int 1 run scoreboard players get @s note_lin_dur
data modify entity @s start_interpolation set value 0
# 单条 merge from storage（终点；插值时长/起点已在上方同一刻设好）
data modify entity @s {} merge from storage rhythm_axe:motion m
# 清理临时 storage（1.21.5+ 根路径移除禁用 → 逐键删，if data 保护）
execute if data storage rhythm_axe:motion m run data remove storage rhythm_axe:motion m
# ★ 性能优化（2026-09-04，O(N²) 消除）：此刻展示实体即将开始线性运动（note_linear），
#   同步给配对交互实体打 note_linear 标签 → active_note 据此让交互实体的 note_lin_t 与展示实体
#   同刻递增，并由 move_self 自算位置（替代 move 每展示实体全量扫描交互实体）。
scoreboard players operation #nid play_state = @s note_id
execute as @e[type=interaction,tag=note_interaction] if score @s note_id = #nid play_state run tag @s add note_linear
# ★ 性能优化（2026-09-04，O(N²) 消除）：玻璃中心 marker 也同步打 note_linear → active_note 据此让
#   marker 的 note_lin_t 与展示实体同刻递增，并由 marker_self 自算扫掠段（替代 move 全量扫描 marker）。
execute as @e[type=marker,tag=note_glass_center] if score @s note_id = #nid play_state run tag @s add note_linear
