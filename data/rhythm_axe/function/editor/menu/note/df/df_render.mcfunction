# ========== 面板 20「分布 / 插值填充」渲染驱动 ==========
# 组装各按钮组件到 rhythm_axe:df.rows → 依次用宏模板输出：前半 df_rows → 行 12/13 二选一 → 后半 df_rows2
#   （设定个数 / 设定间隔分别 18 / 18 行：用不到的那一行整个不输出），最后清掉临时键。
# ★ 每行 tellraw 第 1 个元素固定为中性组件 {"text":""}（在 df_rows 里写死）——防点击事件继承污染。
# ★ 灰按钮 = 不带 click_event；hover 说明为什么灰。

# 面板状态缺失（例如重进存档后直接 resume 到面板 20）→ 先建默认参数再画
execute unless data storage rhythm_axe:maps.editor editing.df run function rhythm_axe:editor/menu/note/df/df_open
# 渲染前清屏（项目惯例；顺带把本次渲染广播给其他协作者）
function rhythm_axe:editor/menu/clear_lines

# ── 读参数到计分项 ──
scoreboard players set #df_sel editor 0
execute store result score #df_sel editor run data get storage rhythm_axe:maps.editor selection
execute store result score #df_te editor run data get storage rhythm_axe:maps.editor editing.df.t_ease
execute store result score #df_tp editor run data get storage rhythm_axe:maps.editor editing.df.t_pow
execute store result score #df_ta editor run data get storage rhythm_axe:maps.editor editing.df.t_a
execute store result score #df_tb editor run data get storage rhythm_axe:maps.editor editing.df.t_b
execute store result score #df_se editor run data get storage rhythm_axe:maps.editor editing.df.s_ease
execute store result score #df_sp editor run data get storage rhythm_axe:maps.editor editing.df.s_pow
execute store result score #df_dup editor run data get storage rhythm_axe:maps.editor editing.df.dup
execute store result score #df_dsel editor run data get storage rhythm_axe:maps.editor editing.df.dfsel
execute store result score #df_spl editor run data get storage rhythm_axe:maps.editor editing.df.spl
execute store result score #df_mode editor run data get storage rhythm_axe:maps.editor editing.df.mode
execute store result score #df_cnt editor run data get storage rhythm_axe:maps.editor editing.df.cnt
execute store result score #df_stp editor run data get storage rhythm_axe:maps.editor editing.df.stp

# ── 间隔三级步长：一拍 = 播放头所在时间点的 tpb；半拍 = tpb ÷ 2（最少 1）；一刻 = 1 ──
function rhythm_axe:editor/menu/note/panel/note_time_tpb
scoreboard players operation #df_f1 editor = #time_step editor
scoreboard players set #df_c2 editor 2
scoreboard players operation #df_f2 editor = #df_f1 editor
scoreboard players operation #df_f2 editor /= #df_c2 editor
execute if score #df_f2 editor matches ..0 run scoreboard players set #df_f2 editor 1

# ============ 分布：时间 ============
# 行 3 时间插值（单按钮循环 1 缓入 → 2 缓出 → 3 缓入缓出）
execute if score #df_te editor matches 1 run data modify storage rhythm_axe:df rows.e1 set value "{\"text\":\"[缓入]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20001\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"时间插值：缓入。点击切换 → 缓出\"}}"
execute if score #df_te editor matches 2 run data modify storage rhythm_axe:df rows.e1 set value "{\"text\":\"[缓出]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20001\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"时间插值：缓出。点击切换 → 缓入缓出\"}}"
execute if score #df_te editor matches 3 run data modify storage rhythm_axe:df rows.e1 set value "{\"text\":\"[缓入缓出]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20001\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"时间插值：缓入缓出。点击切换 → 缓入\"}}"
execute unless score #df_te editor matches 1..3 run data modify storage rhythm_axe:df rows.e1 set value "{\"text\":\"[缓入]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20001\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"时间插值：缓入。点击切换 → 缓出\"}}"
# 时间幂次 − / +（1~5）
data modify storage rhythm_axe:df rows.p1m set value "{\"text\":\"[-]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20002\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"时间幂次 −1（1~5，1 = 线性）\"}}"
execute if score #df_tp editor matches ..1 run data modify storage rhythm_axe:df rows.p1m set value "{\"text\":\"[-]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"已是最小幂次 1（线性）\"}}"
data modify storage rhythm_axe:df rows.p1p set value "{\"text\":\"[+]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20003\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"时间幂次 +1（1~5，1 = 线性）\"}}"
execute if score #df_tp editor matches 5.. run data modify storage rhythm_axe:df rows.p1p set value "{\"text\":\"[+]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"已是最大幂次 5\"}}"
# 行 4 时间端点（起点 = 20101/20102，终点 = 20103/20104）
data modify storage rhythm_axe:df rows.tam set value "{\"text\":\"[-]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20101\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"起点 −1 刻\"}}"
execute if score #df_ta editor matches ..0 run data modify storage rhythm_axe:df rows.tam set value "{\"text\":\"[-]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"起点不能小于 0\"}}"
data modify storage rhythm_axe:df rows.tap set value "{\"text\":\"[+]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20102\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"起点 +1 刻\"}}"
data modify storage rhythm_axe:df rows.tbm set value "{\"text\":\"[-]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20103\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"终点 −1 刻\"}}"
execute if score #df_tb editor matches ..0 run data modify storage rhythm_axe:df rows.tbm set value "{\"text\":\"[-]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"终点不能小于 0\"}}"
data modify storage rhythm_axe:df rows.tbp set value "{\"text\":\"[+]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20104\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"终点 +1 刻\"}}"

