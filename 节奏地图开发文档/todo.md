# 待做清单

> 动态清零，用于快速记录想法

- [x] 音符间引导线，类似osu（M2 完成 2026-08-14：0/1/2 音符 following_point=true 时连到上一个 0/1/2，青色细线连接两音符视觉中心，两端任一音符消失即消失）
- [ ] 谱面格式校验（文档已开始编写：见谱面格式校验.md；自动检测实现暂缓，先做游玩运行部分）
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
      已临时加 `#sort_fill_done` 一次性标记（init 置 0、首个 put 置 1）保证 drain 只执行一次，**尚未验证**。
      恢复排序链后需：①验证 `#sort_fill_done` 修复有效；②修 fill/put 阶段 `sort_bucket[0]` 重复音符（storage 与全局 `#sort_i` 不同步导致音符重复处理）；
      ③考虑 grow/drain 每层多建/多合并几个桶以降低宏递归层数（当前 513×2 层逼近序列长度上限）。
      ④如果实在压不下命令总数，就把排序分布在多个游戏刻进行

## 里程碑实现规划（M2 系列）

- M2-G 染色玻璃（type 4）：碰撞检测→扣 `health` 计分板（不影响真实血量）；扣血冷却（全局设置）；持续时长语义（寿命 0 后存活 duration 刻）；移动方式（一直运动直到寿命+duration<=0）✅
- M2-H 判定反馈组表（音效/粒子/事件）：hitsound/hit_particles 用“存储表+宏执行”（`$playsound`/`$particle` 按 [组][等级] 查表）；hit_events 按各情况 enabled 过滤后宏执行；把 judgement_feedback 硬编码反馈重构为查表 ✅
- M2-I 事件+音乐：✅ 背景音乐播放（谱面 `music` 字段 → `time==0` 触发 play_music，record 通道，`as @a at @s` + minVolume 1 无视差；end_of_game `stopsound @a record` 停止，自动结束+手动 stop 全覆盖；资源包 sounds.json 已关联 audio.ogg）。待办：定义音效组/粒子组数据（spawn/bad/goodE/perfectE/perfect/perfectL/goodL/miss/damage 9 情况；用户暂不填）
- 优化轮：音符缓动整体测试（M2-G 完成后一块测试 anim_easing/anim_power）
- 近距混凝土判定区域偏移：✅ 用户确认保持 dx=2 不改（2026-08-07）

## 里程碑实现规划（编辑器）

- [x] 阶段0：mod 流式音乐播放（2026-08-15 完成：/playmusic /pausemusic /resumemusic /stopmusic；多人网络包；保调重采样变速；tick→ms 换算——正在编辑谱面且有 timing_points 时按时间点分段换算、无则 mspt；/stopsound 联动停音；mod 1.5.0）
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
