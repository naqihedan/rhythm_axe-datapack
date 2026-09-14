# AI常见问题

# 命令方面

- 宏命开头令不写$或者非宏命令开头却写$
- 把代码注释写在同一行
- data命令语法错误
- execute if/unless data 命令语法错误
- 用计分板不在load函数里注册
- 用const计分板新数字常量不在load里注册
- 使用截图功能识别游戏内容图像（AI的识图模型烂的要死不如不用）
- **`data modify … set from <来源路径不存在>` 会「失败并保留旧值」，不会清零**：凡是「先 `set from` 再拿来用」的宏通道值都要防这一手。典型后果（2026-09-13 修复）：事件点 `commands` 为空数组时 `cur_cmd` 沿用上一条/上一局命令，`execute` 的 `if data cur_cmd` 成立 → 宏 `$(cur_cmd)` 执行了残留命令，表现为「跑第二张图时冒出第一张图的事件」。解法：要么先 `data remove` 掉旧值，要么把执行条件写成「来源下标确实存在」（`if data … events[$(ev_idx)].commands[$(cmd_idx)]`）。同一坑在编辑器侧（`editor/visual/event_go_`）早已用 `data remove cur_cmd` 规避——两处要对齐。
- **「刷新残留值」与「使用残留值」的守卫必须对称**（上一条的推广）：`store result score #x …` 失败时 `#x` 保留旧值，如果**刷新时**守卫是 `if data 来源字段`、而**使用时**守卫是 `if score #x = <期望值>`，两者就不是同一个条件 → 来源缺失时仍可能用残留值走到「使用」分支。凡这类 `#x`（`#birth`、`#ev_time`、`#tp_time` 等）都要么①每次使用前先置**哨兵值**（如 `scoreboard players set #birth play_state 2147483647`，`note/spawn` 就是这么做），要么②把使用守卫改写成与来源同源的「存在性」判断（`event/execute` 改成 `if data … commands[cmd_idx]`）。

# 编辑器按钮（trigger）方面

> 完整规范（触发链 / 编号规则 spec v2 / 号段分配总表 / 新增按钮 checklist）见 `编辑器.md` 的《trigger值》一节。以下是高频踩坑：

- **新增按钮值不查重** → 与其它面板撞号，同一个值双触发（曾因 `842~855` 撞面板 13 的 `830~851`）。加值前必须 grep 发射点（`editor_click set`）与处理点（`matches`，注意范围会被"吞"）。
- **加了按钮却忘了同步白名单守卫** → `panelN.mcfunction` 顶部两行 `unless ... matches <号段>`，漏加就提示"该按钮不属于当前面板"、点了没反应。
- **动态列表行用了绝对行号** → 必须用页内相对值，页码存 `notes_page`/`sel_page`，处理器还原 `页号×每页数 + 页内序`。
- **旧范围迁移后仍写一条大范围** → 跨多个新行的范围（如 `768..781`）必须按连续段拆成多条 `execute`。
- **只查 `editor_click set` 就断言“改全了”** → 按钮值还有**三种**隐藏写法：①宏参数注入（`data modify storage rhythm_axe:prop <key> set value N` + 宏内 `editor_click set $(<key>)`，如位置三轴的 `bxm..bzp2`）；②宏拼接（`set 1128$(index)`）；③**计算型**（列表行按钮由记分板运算算出：`scoreboard players set #temp_cursor editor 600` + `*= 100` + `add 1600`，文件里**根本没有** `editor_click set <数字>`）。漏改的后果是守卫生效、按钮发旧号 ⇒ 点了提示“该按钮不属于当前面板”。全局审计：`python scripts\audit_injected_trigger_values.py` + `python scripts\scan_legacy_button_values.py`（后者专抓 ③）。
- **忘更新文档**：改完 trigger 值要同步 `编辑器.md` 对应面板的表，否则下次照旧表加号必撞。
- **点按钮后「世界里的音符消失 / 列表按钮少一截」，但数据是对的** → 十有八九是**同一条命令链超上限被截断**（日志搜 `Command execution stopped due to limit`）。上限 `maxCommandChainLength`（`gamerule max_command_sequence_length`，写死在 `data/rhythm_axe/function/load.mcfunction`）**2026-09-12 已由 200000 提高到 1000000**——那时谱面涨到 ~580 音符，`refresh`（整表重建视觉）和列表渲染**各自**就接近 20 万条命令，「操作 + refresh + 面板渲染」同刻必然被截断，属于正常操作踩坑，不再当异常。
- **宏函数「少一个宏参」= 整个函数静默不执行**：`#arg:a,b` 而调用方只写了 `prop.a`（`b` 在计分板里）→ 调用方会失败，连函数第一行 `scoreboard players set ...` 都不跑，表现是「点了没反应、日志里什么都没有」。教训：**能被宏参数化的才放宏参，已经在计分板/数组里的就直接用计分板读**（`editor/util/op_announce` 原来把音符数当宏参，改成读 `#op_count` 就正常了）。
- **>50 音符的重操作要「先提示、后干活」**：入口拆成 `<操作>`（前置：提示 + 分刻）/ `<操作>_go`（干活）/ `<操作>_next`（跨刻切回玩家上下文）三件套，提示用 `editor/util/op_announce with storage rhythm_axe:prop`（写 `prop.op_label` + 计分板 `#op_count`）。原因见上一条：同刻的 `tellraw` 玩家看不到。
- **别在玩家正在游玩时做破坏性 bridge 测试**：模拟点击前先确认 `selection` / `current_panel`；像 `trigger editor_click set 8`（撤销）会**真的**回退玩家历史一步（实测把游标 49 退到 48）。优先选无副作用路径：直接调目标函数、或用「空选中」的守卫分支来验证。
- **「重活 + 渲染」分刻清单（2026-09-12 起，改了别再合回去）**：
  · 已分刻：`主菜单`(menu/main_next)、`返回当前面板`(menu/resume_next)、`事件列表`(event_list_open_next)、`时间点列表`(timing_list_open_next)、
    `翻转时间`/`翻转镜像`/`旋转`（各自的 `_finish_next`/`_return_next`）、`音符设置确认`、`批量确认`、`批量删除`、`行内粘贴`、
    `create_new`/`finish_open`（新建/打开收尾）、`map_panel_save`、`cycle_note_speed`、`jump_start`、`panel1` 行106 流速。
  · 未分刻（故意）：`editor/tool/note_offset_go` —— 它 `refresh` 是单独一条链（实测不超限）、渲染的是单音符面板 O(1)，没有截断风险。
  · 规则：主操作（含 `refresh`）→ `schedule ..._finish_next 1t`（收尾/反馈）→ `schedule ..._return_next 1t`（面板或列表渲染）；
    `_next` 包装必须 `execute as @a[tag=editor_active]`（`schedule` 执行者是服务端、没有 `@s`），跨刻参数走计分板/storage。