# ============ 空间分布 ============
# 行 7 空间插值（单按钮循环）
execute if score #df_se editor matches 1 run data modify storage rhythm_axe:df rows.e2 set value "{\"text\":\"[缓入]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20301\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"空间插值：缓入。点击切换 → 缓出\"}}"
execute if score #df_se editor matches 2 run data modify storage rhythm_axe:df rows.e2 set value "{\"text\":\"[缓出]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20301\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"空间插值：缓出。点击切换 → 缓入缓出\"}}"
execute if score #df_se editor matches 3 run data modify storage rhythm_axe:df rows.e2 set value "{\"text\":\"[缓入缓出]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20301\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"空间插值：缓入缓出。点击切换 → 缓入\"}}"
execute unless score #df_se editor matches 1..3 run data modify storage rhythm_axe:df rows.e2 set value "{\"text\":\"[缓入]\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20301\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"空间插值：缓入。点击切换 → 缓出\"}}"
# 空间幂次 − / +
data modify storage rhythm_axe:df rows.p2m set value "{\"text\":\"[-]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20302\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"空间幂次 −1（1~5，1 = 线性）\"}}"
execute if score #df_sp editor matches ..1 run data modify storage rhythm_axe:df rows.p2m set value "{\"text\":\"[-]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"已是最小幂次 1（线性）\"}}"
data modify storage rhythm_axe:df rows.p2p set value "{\"text\":\"[+]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20303\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"空间幂次 +1（1~5，1 = 线性）\"}}"
execute if score #df_sp editor matches 5.. run data modify storage rhythm_axe:df rows.p2p set value "{\"text\":\"[+]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"已是最大幂次 5\"}}"
# 行 8「从」XYZ ±（20401..20406，步长 0.5）
data modify storage rhythm_axe:df rows.axm set value "{\"text\":\"[-]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20401\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"从 X −0.5\"}}"
data modify storage rhythm_axe:df rows.axp set value "{\"text\":\"[+]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20402\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"从 X +0.5\"}}"
data modify storage rhythm_axe:df rows.aym set value "{\"text\":\"[-]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20403\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"从 Y −0.5\"}}"
data modify storage rhythm_axe:df rows.ayp set value "{\"text\":\"[+]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20404\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"从 Y +0.5\"}}"
data modify storage rhythm_axe:df rows.azm set value "{\"text\":\"[-]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20405\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"从 Z −0.5\"}}"
data modify storage rhythm_axe:df rows.azp set value "{\"text\":\"[+]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20406\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"从 Z +0.5\"}}"
# 行 9「到」XYZ ±（20501..20506）
data modify storage rhythm_axe:df rows.bxm set value "{\"text\":\"[-]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20501\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"到 X −0.5\"}}"
data modify storage rhythm_axe:df rows.bxp set value "{\"text\":\"[+]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20502\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"到 X +0.5\"}}"
data modify storage rhythm_axe:df rows.bym set value "{\"text\":\"[-]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20503\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"到 Y −0.5\"}}"
data modify storage rhythm_axe:df rows.byp set value "{\"text\":\"[+]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20504\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"到 Y +0.5\"}}"
data modify storage rhythm_axe:df rows.bzm set value "{\"text\":\"[-]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20505\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"到 Z −0.5\"}}"
data modify storage rhythm_axe:df rows.bzp set value "{\"text\":\"[+]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20506\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"到 Z +0.5\"}}"

