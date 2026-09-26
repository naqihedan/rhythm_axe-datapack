# 待做清单

> 动态清零，用于快速记录想法

## ⏸ 多人判定延迟补偿（**已搁置 2026-09-26，待重新评估**）

- **做了什么**：mod 每 20 刻把每人 RTT 写进计分板 `net`；数据包 `play/judgement/st_player` 换算 `#st_lag = (RTT+30)/50`（clamp 0..4），`st_probe` 按玩家把判定箱回退到「他眼睛看到的位置」再测视线（线性音符闭式回退 / 非线性取位置历史环 `note_vis*`）。工具：`test/lag_report` 体检、`lag_rtt_manual` 手动固定值、`judge_lag_comp` 总开关。
- **为什么搁置**（用户实测 2026-09-26）：
  1. **主观结论：没什么用，手感还更差**。
  2. **对照实验（编辑器 = 无补偿）**：能明显感到滞后「**稳定晚几刻**」且可适应；真正游玩（有补偿）「摸不着确切感觉」。⇒ 关键在于补偿量**恒定还是飘**：恒定偏差能适应、飘的不行。
  3. **量纲不对**：RTT 只 20~50ms（≈0.4~1 刻），而感知滞后是「几刻」量级 ⇒ **大头不是 ping**，而是与 ping 无关的**稳定**成分（客户端渲染/插值节奏）。而按 RTT 补的量还在 1↔2 刻之间跳（keep-alive 抖动 × 整刻量化）。
- **回退方式（已做）**：mod 侧删 `PlayerPingSync` + 撤销注册（不再写 `net` ⇒ 数据包补偿自动恒为 0）；`judge_lag_comp` 默认改 0（`load` 每回 reload 写 0）。
- **代码现状（重要）**：数据包的补偿代码**仍留在原位**（未删，只停用），清单：
  - `play/judgement/st_player`/`st_probe`/`st_mark` 里带「★ 2026-09-26 判定延迟补偿」注释的行；`st_lag_apply{,_lin,_nl}`、`st_lag_restore`；
  - `play/active_note/move_self` 的 `#lag_extra` 减法；`move_write_pair` 的位置环维护 + `vis_ring_next`；
  - `load.mcfunction` 的 `net` / `lag_rtt_manual` / 16 个 `note_vis*` objective；`tick.mcfunction` 的 `enable @a lag_rtt_manual`；`utilization/clear_note_scores` 的 `note_vis*` 清理；`test/lag_report{,_one}`；只作为对照的调制函数 `lag_rtt_manual`。
  - 删除它们要做一遍判定回归测试（改动落在判定热路径）；不删也**完全无害**（补偿恒 0）。
- **若将来重做，优先换思路**：目标应是**恒定偏移**（对所有人生效、不随 RTT 飘），候选杠杆 = `play/active_note/move_self` 里那个固定的 `-= 1` 刻（“对齐客户端渲染延迟”用的常数）——拿它按手感标定即可（单机/房主同样能感受到差异）；先用 `lag_rtt_manual`（per-player 常量）扫 `70/120`（2/3 刻）确认量级。

- [x] 编辑器试听「真实判定模式」（**阶段 1 完成 2026-09-20**）
  - 开关：`options.editor_note_judge`（默认 **1 开**）+ 主菜单行 105【判定：开/关】（`10502`，与节拍器同行）
  - 阶段 1 覆盖普通音符 0/1/2，**照搬游玩语义**：0 音符盒 / 1 木板 = 视线命中（同一 `predicate rhythm_axe:looking_at`）；2 唱片机 = 左/右键点击
  - 窗口/等级与游玩**同一套边界**（x = 当前时间点 `judgement_scale`）；命中按等级播音符事件 + actionbar/聊天栏文字，超窗 miss（**木板静默清除**）
  - **不计成绩与连击**（不碰 play_state 的 perfect/combo/highest_score）；`hit_events` 情况键随实际等级
  - 边界：暂停不判定；**seek/快进快退保持旧行为**（自动 perfect + 橙光）；播放中切换立即重建；播放中左/右键转为判定输入
  - 代码：`editor/judge/`（note_check / look_check / input_click+click_probe / level / hit+window_out / feedback_text / scale_sync / window_extend）；详见 编辑器.md《真实判定模式》