- **命令链上限**：`gamerule max_command_sequence_length` 已由 200000 提到 **1000000**（`load.mcfunction`）。提高后正常操作不会再撞线，
  这条上限从此只当**失控递归的报警线**；但「重活 + 渲染」仍不要同刻（同刻会卡顿，谱面再翻倍还会重现）。重活（整表 `refresh` 重建视觉、逐音符 `find_by_id`、列表渲染）不要和操作本身挤在同一 tick：把后续渲染 `schedule ... 1t`（`_next` 包装里必须 `execute as @a[tag=editor_active]`），或分刻处理。实例：`翻转时间`(11501) 曾因此把 `refresh` 的重建砍掉 → 音符在世界上消失、但 `notes[].time` 翻转正确。
- **「顺序游标」型扫描/应用必须带兜底**：`selection` 的顺序是「按 notes 下标递增」时才成立（`sel_rebuild` 保证），但一旦乱序（历史数据、残留状态、上一步移过位置），顺序游标就会**静默漏掉音符**。所有这类叶子（`flip_scan_leaf` / `flip_apply_leaf` / `flip_pos_*` / `rotate_*` / `flip_start_*`）都要写「未命中 → `index` 置 0 再全扫一次」。漏掉的下场：min/max 只剩部分音符（`min == max` 时对称轴直接跑到 max，音符被翻到 `2·max−old` 飞出去）。
- **重操作入口要清残留 prop + 空选中提前返回**：`#flip_total` / `prop.note_id` 这类「上一轮留下的值」会让后续扫描“找到”旧音符（`store result` 失败时分数/字段保留旧值，不会清零）。写法：入口先 `execute unless data storage rhythm_axe:maps.editor selection[0] run return fail`，再 `data remove` 掉 `note_id/found_index/index/insert_index/flip_cursor` 等。

# 性能方面

> 2026-09-14 一批优化（用户报告「快进快退/中段放音符越来越卡」）留下的经验。**核心结论：这个数据包的瓶颈从来不是「算法」，而是「MC 命令本身有多贵」。**