# ============ 填充 ============
# 行 11 填充模式（0 设定个数 / 1 设定间隔）
execute if score #df_mode editor matches 0 run data modify storage rhythm_axe:df rows.md set value "{\"text\":\"[设定个数]\",\"color\":\"aqua\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20601\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前：设定个数。点击切换 → 设定间隔\"}}"
execute unless score #df_mode editor matches 0 run data modify storage rhythm_axe:df rows.md set value "{\"text\":\"[设定间隔]\",\"color\":\"aqua\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20601\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前：设定间隔。点击切换 → 设定个数\"}}"
# ── 「个数」行 / 「间隔」行的**数值**组件（标签写在各行自己的宏里）──
data modify storage rhythm_axe:df rows.vc set value "{\"nbt\":\"editing.df.cnt\",\"storage\":\"rhythm_axe:maps.editor\",\"color\":\"white\"}"
data modify storage rhythm_axe:df rows.vs set value "{\"nbt\":\"editing.df.stp\",\"storage\":\"rhythm_axe:maps.editor\",\"color\":\"white\"}"


# ── 行 12 个数（20701/20702 ±、20703 输入数值）──
data modify storage rhythm_axe:df rows.cm set value "{\"text\":\"[-]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20701\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"每段插入个数 −1\"}}"
execute if score #df_cnt editor matches ..1 run data modify storage rhythm_axe:df rows.cm set value "{\"text\":\"[-]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"已是最小个数 1\"}}"
data modify storage rhythm_axe:df rows.cp set value "{\"text\":\"[+]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20702\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"每段插入个数 +1\"}}"
execute if score #df_cnt editor matches 99.. run data modify storage rhythm_axe:df rows.cp set value "{\"text\":\"[+]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"已是最大个数 99\"}}"
data modify storage rhythm_axe:df rows.cq set value "{\"text\":\"【输入数值】\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20703\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"输入每段插入的个数（1~99）\"}}"
# 行 13 间隔（20801..20806 三级 ±、20807 输入数值）
data modify storage rhythm_axe:df rows.s3m set value "{\"text\":\"[---]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20801\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"间隔 −一拍（当前 tpb）\"}}"
execute if score #df_stp editor matches ..-1 run data modify storage rhythm_axe:df rows.s3m set value "{\"text\":\"[---]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"已是最小间隔 0（每刻一颗）\"}}"
data modify storage rhythm_axe:df rows.s2m set value "{\"text\":\"[--]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20802\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"间隔 −半拍（tpb ÷ 2）\"}}"
execute if score #df_stp editor matches ..-1 run data modify storage rhythm_axe:df rows.s2m set value "{\"text\":\"[--]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"已是最小间隔 0（每刻一颗）\"}}"
data modify storage rhythm_axe:df rows.s1m set value "{\"text\":\"[-]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20803\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"间隔 −1 刻\"}}"
execute if score #df_stp editor matches ..-1 run data modify storage rhythm_axe:df rows.s1m set value "{\"text\":\"[-]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"已是最小间隔 0（每刻一颗）\"}}"
data modify storage rhythm_axe:df rows.s1p set value "{\"text\":\"[+]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20804\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"间隔 +1 刻\"}}"
data modify storage rhythm_axe:df rows.s2p set value "{\"text\":\"[++]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20805\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"间隔 +半拍（tpb ÷ 2）\"}}"
data modify storage rhythm_axe:df rows.s3p set value "{\"text\":\"[+++]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20806\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"间隔 +一拍（当前 tpb）\"}}"
execute if score #df_stp editor matches 9999.. run data modify storage rhythm_axe:df rows.s1p set value "{\"text\":\"[+]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"已是最大间隔 9999 刻\"}}"
execute if score #df_stp editor matches 9999.. run data modify storage rhythm_axe:df rows.s2p set value "{\"text\":\"[++]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"已是最大间隔 9999 刻\"}}"
execute if score #df_stp editor matches 9999.. run data modify storage rhythm_axe:df rows.s3p set value "{\"text\":\"[+++]\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"已是最大间隔 9999 刻\"}}"
data modify storage rhythm_axe:df rows.sq set value "{\"text\":\"【输入数值】\",\"color\":\"yellow\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20807\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"输入间隔：两颗之间空几刻（0~9999；相邻间距 = 间隔 + 1）\"}}"