- [x] 编辑器真实判定 **阶段 2 - 混凝土**（2026-09-21 完成，`editor/judge/concrete_check`）——顺带把**游玩侧**的 `note_c_zone` / `note_c_zone_near` marker 也去掉：判定区域直接用混凝土展示实体自身（`Pos` 恒 = 判定位置、`Rotation[0]` = 运动方向、`Rotation[1]` = pitch，检测前 `rotated ~ 0` 归零），远近只留一个 `note_c_far` 标记；改 `play/note/summon` + `play/judgement/main_concrete` + clear_note/judge 清理
- [ ] 编辑器真实判定 **阶段 2 - 染色玻璃**（待做）：玩家判定箱 × 玻璃位置相交，不扣血，播 `damage` 组反馈
- [x] 编辑器真实判定：**判定保护**（0 音符盒 / 1 木板）已搬（2026-09-20）——编辑器展示实体 `Pos` 恒 = 判定位置，可直接复用游玩 raycast 机制（每 0.5 格采样、`distance=..1.0`）；玩家 tag `editor_active`、实体 tag `editor_note`，`editor_n_looked_perfect` 直接打展示实体（省掉游玩那层配对）。代码：`editor/judge/raycast*` + `protect`；由 `visual/tick` 每刻先清后打

- [x] 批量编辑-「镜像按钮组」（2026-09-07 已实现，与【时间轴翻转】同在一行：活跃列表/已选定列表底部**第二行/最后一行**）
  - X / Y / Z 轴镜像（单击 910/914/915）：先找到一个能把**所选音符**都完美框起来的长方体，取长方体**中心点**；按点击的轴，让音符的**判定位置 position** 变成关于该中心点对应轴镜像的位置（new = min+max−old = 2×center−old）。仅改 position，按 time 升序数组不变，可撤销。
  - 【同时翻转起始位置】（单击 916）：让选中音符 **start_pos** 绕其**判定位置**做 XYZ 轴镜像（start_pos.axis = −start_pos.axis）。可撤销。
  - 采用**开关+执行**模型：点击 910/914/915/916 仅切换 [X]/[Y]/[Z]/[S] 开关状态（绿色=开、灰色=关，不立即翻转）；点击【翻转】917 才按已开启的开关执行镜像（X/Y/Z 对 position 绕包围盒中心镜像，S 对已开启轴的 start_pos 取反）。可撤销。左侧【时间轴翻转】(909) 仍为**即时操作**。

- [x] 音符间引导线，类似osu（M2 完成 2026-08-14：0/1/2 音符 following_point=true 时连到上一个 0/1/2，青色细线连接两音符视觉中心，两端任一音符消失即消失）
- [ ] 谱面格式校验（文档：见谱面格式校验.md；**雏形已实现 2026-09-13**：`play/map_check`，只警告不阻止，覆盖 `end_time`/`timing_points`/空 `notes`/`teleport` 缺 `spawn_x/y/z` 四项；**完整校验待做**——逐音符/逐时间轴规则需遍历，规划用分刻或离线脚本）
        告诉玩家他们的谱面有什么不太恰当的配置（warning），有什么东西让谱面连最基本的运行都没法做到（error）。至于配置能不能打，它不管。
- [ ] 可视化设置界面
- [ ] 旁观者模式，有不参与谱面游玩，游戏模式为旁观等特性...
- [ ] 音符盒、木板、唱片机被判定时屏幕上斧头挥舞的特效，自定义屏幕覆盖层实现（机制已研究并写入工具组件.md，待实现）

- [ ] 音符盒判定保护设置
  - 开：如音符.md介绍所述判定，但是判定反馈不及时
  - 关：只要视线与音符盒相交就判定，判定反馈更加及时，但是在低密度谱面增加判定难度

- [ ] 唱片机判定保护设置
  - 无保护：判定箱位置不提前，判定时间不变，不仅需要提前打还需要打前一刻的位置
  - 均衡：判定箱位置提前一刻，判定时间不变，依然需要提前打
  - 激进：判定箱位置提前一刻、判定时间延后一刻，不播放判定音效，可以以敲鼠标的声音对齐音乐
  - 所有情况下，最后一刻不击打自动goodL的判定保护一直存在，且展示实体运动情况相同

- [ ] 编辑器音符事件处理方式设置
  - 默认0：不执行
  - 1：安全模式，只在聊天栏输出执行指令内容
  - 2：开，真正执行指令内容

