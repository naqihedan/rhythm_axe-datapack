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
- **`storage` 的「带点 ID」和路径之间必须有空格**（2026-09-15 修复）：MC 把资源位置里的点号当合法字符**贪婪**吃掉，所以 `data get storage rhythm_axe:maps.$(mapid).notes` 会被解析成「存储 ID = `rhythm_axe:maps.<mapid>.notes`」（一个不存在的存储），而不是「存储 `maps.<mapid>` + 路径 `notes`」；若路径后紧跟 `[`（如 `.notes[$(index)].selected`），则直接是**命令解析失败**（报错 `参数后应有空格分隔，但发现了紧邻的数据`）→ 宏函数**无法实例化**（报错 `无法实例化函数 xxx`）。
  - 正确写法：`data get storage rhythm_axe:maps.$(mapid) notes[$(i)].selected`（ID 与路径之间留空格）；同理 `storage rhythm_axe:maps.editor history[$(i)].notes`。
  - 代价（本次实例）：`save_strip_selected` 的取长度、`save_strip_leaf` 的剔除都这么写 → **保存时「剔除 selected」从来没生效**，还会每次保存刷「无法实例化」错误、把编辑器的 `selected` 原样写进正式谱面。
  - 自查：`grep -rn "\$(mapid)\.[a-z]" data/`、`grep -rn "maps\.editor\.[a-z]" data/`。
- **「变化检测 / 手动改过」的基准必须是一个自己不会变的量**（2026-09-17 锚点踩坑）：判「用户有没有手动挪过锚点」如果拿**当前包围盒中心**当基准，那么**选区一变中心就变**而锚点还停在旧中心 ⇒ 每次换选区都被误判成「用户动过」（实测：选完第一个音符再选第二个就变蓝）。正确做法 = **把「上次自动摆放的位置」记下来**（锚点把 `data.anchor_cx/cy/cz` 存在自己身上），再拿实体当前 Pos 与它比。同类风险：凡 `当前值 != 期望值 ⇒ 判定用户改过` 的写法，先问「期望值自己会不会变」。

- **`if score X obj >= 0`（右侧直接写裸常量）是非法语法 ⇒ 整个函数不加载**（2026-09-21 实测：`editor/judge/protect` 因此**从创建起就没加载过**，症状＝「判定保护完全不生效」——从头到尾把准星放在判定位置上也只判 perfectL）。
  - `if score` 的右侧必须是**带记分项的来源**，或改用 `matches`：`if score #v editor matches 0..`（≥0）、`if score #v editor <= -1 const`（常量挂到 `const` 上）。全库自查：`score \S+ \S+ (>=|<=|>|<) -?[0-9]`（后面没跟 `const` 的就是嫌疑）。
  - ⚠️ **最隐蔽的一点**：`check_all_macros.ps1` 查不出（它只管宏），函数在游戏里表现成「已注册但没加载」——`execute ... run function <id>` **静默无输出**，只有**不带 `execute` 直接 `function <id>`** 才会回「未知的函数 xxx」。
  - 排查：日志 `Failed to load function <id>` + `Whilst parsing command on line N: ... <--[HERE]`（`HERE` 指着那个 `>=`/`<=`）。
  - ⚠️ 桥接 `bridge.ps1 logs -Search "..."` **不可靠**（按「上次读取位置」只返回新行，常给 `lines: []` → 会误判成「0 错误」）→ **直接读 `logs/latest.log`**。
  - **规矩：改完/新增任何 mcfunction，除了宏检查，还要「不带 execute 直接 `function <id>`」验证它真的加载了**。

- **UTF-8 BOM ⇒ 整个文件加载失败（2026-09-26 实测：症状是「一块光标玻璃都看不见」）**：用脚本写文件时若用了 `utf-8-sig`，文件头会多 3 字节 `EF BB BF`；第 1 行的 `#arg:gid` 后面虽然还带 `#`，但**它前面多了个不可见字符** ⇒ 不再是注释，整行被当命令解析。

  | 项 | 内容 |
  | --- | --- |
  | 日志 | `Failed to load function <id>` + `Whilst parsing command on line 1: 未知或不完整的命令 at position 0` |
  | 本次实例 | `editor/tool/cursor_tick`、`editor/tool/glow_note`、`editor/tool/select/select_glow_tick` 三个宏文件一起挂 |
  | 排查 | 读文件头 3 字节是否为 `EF BB BF`（`check_all_macros.ps1` 已加这项检查） |
  | 修复 | 去掉文件头 3 字节，或用编辑器「以 UTF-8（无 BOM）保存」 |

  ⚠️ **最容易漏的一点**：spyglass 不报错、`check_all_macros.ps1` 旧版也照过（它只查宏）⇒ 唯一可靠信号是游戏日志里的 `Failed to load function`。所以**写 `.mcfunction` / `.json` 一律 `encoding='utf-8'`，绝不用 `utf-8-sig`**。