# ============ 开关 ============
# 行 15 允许一刻内填充多个音符（0 禁止 / 1 允许；颜色=状态，灰也能点）
execute if score #df_dup editor matches 0 run data modify storage rhythm_axe:df rows.dp set value "{\"text\":\"[禁止]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20901\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前：禁止 —— 填充出的新音符各占一刻、互不同刻（一刻挤不下会报「挤不下」并中止）。★ 只管【填充分布】，不影响【执行时间分布】。点击 → 允许\"}}"
execute unless score #df_dup editor matches 0 run data modify storage rhythm_axe:df rows.dp set value "{\"text\":\"[允许]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20901\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前：允许 —— 填充出的新音符可以共处同一刻。★ 只管【填充分布】。点击 → 禁止\"}}"
# 行 16 操作后选中新音符（0 关闭 / 1 开启）
execute if score #df_dsel editor matches 0 run data modify storage rhythm_axe:df rows.ds set value "{\"text\":\"[关闭]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 21001\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前：关闭（填充后选区完全不变，新音符不选中）。点击 → 开启（填充后丢弃原选区，改选「头尾音符 + 新生成」）\"}}"
execute unless score #df_dsel editor matches 0 run data modify storage rhythm_axe:df rows.ds set value "{\"text\":\"[开启]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 21001\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前：开启（填充后丢弃原选区，改选「头尾音符 + 新生成」）。点击 → 关闭（关闭时填充后选区不变）\"}}"

# ============ 「分布：时间」的开关：拆分同一刻内的音符（值 20200 = 行 202 列 0）============
#   启用：同刻音符拆开，各占一个时间格（严格递增）；关闭：同刻算一个整体，分布后仍共处同一刻
#   ★ 只管【执行时间分布】；填充分布不受它影响（填充看的是「允许一刻内填充多个音符」）
execute if score #df_spl editor matches 1 run data modify storage rhythm_axe:df rows.sp set value "{\"text\":\"[启用]\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20200\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前：启用 —— 同一刻有多颗时拆开，各占一个时间格（严格递增）。★ 只管【执行时间分布】，不影响填充分布。点击 → 关闭\"}}"
execute unless score #df_spl editor matches 1 run data modify storage rhythm_axe:df rows.sp set value "{\"text\":\"[关闭]\",\"color\":\"gray\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 20200\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"当前：关闭 —— 同一刻算一个整体（像一整桶羽毛球一起搬），分布后仍共处同一刻。★ 只管【执行时间分布】。点击 → 启用\"}}"

# ============ 执行 ============
# 分布：需要 ≥2 个选中（1 个音符没得分布）；填充：只需 ≥1 个（它当属性模板，起点上已有音符不会被重复生成）
# 两者都要求 起点 < 终点
scoreboard players set #df_okd editor 1
execute if score #df_sel editor matches ..1 run scoreboard players set #df_okd editor 0
execute if score #df_ta editor >= #df_tb editor run scoreboard players set #df_okd editor 0
scoreboard players set #df_okf editor 1
execute if score #df_sel editor matches 0 run scoreboard players set #df_okf editor 0
execute if score #df_ta editor >= #df_tb editor run scoreboard players set #df_okf editor 0
data modify storage rhythm_axe:df rows.rd set value "{\"text\":\"【执行时间分布】\",\"color\":\"green\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 21101\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"只重排选中音符的**判定时间**（按「分布：时间」的插值/幂次/起止；不增删音符，不动位置）\"}}"
data modify storage rhythm_axe:df rows.rs set value "{\"text\":\"【执行空间分布】\",\"color\":\"aqua\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 21104\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"只重排选中音符的**判定位置**（按「分布：空间」的插值/幂次/从到；不增删音符，不动时间）\"}}"
data modify storage rhythm_axe:df rows.rf set value "{\"text\":\"【填充分布】\",\"color\":\"gold\",\"click_event\":{\"action\":\"run_command\",\"command\":\"/trigger editor_click set 21102\"},\"hover_event\":{\"action\":\"show_text\",\"value\":\"在【起点～终点】之间生成新音符（属性继承选区首个音符；两端不生成），然后只对「新音符 + 头尾音符」在起止/从到之间分布 —— 原本选中的其他音符不动\"}}"
# 灰态原因分开写：选中数量不够 / 起点终点不合法（避免「明明选了音符却提示没选中」的困惑）
execute if score #df_sel editor matches ..1 run data modify storage rhythm_axe:df rows.rd set value "{\"text\":\"【执行时间分布】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"不可执行：需要至少 2 个选中音符（分布 = 把选中的音符在起止之间铺开）\"}}"
execute if score #df_sel editor matches 2.. if score #df_ta editor >= #df_tb editor run data modify storage rhythm_axe:df rows.rd set value "{\"text\":\"【执行时间分布】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"不可执行：起点要小于终点（用【使用首尾音符时间】【入点】【出点】或 ± 调好）\"}}"
execute if score #df_sel editor matches ..1 run data modify storage rhythm_axe:df rows.rs set value "{\"text\":\"【执行空间分布】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"不可执行：需要至少 2 个选中音符（分布 = 把选中的音符在从到之间铺开）\"}}"
execute if score #df_sel editor matches 0 run data modify storage rhythm_axe:df rows.rf set value "{\"text\":\"【填充分布】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"不可执行：先在列表里选中至少 1 个音符（它的属性将作为新音符的模板）\"}}"
execute if score #df_sel editor matches 1.. if score #df_ta editor >= #df_tb editor run data modify storage rhythm_axe:df rows.rf set value "{\"text\":\"【填充分布】\",\"color\":\"gray\",\"hover_event\":{\"action\":\"show_text\",\"value\":\"不可执行：起点要小于终点（只选 1 个音符时它以自己为起点，请点【出点】把播放头设为终点）\"}}"