- [x] 音符非线性缓动变速测试，包括使用展示实体动画系统的4个和单独写的混凝土长条（重点）
- 游戏运行代码优化
  - [x] 展示实体动画系统（只计算有变化分量、单一旋转角度走轴角路线）
  - [x] 音轨运动优化（线性运动音符不走动画系统）
  - [ ] **修复桶排序 200000 崩溃（2026-08-09 暂缓：先跳过排序链，测试谱面手动排好序，做编辑器时再修）**
      真根因 = `sort_bucket_put` 的 drain 分支在 `fill` 递归返回后用【被内层 put 改写】的全局 `#sort_i` 判断
      → 每一层 put 都各跑一遍完整 drain（层数 ≈ put层数×range，29×513≈14877）→ `max_command_sequence_length` 200000 截断（设大则卡死）。
        ⚠️ 2026-09-12 更新：上限已由 200000 提到 **1000000**（见 `load.mcfunction`）。但**别因此以为桶排序能一次跑完**——它本身是 O(层数×range)≈1.5 万次 drain 的失控放大，照样必须分刻/切片。
      已临时加 `#sort_fill_done` 一次性标记（init 置 0、首个 put 置 1）保证 drain 只执行一次，**尚未验证**。
      恢复排序链后需：①验证 `#sort_fill_done` 修复有效；②修 fill/put 阶段 `sort_bucket[0]` 重复音符（storage 与全局 `#sort_i` 不同步导致音符重复处理）；
      ③考虑 grow/drain 每层多建/多合并几个桶以降低宏递归层数（当前 513×2 层逼近序列长度上限）。
      ④如果实在压不下命令总数，就把排序分布在多个游戏刻进行

## 里程碑实现规划（M2 系列）

- M2-G 染色玻璃（type 4）：碰撞检测→扣 `health` 计分板（不影响真实血量）；扣血冷却（全局设置）；持续时长语义（寿命 0 后存活 duration 刻）；移动方式（一直运动直到寿命+duration<=0）✅
- M2-H 判定反馈组表（音效/粒子/事件）：hitsound/hit_particles 用“存储表+宏执行”（`$playsound`/`$particle` 按 [组][等级] 查表）；hit_events 按各情况 enabled 过滤后宏执行；把 judgement_feedback 硬编码反馈重构为查表 ✅
- M2-I 事件+音乐：✅ 背景音乐播放（谱面 `music` 字段 → `time==0` 触发 play_music，**mod 的 `/playmusic` 流式播放**、开局 `/preloadmusic` 预热、end_of_game `/stopmusic @a` 停止，自动结束+手动 stop 全覆盖；资源包 sounds.json 已关联 audio.ogg。**2026-09-18 由 playsound 改为 mod 流式播放器**，以便「音乐自动对齐游戏」在正式游玩里也生效 —— 见《游玩谱面.md》音乐播放 / 《工具组件.md》音乐对齐游戏；**2026-09-21 音量改由 mod 自己乘游戏音量设置**（唱片机/音符盒滑块 × 主音量，拖动即时生效——此前直连 OpenAL 绕过了原版音量分类，等于永远满音量；分类取 RECORDS 而非 MUSIC：关「音乐」不该连谱面音乐一起静音））。待办：定义音效组/粒子组数据（spawn/bad/goodE/perfectE/perfect/perfectL/goodL/miss/damage 9 情况；用户暂不填）
- 优化轮：音符缓动整体测试（M2-G 完成后一块测试 anim_easing/anim_power）
- 近距混凝土判定区域偏移：✅ 用户确认保持 dx=2 不改（2026-08-07）

## 里程碑实现规划（编辑器）