# 判定区域（选择器体积参数）方面

- **`@e[x=,y=,z=,dx=,dy=,dz=]` 里 `d=N` 覆盖的是 N+1 格，不是 N 格**（2026-09-16 用零尺寸 marker 逐点实测）：
  原点 `y=300` + `dy=3` → 覆盖 `[300, 304]`（marker 在 `303.9` 命中、`304.1` 不命中、`299.5` **不**命中 ⇒ 只向上、不向下）；原点 `x=3000` + `dx=1` → 覆盖 `[3000, 3002]`。
  → 写「高 3 格」这类注释/文档时最容易把 `dy` 直接当格数（混凝土判定区域就因此长期写错成「3 高」，实际是向上 4 格）。要么按 `d+1` 换算，要么直接写清覆盖区间。
- **bridge 实测实体选择器前，目标区块必须已加载**：往未加载区块 `summon` 会正常返回「召唤了新的标记」，但选择器**完全找不到**它（`if entity`、`distance=..` 全部失败），表现是「所有测试都是 0」。先 `forceload add <x> <z>`（用完 `forceload remove`），或把测试点放在玩家附近。
- 零尺寸 AABB 的实体（`marker`）是最好用的「点探针」：它能被某个 `d=0` 的盒子选中 ⇒ 那一格被覆盖。扫边界时一个点一条命令即可。
- **音符「展示实体 `Pos` = 判定位置」，视觉位置在 `transformation.translation` —— 别把两者搞混**（2026-09-20）：
  `fill_disp` 把谱面 `position` 写进展示实体的 `Pos`（**恒定不动**，编辑器与游玩一致）；每刻变化的是 `translation`（`place` 计算 + 客户端插值）。
  只有**交互实体**的 `Pos` 每刻被写成"视觉位置"（`place_inter_apply` 跟随缓动头部）。
  ⇒ 「判定位置」在世界上**有实体代表**（就是展示实体）：判定保护的射线步进（`raycast_step` 的 `distance=..1.0`）与游玩的 `looked_at_perfect` 都用它，
    不需要额外 marker；反过来，要"音符当前视觉位置"必须读 `translation`，读展示实体 `Pos` 只会拿到判定位置。