# ── 空间端点数值组件（定点 → 两位小数；★ 不能用 {"nbt":...} 渲染字符串：会连引号一起显示）──
data modify storage rhythm_axe:prop slot set value "av0"
data modify storage rhythm_axe:prop color set value "red"
execute store result storage rhythm_axe:prop fp int 1 run data get storage rhythm_axe:maps.editor editing.df.s_a_fp[0]
function rhythm_axe:editor/menu/note/df/df_fmt_prep with storage rhythm_axe:prop
data modify storage rhythm_axe:prop slot set value "av1"
data modify storage rhythm_axe:prop color set value "green"
execute store result storage rhythm_axe:prop fp int 1 run data get storage rhythm_axe:maps.editor editing.df.s_a_fp[1]
function rhythm_axe:editor/menu/note/df/df_fmt_prep with storage rhythm_axe:prop
data modify storage rhythm_axe:prop slot set value "av2"
data modify storage rhythm_axe:prop color set value "aqua"
execute store result storage rhythm_axe:prop fp int 1 run data get storage rhythm_axe:maps.editor editing.df.s_a_fp[2]
function rhythm_axe:editor/menu/note/df/df_fmt_prep with storage rhythm_axe:prop
data modify storage rhythm_axe:prop slot set value "bv0"
data modify storage rhythm_axe:prop color set value "red"
execute store result storage rhythm_axe:prop fp int 1 run data get storage rhythm_axe:maps.editor editing.df.s_b_fp[0]
function rhythm_axe:editor/menu/note/df/df_fmt_prep with storage rhythm_axe:prop
data modify storage rhythm_axe:prop slot set value "bv1"
data modify storage rhythm_axe:prop color set value "green"
execute store result storage rhythm_axe:prop fp int 1 run data get storage rhythm_axe:maps.editor editing.df.s_b_fp[1]
function rhythm_axe:editor/menu/note/df/df_fmt_prep with storage rhythm_axe:prop
data modify storage rhythm_axe:prop slot set value "bv2"
data modify storage rhythm_axe:prop color set value "aqua"
execute store result storage rhythm_axe:prop fp int 1 run data get storage rhythm_axe:maps.editor editing.df.s_b_fp[2]
function rhythm_axe:editor/menu/note/df/df_fmt_prep with storage rhythm_axe:prop
data remove storage rhythm_axe:prop slot
data remove storage rhythm_axe:prop color
data remove storage rhythm_axe:prop fp
data remove storage rhythm_axe:prop sign
data remove storage rhythm_axe:prop i
data remove storage rhythm_axe:prop pad
data remove storage rhythm_axe:prop f

# ── 输出 18 行 + 清临时键 ──
function rhythm_axe:editor/menu/note/df/df_rows with storage rhythm_axe:df rows
# 行 12 / 13 二选一：用不到的那一行**整个不输出**（不是空行）⇒ 后面的行会上移
execute if score #df_mode editor matches 0 run function rhythm_axe:editor/menu/note/df/df_row_cnt with storage rhythm_axe:df rows
execute unless score #df_mode editor matches 0 run function rhythm_axe:editor/menu/note/df/df_row_stp with storage rhythm_axe:df rows
function rhythm_axe:editor/menu/note/df/df_rows2 with storage rhythm_axe:df rows
data remove storage rhythm_axe:df rows
