# ========== 面板 20：分布 / 插值填充（号段 20001~21103）==========
# 参数全在 rhythm_axe:maps.editor editing.df；每次改参数后调 df_render 重绘。
# 入口：面板 10 / 18 共用组 11512【分布】/ 11513【插值填充】→ df_open（current_panel 置 20）

# 入口白名单守卫（两行：提示 + 中断）
execute unless score #click_value editor matches 20001..21104 run function rhythm_axe:editor/menu/wrong_panel
execute unless score #click_value editor matches 20001..21104 run return fail

# ── 行 3：时间缓动（单按钮循环 1 缓入 → 2 缓出 → 3 缓入缓出）──
execute if score #click_value editor matches 20001 run execute store result score #df_t editor run data get storage rhythm_axe:maps.editor editing.df.t_ease
execute if score #click_value editor matches 20001 if score #df_t editor matches 1 run data modify storage rhythm_axe:maps.editor editing.df.t_ease set value 2
execute if score #click_value editor matches 20001 if score #df_t editor matches 2 run data modify storage rhythm_axe:maps.editor editing.df.t_ease set value 3
execute if score #click_value editor matches 20001 if score #df_t editor matches 3 run data modify storage rhythm_axe:maps.editor editing.df.t_ease set value 1
execute if score #click_value editor matches 20001 unless score #df_t editor matches 1..3 run data modify storage rhythm_axe:maps.editor editing.df.t_ease set value 1
execute if score #click_value editor matches 20001 run function rhythm_axe:editor/menu/note/df/df_render
execute if score #click_value editor matches 20001 run return 0
# ── 行 3：时间幂次 ±（1~5）──
execute if score #click_value editor matches 20002..20003 run execute store result score #df_v editor run data get storage rhythm_axe:maps.editor editing.df.t_pow
execute if score #click_value editor matches 20002 run scoreboard players remove #df_v editor 1
execute if score #click_value editor matches 20003 run scoreboard players add #df_v editor 1
execute if score #df_v editor matches ..0 run scoreboard players set #df_v editor 1
execute if score #df_v editor matches 6.. run scoreboard players set #df_v editor 5
execute if score #click_value editor matches 20002..20003 run execute store result storage rhythm_axe:maps.editor editing.df.t_pow int 1 run scoreboard players get #df_v editor
execute if score #click_value editor matches 20002..20003 run function rhythm_axe:editor/menu/note/df/df_render
execute if score #click_value editor matches 20002..20003 run return 0

# ── 行 4：时间端点 ±（20101/20102 起点，20103/20104 终点；下界 0）──
execute if score #click_value editor matches 20101..20102 run execute store result score #df_v editor run data get storage rhythm_axe:maps.editor editing.df.t_a
execute if score #click_value editor matches 20103..20104 run execute store result score #df_v editor run data get storage rhythm_axe:maps.editor editing.df.t_b
execute if score #click_value editor matches 20101 run scoreboard players remove #df_v editor 1
execute if score #click_value editor matches 20103 run scoreboard players remove #df_v editor 1
execute if score #click_value editor matches 20102 run scoreboard players add #df_v editor 1
execute if score #click_value editor matches 20104 run scoreboard players add #df_v editor 1
execute if score #df_v editor matches ..-1 run scoreboard players set #df_v editor 0
execute if score #click_value editor matches 20101..20102 run execute store result storage rhythm_axe:maps.editor editing.df.t_a int 1 run scoreboard players get #df_v editor
execute if score #click_value editor matches 20103..20104 run execute store result storage rhythm_axe:maps.editor editing.df.t_b int 1 run scoreboard players get #df_v editor
execute if score #click_value editor matches 20101..20104 run function rhythm_axe:editor/menu/note/df/df_render
execute if score #click_value editor matches 20101..20104 run return 0

# ── 行 5：取点按钮（20201 使用首尾音符时间 / 20202 入点 / 20203 出点）──
execute if score #click_value editor matches 20201 run data modify storage rhythm_axe:prop w_ta set value 1b
execute if score #click_value editor matches 20201 run data modify storage rhythm_axe:prop w_tb set value 1b
execute if score #click_value editor matches 20201 run function rhythm_axe:editor/menu/note/df/df_scan
execute if score #click_value editor matches 20202 run execute store result storage rhythm_axe:maps.editor editing.df.t_a int 1 run scoreboard players get #playhead editor
execute if score #click_value editor matches 20203 run execute store result storage rhythm_axe:maps.editor editing.df.t_b int 1 run scoreboard players get #playhead editor
execute if score #click_value editor matches 20201..20203 run function rhythm_axe:editor/menu/note/df/df_render
execute if score #click_value editor matches 20201..20203 run return 0

