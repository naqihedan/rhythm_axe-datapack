# 填充真正干活：在【起点 ~ 终点】之间生成新音符（属性继承「选区首个音符」）
#   ① 先找模板：选区内为空 → 报错「没有可复制的音符」并中断（还没 begin，不产生快照）
#   ② 快照 → 按模式生成候选时刻：设定个数 = [起点,终点] 等分点里**去掉两端**的 N 个；
#      设定间隔 = 起点 + k×S（k≥1 且 < 终点）。★ 头尾一律不生成，只在头尾之间生成
#   ③ 容量预检（禁止一刻多音符时）：要生成的颗数 > 开区间可用刻数 → 报错「挤不下」并中断
#   ④ 只对「新生成 + 站在起点/终点上的头尾音符」做一次分布（与【执行分布】同一套参数）
#      ⇒ 原本选中的其他音符**完全不动**（时间、位置都不动）；头尾参与才能保住「头尾之间等分插入」
#   ⑤ dfsel 处理（默认开启：丢弃原选区，改选「新生成 + 头尾音符」）→ 重排 → 提交 → 刷新 → 下一刻回面板
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data remove storage rhythm_axe:prop src
data modify storage rhythm_axe:prop idx set value 0
function rhythm_axe:editor/menu/note/df/df_fill_src with storage rhythm_axe:prop
execute unless data storage rhythm_axe:prop src run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"没有可复制的音符（先选中至少 1 个音符当属性模板）","color":"red"}]
execute unless data storage rhythm_axe:prop src run return fail
# ── 容量预检（只在「禁止一刻内填充多个音符」时做）──
#   禁止同刻 ⇒ 新音符各占一刻，且都落在 (起点, 终点) 开区间 ⇒ 可用刻数 = 终点 − 起点 − 1
#   想要几颗：设定个数 = 【个数】；设定间隔 = 开区间内能放的候选数（可用刻数 ÷ 间隔）
#   挤不下直接报错返回（★ 放在 file/begin 之前，不产生空快照）
execute store result score #fg_mode editor run data get storage rhythm_axe:maps.editor editing.df.mode
scoreboard players set #fg_dup editor 0
execute store result score #fg_dup editor run data get storage rhythm_axe:maps.editor editing.df.dup
execute if score #fg_dup editor matches 0 run execute store result score #fg_ta editor run data get storage rhythm_axe:maps.editor editing.df.t_a
execute if score #fg_dup editor matches 0 run execute store result score #fg_tb editor run data get storage rhythm_axe:maps.editor editing.df.t_b
execute if score #fg_dup editor matches 0 run scoreboard players operation #fg_span editor = #fg_tb editor
execute if score #fg_dup editor matches 0 run scoreboard players operation #fg_span editor -= #fg_ta editor
execute if score #fg_dup editor matches 0 run scoreboard players remove #fg_span editor 1
execute if score #fg_dup editor matches 0 if score #fg_span editor matches ..-1 run scoreboard players set #fg_span editor 0
scoreboard players set #fg_want editor 0
execute if score #fg_dup editor matches 0 if score #fg_mode editor matches 0 run execute store result score #fg_want editor run data get storage rhythm_axe:maps.editor editing.df.cnt
execute if score #fg_dup editor matches 0 if score #fg_mode editor matches 1 run execute store result score #fg_step editor run data get storage rhythm_axe:maps.editor editing.df.stp
execute if score #fg_dup editor matches 0 if score #fg_mode editor matches 1 run scoreboard players add #fg_step editor 1
execute if score #fg_dup editor matches 0 if score #fg_mode editor matches 1 run scoreboard players operation #fg_want editor = #fg_span editor
execute if score #fg_dup editor matches 0 if score #fg_mode editor matches 1 if score #fg_step editor matches 1.. run scoreboard players operation #fg_want editor /= #fg_step editor
execute if score #fg_dup editor matches 0 if score #fg_want editor > #fg_span editor run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"挤不下：","color":"red"},{"text":"起点~终点之间（不含两端）只有 ","color":"red"},{"score":{"name":"#fg_span","objective":"editor"},"color":"red"},{"text":" 刻可用，放不下 ","color":"red"},{"score":{"name":"#fg_want","objective":"editor"},"color":"red"},{"text":" 个音符。可减少个数 / 加大间隔 / 拉长起止区间，或把「允许一刻内填充多个音符」设为允许","color":"red"}]
execute if score #fg_dup editor matches 0 if score #fg_want editor > #fg_span editor run return fail
execute store result storage rhythm_axe:maps.editor editing.panel_from int 1 run data get storage rhythm_axe:maps.editor current_panel
function rhythm_axe:editor/file/begin
data modify storage rhythm_axe:maps.editor op_label set value "插值填充"
function rhythm_axe:editor/util/scan_next_id
# ★ scan_next_id 结尾会把 prop.cursor 删掉 ⇒ 必须补回来！
#   否则接下来的 df_fill_put 因缺宏参数 cursor **无法实例化**（一行都不跑 ⇒ 填充永远是 0 个）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
scoreboard players set #fg_new editor 0
execute store result score #fill_id editor run data get storage rhythm_axe:maps.editor next_note_id
execute store result score #fg_mode editor run data get storage rhythm_axe:maps.editor editing.df.mode
execute if score #fg_mode editor matches 0 run function rhythm_axe:editor/menu/note/df/df_fill_bycount with storage rhythm_axe:prop
execute if score #fg_mode editor matches 1 run function rhythm_axe:editor/menu/note/df/df_fill_bystep with storage rhythm_axe:prop
execute store result storage rhythm_axe:maps.editor next_note_id int 1 run scoreboard players get #fill_id editor
# 分布（**只对 新生成 + 头尾音符**）：时间 + 位置都改；其余已选中音符完全不动
#   时间是否严格递增（= 禁止一刻多音符）由「允许一刻内填充多个音符」决定
#   纯【执行时间分布】看的是「拆分同一刻内的音符」，两个开关互不影响
# 时间：只有「设定个数」模式才做分布（让插值/幂次生效）；
#   「设定间隔」模式的时间由生成阶段定死 = 起点 + k×(间隔+1)，**不能再分布**（否则等距会被均匀化抹平）
execute if score #fg_mode editor matches 0 run data modify storage rhythm_axe:prop do_time set value 1b
data modify storage rhythm_axe:prop do_space set value 1b
data remove storage rhythm_axe:prop group
data remove storage rhythm_axe:prop strict
# 参与集合 = 本次新生成 + 头尾音符（其余已选中音符不动）；#fg_dup 已在容量预检里读过
data modify storage rhythm_axe:prop dist_fill set value 1b
function rhythm_axe:editor/menu/note/df/df_fill_mark with storage rhythm_axe:prop
execute if score #fg_dup editor matches 0 run data modify storage rhythm_axe:prop strict set value 1b
function rhythm_axe:editor/menu/note/df/df_dist_count
function rhythm_axe:editor/menu/note/df/df_dist_drive
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/util/move_out_drive
function rhythm_axe:editor/util/move_in_drive
# dfsel 处理 + 清 df_new 标记
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/menu/note/df/df_fill_flag with storage rhythm_axe:prop
function rhythm_axe:editor/file/commit
function rhythm_axe:editor/refresh
scoreboard players add #content_ver editor 1
execute store result storage rhythm_axe:maps.editor content_ver int 1 run scoreboard players get #content_ver editor
# 操作反馈：文案 + 数量（show_feedback 会拼成「已插值填充 N 个音符」+【撤销】【重做】），
#   由下一刻的 df_return_next 在面板渲染完后发出
data modify storage rhythm_axe:maps.editor feedback set value "已插值填充"
execute store result score #fb_count editor run scoreboard players get #fg_new editor
data modify storage rhythm_axe:prop fb_count set value 1b
data remove storage rhythm_axe:maps.editor editing.df.k
data remove storage rhythm_axe:maps.editor editing.df.k2
data remove storage rhythm_axe:prop do_time
data remove storage rhythm_axe:prop do_space
data remove storage rhythm_axe:prop strict
data remove storage rhythm_axe:prop group
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop src
data remove storage rhythm_axe:prop dist_fill
data remove storage rhythm_axe:prop mark
data remove storage rhythm_axe:prop dm_i
data remove storage rhythm_axe:prop dm_ta
data remove storage rhythm_axe:prop dm_tb
data remove storage rhythm_axe:prop move_idx
data remove storage rhythm_axe:prop move_out
data remove storage rhythm_axe:prop tmp_elem
data remove storage rhythm_axe:prop index
schedule function rhythm_axe:editor/menu/note/df/df_return_next 1t