- **展示实体的 `Pos` 必须落在玩家附近（2026-09-21 引导线踩坑）**：客户端只更新**已追踪**的实体，追踪范围看的是实体自己的 `Pos`，**区块强加载对此无效**。
  所以「把世界坐标全塞进 `transformation.translation`、`Pos` 留在 `(0,0,0)`」的做法，谱面一旦远离世界原点，表现就是**引导线不跟随/停在旧位置/看不见**。
  - 正解：`Pos` 锚在实体自己的一端（引导线 = A 端判定位置），`translation` 只存**相对锚点**的偏移；锚点由 `utilization/guide_anchor_set` 读回真实 `Pos` 存实体计分板，每刻减掉。
  - 顺带好处：`summon` 到目标坐标（而不是原点）也能避开「往未加载区块 summon 后选择器找不到实体」。
  - 同类对照：音符展示实体早就是「`Pos` = 判定位置 + `translation` = 相对偏移」，只有引导线漏了这层。

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
- **聊天栏里的「旧按钮」永远可点**：`clear_lines` 只是推 10 行空行（滚动），被推上去的旧面板行仍在聊天栏里，其 `click_event` 依然有效。所以「面板重绘之后点到上一块面板的按钮」是**正常可达状态**，每个 handler 都必须**按状态自守**（`unless data … editing.batch`、`unless data … editing.orig_index`），**不能只靠「面板上没画这个按钮」**。
  - 2026-09-16 实例（用户报「批量编辑面板的确认按钮点了可能会删单个音符」）：单音符【确认】`note_panel_confirm` 是「按 `editing.orig_index` 把那个元素 remove 掉、再用 `editing.temp` 重插」，而 `batch_open` **不整块重建 `editing`**，单音符会话残留的 `orig_index` 会带进批量会话；一旦在批量面板里点到 **13703/13704/13705**（批量面板并不渲染它们，只能来自旧行/残留状态）就会顺着单音符删除链拿残留的 `editing.temp.id` / `prop.index` 去动**别的**音符。
  - 修法（三件套，缺一不可）：① `panel11` 把 13703/13704/13705（以及 13701/13702 兜底）全部加 `unless data … editing.batch`；② `note_panel_confirm` / `note_panel_delete` 开头**前置守卫**（缺 `editing.orig_index` / `editing.temp.id` 就红字提示 + `return fail`，一条数据都不动、不落快照）；③ `note_panel_confirm_` 摘除前做**身份校验**（`notes[index].id` == `editing.temp.id`，两个 id 先置 `-1` 哨兵，读取失败也算不一致）→ 数组被改过（order_repair/粘贴/翻转/撤销）导致下标失效时不会误删。
  - 通用教训：**凡「按下标 remove 再重插」的写法，下标和内容都要校验**（下标会因先前的任何数组改动而失效）；**凡「按会话字段改数据」的 handler，都先校验会话字段齐全**。
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
- **给宏函数加宏参必须同步 `#arg:` 行**：`scripts\check_all_macros.ps1` 会报 `undeclared macro var $(xxx)`。2026-09-20 给 `editor/visual/trigger_` 加 `$(case)`（音符事件情况键）时改了注释里的「宏参数：…」却漏了 `#arg:` → 5 处 ERR（脚本按 `#arg:` 判定声明）。
- **等级/情况这类「一次性消费」变量要防覆盖**：`visual/trigger` 开头会读 `#ed_level` 并**立刻 reset**（因为 type=4 的 `return fail` 会提前结束函数，不清就会残留污染下一次触发）⇒ 调用方若在 trigger **之后**还要用这个值（判定的文字反馈就是），必须**先另存一份**（`editor/judge/hit` 存 `#ed_disp`、`feedback_text` 读它），否则会读到空值、误显示最低等级。

# 音符出生顺序（渲染时序）方面

- **`notes` 按 `time` 升序 ≠ 出生刻升序**（2026-09-21 修）：`birth = time − note_base_life×16/note_speed`，而 `note_base_life` 每个音符可自定义（本谱面就有 12/16/17/20/24/30/32/42/48 九种）⇒ 同一个升序数组里 `birth` 出现 **33 处倒挂**。
  - 后果（只靠「队首未出生就停」的出生游标 `#vis_next` / `tick_birth_*` 时必踩）：排在后面、前导更长的音符被压到「挡路音符的出生刻」才生成 ⇒ **音符只剩后半程才出现、一出现就已经走过一半**；而**快进快退「逐刻看」却是好的**（它们走 `refresh` 全表重建，不看顺序）。实测 `lament_rain`：1424 音符里 **61 个**被延迟 1~24 刻。
  - 通用教训：凡「按数组顺序推进 + 拿派生量当推进条件」的游标，先问**这个派生量单调吗**。同族已知坑：数组 `time` 乱序（用 `order_repair` 修）、游玩侧 `_birth` 倒挂（`start_of_game` 的桶排序就是为此）。
  - 修法：`visual/scan_due{,_drive,_leaf}` 每刻从游标之后补扫「本刻恰好出生」的音符；两条路都只认 `birth == playhead` **精确一刻** ⇒ 每个音符只生成一次（若沿用 `>=` 会把补扫已生成的音符**重复召唤**、重置判定状态）。扫描窗口上界 = `refresh` 统计的 `vis_lead_max`。
  - 验证口径：`refresh` 后把播放头移到某音符出生刻前一格、播放，看它是否在出生刻就出现在**起始位置**（进度 0），而不是半路冒出来；也可直接读实体 `editor_n_birth` 与出生时刻。

# 多人方面

> ⏸ **《多人判定延迟补偿》已于 2026-09-26 搁置/回退**（结论与后续思路见 [todo.md](todo.md)）：实测「没什么用、手感更差」——RTT 只 ~1 刻而感知滞后是「几刻」，且按 RTT 补的量会在 1↔2 刻之间飘（恒定偏差能适应、飘的不能）。下面相关条目保留作记录。