# ── 行 202 列 0：拆分同一刻内的音符（分布：时间 的开关；只影响时间分布）──
execute if score #click_value editor matches 20200 run execute store result score #df_t editor run data get storage rhythm_axe:maps.editor editing.df.spl
execute if score #click_value editor matches 20200 if score #df_t editor matches 1 run data modify storage rhythm_axe:maps.editor editing.df.spl set value 0b
execute if score #click_value editor matches 20200 unless score #df_t editor matches 1 run data modify storage rhythm_axe:maps.editor editing.df.spl set value 1b
execute if score #click_value editor matches 20200 run function rhythm_axe:editor/menu/note/df/df_render
execute if score #click_value editor matches 20200 run return 0

# ── 行 7：空间缓动（单按钮循环）──
execute if score #click_value editor matches 20301 run execute store result score #df_t editor run data get storage rhythm_axe:maps.editor editing.df.s_ease
execute if score #click_value editor matches 20301 if score #df_t editor matches 1 run data modify storage rhythm_axe:maps.editor editing.df.s_ease set value 2
execute if score #click_value editor matches 20301 if score #df_t editor matches 2 run data modify storage rhythm_axe:maps.editor editing.df.s_ease set value 3
execute if score #click_value editor matches 20301 if score #df_t editor matches 3 run data modify storage rhythm_axe:maps.editor editing.df.s_ease set value 1
execute if score #click_value editor matches 20301 unless score #df_t editor matches 1..3 run data modify storage rhythm_axe:maps.editor editing.df.s_ease set value 1
execute if score #click_value editor matches 20301 run function rhythm_axe:editor/menu/note/df/df_render
execute if score #click_value editor matches 20301 run return 0
# ── 行 7：空间幂次 ± ──
execute if score #click_value editor matches 20302..20303 run execute store result score #df_v editor run data get storage rhythm_axe:maps.editor editing.df.s_pow
execute if score #click_value editor matches 20302 run scoreboard players remove #df_v editor 1
execute if score #click_value editor matches 20303 run scoreboard players add #df_v editor 1
execute if score #df_v editor matches ..0 run scoreboard players set #df_v editor 1
execute if score #df_v editor matches 6.. run scoreboard players set #df_v editor 5
execute if score #click_value editor matches 20302..20303 run execute store result storage rhythm_axe:maps.editor editing.df.s_pow int 1 run scoreboard players get #df_v editor
execute if score #click_value editor matches 20302..20303 run function rhythm_axe:editor/menu/note/df/df_render
execute if score #click_value editor matches 20302..20303 run return 0

# ── 行 8/9：空间端点 ±（20401..20406 从 / 20501..20506 到；列码 1..6 = X− X+ Y− Y+ Z− Z+；步长 0.5 = 50 定点）──
#   ★ 两个号段必须分开写：写成 20401..20506 会把 20407/20408（【输入数值】/【使用首音符位置】）一起吞掉！
#   #df_v = 值−20401（0..5）；#df_i = v ÷ 2 → 轴（0=X/1=Y/2=Z）；#df_sg = v % 2 → 0 = 减（−0.5）/ 1 = 加（+0.5）
scoreboard players set #df_pm editor 0
execute if score #click_value editor matches 20401..20406 run scoreboard players set #df_pm editor 1
execute if score #click_value editor matches 20501..20506 run scoreboard players set #df_pm editor 1
execute if score #df_pm editor matches 1 run data modify storage rhythm_axe:prop list set value "a"
execute if score #click_value editor matches 20501..20506 run data modify storage rhythm_axe:prop list set value "b"
execute if score #df_pm editor matches 1 run scoreboard players operation #df_v editor = #click_value editor
execute if score #click_value editor matches 20501..20506 run scoreboard players remove #df_v editor 100
execute if score #df_pm editor matches 1 run scoreboard players remove #df_v editor 20401
scoreboard players set #df_c2 editor 2
execute if score #df_pm editor matches 1 run scoreboard players operation #df_i editor = #df_v editor
execute if score #df_pm editor matches 1 run scoreboard players operation #df_i editor /= #df_c2 editor
execute if score #df_pm editor matches 1 run scoreboard players operation #df_sg editor = #df_v editor
execute if score #df_pm editor matches 1 run scoreboard players operation #df_sg editor %= #df_c2 editor
data modify storage rhythm_axe:prop delta set value -50
execute if score #df_pm editor matches 1 if score #df_sg editor matches 1 run data modify storage rhythm_axe:prop delta set value 50
execute if score #df_pm editor matches 1 run execute store result storage rhythm_axe:prop idx int 1 run scoreboard players get #df_i editor
execute if score #df_pm editor matches 1 run function rhythm_axe:editor/menu/note/df/df_step_axis with storage rhythm_axe:prop
execute if score #df_pm editor matches 1 run function rhythm_axe:editor/menu/note/df/df_render
execute if score #df_pm editor matches 1 run return 0
# ── 行 8/9：【输入数值】对话框（20407 从 / 20507 到）──
execute if score #click_value editor matches 20407 run function rhythm_axe:editor/menu/dialog/dialog_open_df_from
execute if score #click_value editor matches 20507 run function rhythm_axe:editor/menu/dialog/dialog_open_df_to
# ★ return 也必须拆开写：写 20407..20507 会把 20408（【使用首音符位置】）一起 return 掉
execute if score #click_value editor matches 20407 run return 0
execute if score #click_value editor matches 20507 run return 0
# ── 行 8/9：【使用首/尾音符位置】（20408 / 20508）──
execute if score #click_value editor matches 20408 run data modify storage rhythm_axe:prop w_sa set value 1b
execute if score #click_value editor matches 20508 run data modify storage rhythm_axe:prop w_sb set value 1b
execute if score #click_value editor matches 20408 run function rhythm_axe:editor/menu/note/df/df_scan
execute if score #click_value editor matches 20508 run function rhythm_axe:editor/menu/note/df/df_scan
execute if score #click_value editor matches 20408 run function rhythm_axe:editor/menu/note/df/df_render
execute if score #click_value editor matches 20508 run function rhythm_axe:editor/menu/note/df/df_render
execute if score #click_value editor matches 20408 run return 0
execute if score #click_value editor matches 20508 run return 0

