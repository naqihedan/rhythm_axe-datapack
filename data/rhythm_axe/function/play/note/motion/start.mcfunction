# 线性运动 参数+终点 同刻下发（@s = 展示实体；tag=note_linear_pending note_active=1，active_note ①消费时调用）
# ★ 2026-08-14：插值参数（duration=D、start=0）与终点【同一刻】写入（wiki：同刻多次变更计为单个变更）
#   → 插值时钟从终点到达时才开始：起点=客户端当前渲染状态（出生位置），无起步前跳；
#     出生包与终点包间隔 3 tick，客户端卡顿把两包同刻消费导致"插值起点丢失"的概率进一步降低（见 active_note）
# 普通 end=0（到判定位置）、玻璃 end=+dist×dur/lt（穿过后段），都由 note_lin_end 统一携带
# 混凝土不走客户端插值（display_animation 三段，见 play/note/concrete/*；2026-08-09 回退）
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
# ★ 2026-08-29 线性音符恢复 size 已改由 active_note 在"移动前一刻"（active=2）硬切完成（不随插值长大）；
#   本函数不再写 scale，只写 translation 终点 + 插值参数
# ★ 插值参数与终点同刻下发（单次变更；start_interpolation 语义=相对"客户端收到更新后下一客户端刻"的延迟刻数，0=立即开始）
execute store result entity @s interpolation_duration int 1 run scoreboard players get @s note_lin_dur
data modify entity @s start_interpolation set value 0
# 单条 merge from storage（终点；插值时长/起点已在上方同一刻设好）
data modify entity @s {} merge from storage rhythm_axe:motion m
# 清理临时 storage（1.21.5+ 根路径移除禁用 → 逐键删，if data 保护）
execute if data storage rhythm_axe:motion m run data remove storage rhythm_axe:motion m