- [x] 阶段0：mod 流式音乐播放（2026-08-15 完成：/playmusic /pausemusic /resumemusic /stopmusic；多人网络包；保调重采样变速；tick→ms 换算——正在编辑谱面且有 timing_points 时按时间点分段换算、无则 mspt；/stopsound 联动停音；mod 1.5.0——2026-09-18 起版本号改为编译日期 yy.M.d）
- [x] 阶段1：编辑器框架（2026-08-18 完成：旧 editor/ 归档 editor_old；入口 function rhythm_axe:editor/editor {mapid:"xx"}；单人锁 editor_active（被占用/已进入编辑均有提示）；maps.editor 全字段状态；新建谱面=默认模板 append 工作副本 history（不写 maps.<mapid>，保存才写）；加载已有谱面=history[0] 快照+传送 spawn_pos；退出清理）
- [x] 阶段2：各类操作的入口 function（底层，先于界面，详见下方清单）（2026-08-18 完成：文件类 begin/commit/save/undo/redo+截断与上限裁剪+删除回收站；时间轴控件 play/pause/seek/step 含 playmusic 与 tick rate 联动；音符创建/删除/复制/粘贴；时间点与事件点创建/修改/删除/上一下一跳转）
- [ ] start_of_game 编辑器占用守卫支持多人开局（2026-08-18：当前单人检测已注释，见 start_of_game 顶部注释；需遍历所有参与玩家）
- [ ] 阶段4：聊天栏编辑界面 + 对话框（2026-08-18 用户拍板提前到阶段3前；**进行中**）
  - [x] 主菜单 + 谱面设置 + 时间点/事件/音符列表与面板 + 查找 + 保存/另存/退出（含：面板隔离、feedback 反馈、撤销/重做标签按文档文案（创建/修改/删除时间点、创建/修改/删除事件、创建{种类}/删除{种类}/剪切/粘贴音符）、▶/⏸、返回开头/跳到结尾（跳转后暂停）、bossbar 编辑期间常显、播放调速 tick rate=谱面速度×播放速度（mod 支持 `tick rate <bpm>bpm <tpb> <倍率>`）、播放头逐刻推进、红绿线每次刷新前即时计算（editing.color 键）、时间点/事件/音符列表行复制粘贴删除、时间点列表 █ 颜色行、音符列表按文档格式（时间/类型名/基础寿命/id））
  - [x] 对话框：标题/作者/音乐/预览/谱面id/BPM/结束时间/事件指令（全部带取消按钮）
  - [ ] 查找增强：按属性值查找（**待用户安排推进时间**，需拍板交互方式）
  - [x] 阶段4B 音符面板与二级菜单（2026-08-23 完成）：音符面板全部属性（类型/时间/无视流速/大小/判定位置/起始位置/动画类型/基础寿命/持续/颜色/密度/击打音效/击打视效/击打事件/音符标签）+ 击打事件二级菜单 + 全局击打音效/视效面板
  - [x] 阶段C 聊天栏编辑器优化（阶段4B 期间完成）：
    - [x] 标题显示解析后文本：1.21.5+ 文本组件以 NBT 存储；**26.x 的 nbt interpret:true 不解析**（显示原始 JSON）→ 所有 title 显示处（主菜单/谱面设置/bossbar/开始编辑反馈/游玩结算）统一用**宏传 title 作为组件参数**解析；title 存字符串（内容=JSON 组件，如 {"text":"标题","color":"red"} 或 "新手教程"）；**限制：不能是裸纯文本、不能含空格（宏参数限制）**；editor_title.json 提示已同步
    - [x] 无视流速恢复为正常开关（点击切换，快照互斥分支，启用/禁用两按钮都可点）
    - [x] 击打事件面板重新设计（每指令一行：指令文本/（空指令）+ 编辑/复制/粘贴/删除）+ 修复：①编辑提交改两步方案（click 写 editing.he_cur → 第一步复制到 prop+输入值 → 第二步 with storage prop 写回；template 必须纯 inline，with storage+inline 报"没有与{...}相匹配的元素"）②空指令用 data get 字符串长度判断（26.x 的 .command[0] 对非空字符串不可靠）③粘贴=覆盖点击行（用户语义）④860 const 未注册导致按钮全失效（已注册）⑤$ 行无 $(...) 导致 paste 加载失败（已修+全项目扫描）
  - [x] 阶段4C：谱面id改名（2026-08-23 完成：map_rename 已补 id 字段更新；计分板 objective 均全局无按谱面前缀、highest_score 存 storage 随搬移 → 无需重建计分板；**待用户实测**改名后最高分保留/存储一致）
- [x] mod 音高：重采样升级 8 点 windowed-sinc（保调插值）；**2026-08-23 用户实测无音高变化** ✅
- [x] 阶段3：物品栏工具（调用入口 function 的薄封装，不含贴图；2026-08-26 起已实现：音符放置工具 give_note_tool/place/inherit、选择/框选工具 give_select_tool/select、时间轴 9 键工具 give_timeline_tool/timeline；实施顺序调整为阶段4完成后）
- [x] 阶段5：可视化时间轴图形界面（跟随玩家；信息显示+5音符轨道+时间点/事件轨道+节奏刻度+控件按钮；含“根据时间控件实时显示谱面内容”）
- [x] 阶段6：撤销重做/保存/剪贴板/改名（基本完成：保存 file/save、未保存退出提示（exit 流程）、剪贴板 copy/cut/paste、撤销重做 begin/commit + 主菜单/反馈按钮（点击值 150/151 与 8/9）、另存为（面板9，按钮 13/40/41）、改名 map_rename；2026-08-28 撤销重做快照污染/回错面板双根因已修复并验证）
- [ ] 阶段7：物品栏工具贴图与材质
- [ ] 阶段8：全流程整合测试