# ── 行 11：填充模式切换（20601）──
execute if score #click_value editor matches 20601 run execute store result score #df_t editor run data get storage rhythm_axe:maps.editor editing.df.mode
execute if score #click_value editor matches 20601 if score #df_t editor matches 0 run data modify storage rhythm_axe:maps.editor editing.df.mode set value 1
execute if score #click_value editor matches 20601 unless score #df_t editor matches 0 run data modify storage rhythm_axe:maps.editor editing.df.mode set value 0
execute if score #click_value editor matches 20601 run function rhythm_axe:editor/menu/note/df/df_render
execute if score #click_value editor matches 20601 run return 0
# ── 行 12：个数 ±（20701/20702，1~99）──
execute if score #click_value editor matches 20701..20702 run execute store result score #df_v editor run data get storage rhythm_axe:maps.editor editing.df.cnt
execute if score #click_value editor matches 20701 run scoreboard players remove #df_v editor 1
execute if score #click_value editor matches 20702 run scoreboard players add #df_v editor 1
execute if score #click_value editor matches 20701..20702 if score #df_v editor matches ..0 run scoreboard players set #df_v editor 1
execute if score #click_value editor matches 20701..20702 if score #df_v editor matches 100.. run scoreboard players set #df_v editor 99
execute if score #click_value editor matches 20701..20702 run execute store result storage rhythm_axe:maps.editor editing.df.cnt int 1 run scoreboard players get #df_v editor
execute if score #click_value editor matches 20701..20702 run function rhythm_axe:editor/menu/note/df/df_render
execute if score #click_value editor matches 20701..20702 run return 0
# ── 行 12：【输入数值】对话框（20703）──
execute if score #click_value editor matches 20703 run function rhythm_axe:editor/menu/dialog/dialog_open_df_count
execute if score #click_value editor matches 20703 run return 0
# ── 行 13：间隔三级 ±（20801 −一拍 / 20802 −半拍 / 20803 −1刻 / 20804 +1刻 / 20805 +半拍 / 20806 +一拍；0~9999）──
execute if score #click_value editor matches 20801..20806 run function rhythm_axe:editor/menu/note/panel/note_time_tpb
scoreboard players set #df_c2 editor 2
execute if score #click_value editor matches 20801..20806 run scoreboard players operation #df_f2 editor = #time_step editor
execute if score #click_value editor matches 20801..20806 run scoreboard players operation #df_f2 editor /= #df_c2 editor
execute if score #click_value editor matches 20801..20806 if score #df_f2 editor matches ..0 run scoreboard players set #df_f2 editor 1
execute if score #click_value editor matches 20801..20806 run execute store result score #df_v editor run data get storage rhythm_axe:maps.editor editing.df.stp
execute if score #click_value editor matches 20801 run scoreboard players operation #df_v editor -= #time_step editor
execute if score #click_value editor matches 20802 run scoreboard players operation #df_v editor -= #df_f2 editor
execute if score #click_value editor matches 20803 run scoreboard players remove #df_v editor 1
execute if score #click_value editor matches 20804 run scoreboard players add #df_v editor 1
execute if score #click_value editor matches 20805 run scoreboard players operation #df_v editor += #df_f2 editor
execute if score #click_value editor matches 20806 run scoreboard players operation #df_v editor += #time_step editor
execute if score #click_value editor matches 20801..20806 if score #df_v editor matches ..-1 run scoreboard players set #df_v editor 0
execute if score #click_value editor matches 20801..20806 if score #df_v editor matches 10000.. run scoreboard players set #df_v editor 9999
execute if score #click_value editor matches 20801..20806 run execute store result storage rhythm_axe:maps.editor editing.df.stp int 1 run scoreboard players get #df_v editor
execute if score #click_value editor matches 20801..20806 run function rhythm_axe:editor/menu/note/df/df_render
execute if score #click_value editor matches 20801..20806 run return 0
# ── 行 13：【输入数值】对话框（20807）──
execute if score #click_value editor matches 20807 run function rhythm_axe:editor/menu/dialog/dialog_open_df_step
execute if score #click_value editor matches 20807 run return 0