- **判定是「服务端」做的 ⇒ 客机看到的音符与服务端当前音符差约一整个 RTT（2026-09-26 修）**：
  `looking_at` 是服务端射线 —— 拿「服务端收到的玩家朝向」打「服务端**当前刻**的判定箱位置」；
  而客机玩家眼睛看到的音符还要晚一个单程延迟（画面传过去的时间），他移动准星又是单程延迟之前发出的
  ⇒ 两者差约一个 RTT。判定箱在世界上只有**一个**（所有玩家共用）⇒ 补偿前只对齐了房主。
  - 症状：客机「**有的音符没到判定线就判定 / 有的到了判定线准星对准了也不判定**」，房主完全正常；RTT 只有 30ms 也会犯
    —— 误差是**角度**上的：音符越贴近判定位置、离眼睛越近，同样的刻数差对应越大的角度差
    （远：角度差小 ⇒ 十字线同时罩住两边 ⇒ 提前判；近：十几度、比音符还宽 ⇒ 对准了也不判）。
  - 修法：mod 每 20 刻把各玩家 RTT 写进计分板 `net` → 数据包 `st_player` 换算 `#st_lag = (RTT+30)/50` 整数除（20ms 起 1 刻，≤4）
    → `st_probe` 用 `judgement/st_lag_apply` 先回退判定箱再测视线。**线性音符**（`anim_power=1`）走
    `st_lag_apply_lin`（`move_self` 进度 `t` 再减 `#st_lag`，闭式、精确）；**非线性音符**（`anim_power≠1`）
    没有闭式反解（缓动是 `display_animation` 逐帧驱动），走 `st_lag_apply_nl` 取**位置历史环**
    `note_vis<L>`（由 `active_note/vis_ring_next` 挂在交互实体上每刻维护，只维护非线性音符盒/木板）。
    见 [音符→多人判定延迟补偿](音符.md#多人判定延迟补偿)。
  - ⚠ **「判定保护」（射线步进检测判定位置）是固定点检测，本来就不受延迟影响** ⇒
    「一直把准星压在判定区域」在客机上反而更稳。用它做对照实验可快速确认是不是这个原因。
- **回退过的判定箱必须「每个玩家退场前」还原**：`@a` 的遍历顺序是任意的，只在整段末尾还原的话，
  `#st_lag=0` 的房主若排在客机后面，就会拿客机回退过的位置去测。还原写在 `st_player` 末尾（见该文件注释）。
- **修复新类型的 `note_*` 计分板要同步两处**：`load.mcfunction` 注册 + `utilization/clear_note_scores` 加一行 `reset *`
  （实体 `kill` 不会自动清计分项，漏了会永久堆积）。例如位置历史环的 `note_vis0..4_*` / `note_vis_ok` 共 16 项。
- **判定箱位置相关的坑**：`st_probe` 里 `distance=..4.5` 量的是 **`at @s` 调用时捕获的执行位置**，
  不会因为之后改写实体 `Pos` 而更新；`st_mark` 是重新 `at @s`（量在回退后的位置上）⇒ 两处放宽值不同是有意为之。
- **未初始化的计分项会被当成 0 = 世界原点**：位置历史环必须“首次写入时把 5 个槽全填成当前位置”
  （`note_vis_ok` 标志），否则短飞行音符会把判定箱摆到世界原点。
- **补偿「感觉没用」先体检，别急着调数值**（2026-09-26）：两项前提缺任一项就会**静默**失效 ——
  ① `net`（每人 RTT）只有**房主那台机器**上的 `rhythm_axe_mod` 会写；② 补偿代码在**房主存档的数据包**里
  （加入别人的房间跑的是对方的旧数据包 ⇒ 连代码都没有）。此时 `#st_rtt` 走哨兵 `-100` → 钳成 0 ⇒
  行为与补偿前完全一致，**无报错、无日志**，看日志根本查不出来。
  - 体检：`/function rhythm_axe:test/lag_report`（逐玩家 `net` / 手动值 / 实际回退刻数；`net=-1` = 无人写入）。
  - 现场调参：`/scoreboard players set <玩家> lag_rtt_manual <毫秒>`（`0` = 不补偿；想固定 N 刻填 `50N-30`）。
- **编辑器侧的判定没有补偿是「有意保留」的**（2026-09-26 用户确认）：`editor/judge/*` 用同一套 `looking_at` 测视线，但不读 `net`、不回退位置 ——
  用户拿它当**对照组**（与游玩侧对比看补偿的净效果）。**别顺手给它加补偿**；要加先问用户（那等于毁掉他的基线）。

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
- **「只遍历窗口内元素」是最大的剩余优化，但有正确性风险**：`refresh` 必须把全部音符过一遍，其中 99% 只是「看一眼发现不用管」。要跳过它们必须提前知道「每个音符会在播放头前方多久出生」（`note_base_life × 16 / note_speed`，**每个音符可自定义**，本谱面就有 `note_base_life: 24`）。猜小 = **漏渲染音符**。要做只能走「编辑时统计上界并缓存」的安全版（代价：编辑后的刷新 +30%）。**2026-09-14 用户决定暂不做。**（2026-09-21 新增的 `vis_lead_max` 就是这里说的「编辑时统计上界并缓存」，代价只有每音符 3 条普通命令；但**目前只喂给播放中的补扫窗口**（见《音符出生顺序》一节），`refresh` 本身仍未跳过任何音符。）
- **纯移动播放头的刷新可以跳过选区重建**：`refresh` 末尾的 `sel_rebuild` 只在「音符数组可能变化」时才需要。`playback/seek_fwd`、`seek_back`、`menu/jump/jump_start`、`jump_end_`、`menu/progress/click` 都会先设 `prop.refresh_skip_sel=1b`，refresh 用 `execute unless data storage rhythm_axe:prop refresh_skip_sel` 跳过（末尾统一 `data remove`）。**新增这类「只动播放头」的入口时记得带上这一行。**
- **性能实测口径（bridge）**：① 返回体会带回**函数内每条命令的文本**——大函数（3 万条命令）能到 2.4MB / 0.9s，**那不是真实 mspt**；② 测量值随「当前播放头附近存活音符数」波动（同一份代码实测 0.093 / 0.112 / 0.143 s）→ **只比相对值、取多次最小值；绝对值以玩家 HUD 为准**；③ 服务端上下文里 `@e` 只搜 overworld，要么 `execute as @a[tag=editor_active] at @s run …`，要么 `execute in <维度>`。
- **改完必查**：`scripts\check_all_macros.ps1`（宏语法 + BOM 编码）＋ `/reload` 后看日志有没有 `Failed to load function`（注释行漏写 `#` 会被当命令，这类脚本查不出来）。
- **`kill` 不会清计分板项 → 残留会拖垮全局（2026-09-20 实测的重大事故）**：
  - 计分板项是**按「名字」（实体 UUID 字符串）持久存在**的，实体被 `kill` 后项**不会**自动消失，只能 `scoreboard players reset` 清掉。
  - 编辑器音符实体的 24 个 `editor_n_*`（birth/time/dist/…/px/py/pz/vx…/sx…）此前**没有任何地方清**；而「kill 全部 + 重建」路径极多：`visual/refresh`（每次编辑）、`exit_do`（退出）、`visual/tick_kill`（**播放时每个音符经过都 kill 一次**）、`summon_` 的 `$kill`（清幽灵副本）。
  - 后果：该存档堆到 **1 333 190 项 / `scoreboard.dat` 6.75MB / 解压后 104MB**。世界保存（自动保存每 6000 刻，约 5 分钟）要把整份分数板序列化 → **位置不固定、每几分钟一次、不玩谱面也卡的 MSPT 尖峰**（用户实测 max 752ms，日志里还有 2~6 秒的 `Can't keep up!`）。
  - 排查口径：`saves/<存档>/data/minecraft/scoreboard.dat` 体积（正常应 < 1MB；> 数 MB 即有残留）＋ `script` 里 `scoreboard players reset *` 对照 objective 清单。日记 `[Server thread/INFO]: Saving and pausing game...` 的时间点与 `scoreboard.dat` 的 `LastWriteTime` 对得上，即可确认是保存卡。
  - **正解**：① 每个 `kill <编辑器音符实体>` 前先 `execute as @e[tag=…] run function rhythm_axe:editor/visual/note_scores_reset_`（`@s` 版清 24 项）；② `utilization/clear_note_scores` 里补 `scoreboard players reset * editor_n_*` 一次性清历史残留（`/reload` 即生效）；③ **新增 `editor_n_*` objective 时这三处（kill 前清、reset 文件、clear_note_scores）必须同步。**
  - 同类隐患自查：任何「实体 UUID 上挂计分板 + 会 kill/重建」的系统（游玩侧 `note_*` / `note_c_*` / `note_g_*` 已在 `clear_note_scores` 覆盖）都要走同一套。
- 本轮成绩（供参照）：`refresh` 0.903s → **0.112s**（seek 模式 0.093s）；每音符命令数 ~45 → **~9**；`sel_rebuild` 0.030 → 0.018s。