- [x] rhythm_axe_mod
  - [x] 为mod添加在数据包的操控下流式播放音乐的功能（2026-08-15 完成：playmusic/pausemusic/resumemusic/stopmusic；起始时间单位 tick，有谱面时间点→分段换算、无→当前 mspt；速度保调不变音高；多人网络包）
  - [x] mod可以接收带小数的bpm值，但是反馈的bpm是取整数的，应该如实以小数形式反馈bpm值
  - [ ] 移除移除聊天栏执行指令警告对话框的功能，改用trigger指令等方式做到阻止聊天栏等地方执行指令跳警告框

- [x] 各类操作的入口function

  - [x] 时间轴控件
    - [x] 播放/暂停（2026-08-18 完成：editor/playback/play、pause——tick rate 跟随播放头时间点 + playmusic 联动，速度=play_speed%）
    - [x] 快进/快退(以刻、拍、小节为单位)（2026-08-18 完成：editor/playback/seek {dir,ticks}、step {kind,dir}）

  - [ ] 文件类
    - [x] 新建（2026-08-18 完成：默认模板 append maps.editor.history 工作副本，不创建 maps.<mapid>）
    - [x] 保存（2026-08-18 完成：editor/file/save {mapid,cur}——merge 写入 maps.<mapid> 保留 highest_score；保存不动历史，退出时清历史）
    - [x] 删除（2026-08-18 完成：editor/file/delete {mapid}——移入 rhythm_axe:maps.trash.<mapid> 后删正式存储；编辑中/不存在拒绝）
    - [x] 撤销（2026-08-18 完成：editor/file/undo）
    - [x] 重做（2026-08-18 完成：editor/file/redo）

  - [ ] 音符操作
    - [x] 创建（2026-08-18 完成：editor/note/create，prop.time+type，可选字段全支持，按 time 升序插入，id 自增）
    - [x] 删除（2026-08-18 完成：editor/note/delete，prop.note_id，未找到不产生快照）
    - [x] 复制（2026-08-18 完成：editor/note/copy，多选 prop.note_ids/selection，剪贴板 {note_ids,notes}，提示已复制 x 个）
    - [x] 剪切（2026-08-18 完成：editor/note/cut，复制+删除原音符，提示已剪切 x 个）
    - [x] 粘贴（2026-08-18 完成：editor/note/paste，可选 prop.time 基准+相对偏移，重新分配 id 后插入，提示已粘贴 x 个）
  
  - [ ] 时间点操作
    - [x] 创建（2026-08-18 完成：editor/timing/create，按 time 升序插入）
    - [x] 修改（2026-08-18 完成：editor/timing/modify，prop.timing_fields merge）
    - [x] 删除（2026-08-18 完成：editor/timing/delete，首个时间点不可删）
    - [x] 上一个/下一个时间点之间跳转（2026-08-18 完成：editor/timing/prev、next，播放中自动重同步）

  - [ ] 事件点操作
    - [x] 创建（2026-08-18 完成：editor/event/create，按 time 升序插入）
    - [x] 修改（2026-08-18 完成：editor/event/modify，prop.event_fields merge）
    - [x] 删除（2026-08-18 完成：editor/event/delete）
    - [x] 上一个/下一个事件点之间跳转（2026-08-18 完成：editor/event/prev、next，播放中自动重同步）

- [x] 各类操作的物品栏工具（不包括贴图）（2026-08-26 起已实现：音符放置工具、选择/框选工具、时间轴 9 键工具；其余操作工具按需补充）

- [x] 聊天栏编辑界面

- [x] 对话框
  - [x] 击打音效（面板12 全局击打音效编辑；音符面板内）
  - [x] 击打视效（面板13 全局击打视效编辑）
  - [x] 击打事件（面板14 击打事件二级菜单 + 行级对话框）
  - [x] 其他需要对话框进行编辑的内容

- [x] **可视化时间轴**
  - [x] 创建（召唤）
  - [x] 关闭（隐藏）

  - [x] 文字信息显示部分
  - [x] 时间轴部分
  - [ ] ~~控件部分~~
- [x] 根据时间控件实时显示谱面内容
- [ ] 删除没必要的已弃用的函数、命令行与注释行
- [ ] 重写trigger、按钮、面板使用值段，避免屎山堆积

## 游戏模组灵感

- [x] 自动模式|auto
- [ ] 自定尺寸|sized 玩家可以自定义谱面的音符size属性

# 粒子

- 把现有1-5击打特效与音效组合在1里面，新增一个0选项，默认0（依据玩家设置），1-6变成覆盖模式

1. 原版风格，方块破坏音效与粒子
2. 少量粒子
3. 无粒子

4-5留空，6保持现状