# ── 行 15：允许一刻内填充多个音符（20901）──
execute if score #click_value editor matches 20901 run execute store result score #df_t editor run data get storage rhythm_axe:maps.editor editing.df.dup
execute if score #click_value editor matches 20901 if score #df_t editor matches 0 run data modify storage rhythm_axe:maps.editor editing.df.dup set value 1b
execute if score #click_value editor matches 20901 unless score #df_t editor matches 0 run data modify storage rhythm_axe:maps.editor editing.df.dup set value 0b
execute if score #click_value editor matches 20901 run function rhythm_axe:editor/menu/note/df/df_render
execute if score #click_value editor matches 20901 run return 0
# ── 行 16：操作后选中新音符（21001）──
execute if score #click_value editor matches 21001 run execute store result score #df_t editor run data get storage rhythm_axe:maps.editor editing.df.dfsel
execute if score #click_value editor matches 21001 if score #df_t editor matches 0 run data modify storage rhythm_axe:maps.editor editing.df.dfsel set value 1b
execute if score #click_value editor matches 21001 unless score #df_t editor matches 0 run data modify storage rhythm_axe:maps.editor editing.df.dfsel set value 0b
execute if score #click_value editor matches 21001 run function rhythm_axe:editor/menu/note/df/df_render
execute if score #click_value editor matches 21001 run return 0

# ── 行 18：执行分布 / 执行填充 / 返回 ──
# 21101【执行时间分布】：只改 time；严格递增与否 = 「拆分同一刻内的音符」开关（关闭时按同刻分组）
execute if score #click_value editor matches 21101 run data modify storage rhythm_axe:prop do_time set value 1b
execute if score #click_value editor matches 21101 run data remove storage rhythm_axe:prop do_space
execute if score #click_value editor matches 21101 run data modify storage rhythm_axe:prop op_label set value "时间分布"
execute if score #click_value editor matches 21101 run execute store result score #df_spl editor run data get storage rhythm_axe:maps.editor editing.df.spl
execute if score #click_value editor matches 21101 if score #df_spl editor matches 1 run data modify storage rhythm_axe:prop strict set value 1b
execute if score #click_value editor matches 21101 if score #df_spl editor matches 1 run data remove storage rhythm_axe:prop group
execute if score #click_value editor matches 21101 if score #df_spl editor matches 0 run data remove storage rhythm_axe:prop strict
execute if score #click_value editor matches 21101 if score #df_spl editor matches 0 run data modify storage rhythm_axe:prop group set value 1b
execute if score #click_value editor matches 21101 run return run function rhythm_axe:editor/menu/note/df/df_apply_dist
# 21104【执行空间分布】：只改 position（每颗音符按自身序号在从→到之间插值）
execute if score #click_value editor matches 21104 run data remove storage rhythm_axe:prop do_time
execute if score #click_value editor matches 21104 run data modify storage rhythm_axe:prop do_space set value 1b
execute if score #click_value editor matches 21104 run data remove storage rhythm_axe:prop strict
execute if score #click_value editor matches 21104 run data remove storage rhythm_axe:prop group
execute if score #click_value editor matches 21104 run data modify storage rhythm_axe:prop op_label set value "位置分布"
execute if score #click_value editor matches 21104 run return run function rhythm_axe:editor/menu/note/df/df_apply_dist
execute if score #click_value editor matches 21102 run return run function rhythm_axe:editor/menu/note/df/df_apply_fill
execute if score #click_value editor matches 21103 run execute store result score #df_from editor run data get storage rhythm_axe:maps.editor editing.df.from
execute if score #click_value editor matches 21103 if score #df_from editor matches 18 run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
execute if score #click_value editor matches 21103 unless score #df_from editor matches 18 run function rhythm_axe:editor/menu/note/list/note_list_open
execute if score #click_value editor matches 21103 run return 0