- **宏函数（`$` 行）是性能第一杀手**：`function f with storage` **每次调用都要展开并编译 f 里所有 `$` 行**——**与是否执行到无关**（提前 `return` 省不掉）。所以「每元素/每实体调用一次的宏叶子」成本 ∝ `$` 行数 × 调用次数。
  - 反例：`spawn_one_` 曾用 9 行宏逐个 `data get … notes[$(i)].xxx`，976 音符 = 8784 行宏展开。
  - **正解**：只留 **1 行宏**把整个元素复制进临时键，其余全部用非宏 `data get storage rhythm_axe:prop <tmp>.xxx`：
    `$data modify storage rhythm_axe:prop note set from storage rhythm_axe:maps.editor history[$(cursor)].notes[$(note_idx)]`
    ⚠️ 需要「存在性探测」的场合必须**先 `data remove` 临时键**再复制，否则复制失败会残留上一轮旧值 → 误判（见 `guide_find_next_leaf` 头部注释）。
- **`data get storage X <列表路径>`（不带下标）= 把整个列表序列化成文本**：`execute store result … run data get storage … notes` 也一样（store 只改结果，不改反馈生成）。
  - 反例：`sel_rebuild_len` 用 `data get … notes` 取**长度** → 每次 `refresh` 白序列化 976 音符 ≈260KB，删掉后 `refresh` 直接从 0.46s 掉到 0.15s。
  - **正解**：用「逐元素存在性探测」当循环终止条件：`$execute store success score #has editor run data get … notes[$(i)].id`（见 `menu/note/selected/sel_rebuild_probe`）。
  - **仍待修**（不在 `refresh` 路径，但「保存 / 取消全选」时会卡）：`editor/file/save_strip_selected`、`editor/menu/note/selected/sel_clear_all`。
- **纯宏递归链会「幽灵重跑」**：`spawn_note_` → `spawn_one_` → `spawn_next_` 三个宏函数互相调用时，实测下标会多走 **1.47 倍**（从 100 起走到 1384，正常应止于 976）——既慢，又让遍历结束时记录的下标失真。
  - **正解**：一律「**普通驱动器 + 宏叶子单步**」——驱动器（普通函数，可安全自递归）负责取下标/推进/判断结束，宏叶子只处理当前一个元素。参考 `visual/spawn_drive`、`menu/note/selected/sel_rebuild_drive`、`visual/guide_state_find_drive`。
- **别在「每元素循环」里放 `@e[...]` 选择器**：每条 `@e[tag=editor_n_$(nid),…]` 都要遍历全世界实体。若对同一批实体要连做 N 条命令，合并成 1 次 `execute as @e[…] run function …`，函数内全用 `@s`（见 `visual/fill_disp`、`fill_inter`、`place_inter_apply`）。
  ⚠️ **但动手前必须先问清数量级**：当时以为编辑器同时有几百个音符实体，实际**只有几个到几十个存活**（用户提醒）→ 那轮「合并选择器」收益有限，白折腾一轮。**先问「同一时刻有多少个」（存活实体数 / 列表长度 / 调用次数）再动手。**
- **「只遍历窗口内元素」是最大的剩余优化，但有正确性风险**：`refresh` 必须把全部音符过一遍，其中 99% 只是「看一眼发现不用管」。要跳过它们必须提前知道「每个音符会在播放头前方多久出生」（`note_base_life × 16 / note_speed`，**每个音符可自定义**，本谱面就有 `note_base_life: 24`）。猜小 = **漏渲染音符**。要做只能走「编辑时统计上界并缓存」的安全版（代价：编辑后的刷新 +30%）。**2026-09-14 用户决定暂不做。**
- **纯移动播放头的刷新可以跳过选区重建**：`refresh` 末尾的 `sel_rebuild` 只在「音符数组可能变化」时才需要。`playback/seek_fwd`、`seek_back`、`menu/jump/jump_start`、`jump_end_`、`menu/progress/click` 都会先设 `prop.refresh_skip_sel=1b`，refresh 用 `execute unless data storage rhythm_axe:prop refresh_skip_sel` 跳过（末尾统一 `data remove`）。**新增这类「只动播放头」的入口时记得带上这一行。**
- **性能实测口径（bridge）**：① 返回体会带回**函数内每条命令的文本**——大函数（3 万条命令）能到 2.4MB / 0.9s，**那不是真实 mspt**；② 测量值随「当前播放头附近存活音符数」波动（同一份代码实测 0.093 / 0.112 / 0.143 s）→ **只比相对值、取多次最小值；绝对值以玩家 HUD 为准**；③ 服务端上下文里 `@e` 只搜 overworld，要么 `execute as @a[tag=editor_active] at @s run …`，要么 `execute in <维度>`。
- **改完必查**：`scripts\check_all_macros.ps1`（宏）＋ `/reload` 后看日志有没有 `Failed to load function`（注释行漏写 `#` 会被当命令，脚本查不出来）。
- 本轮成绩（供参照）：`refresh` 0.903s → **0.112s**（seek 模式 0.093s）；每音符命令数 ~45 → **~9**；`sel_rebuild` 0.030 → 0.018s。

