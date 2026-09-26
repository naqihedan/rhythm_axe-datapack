# 判定延迟补偿 · 按玩家 RTT 把判定箱临时挪到「他眼睛看到的位置」
#   @s = 音符交互实体（音符盒/木板）；#st_lag = 本玩家要回退的刻数（st_player 算好，0..4）
# 动机（2026-09-26，多人兼容）：判定箱由 move_self 每刻写「视觉位置 = note_lin_t - 1」，
#   那 1 刻是给**单机**客户端渲染延迟补的。客机上玩家眼睛看到的音符还要再晚一个单程延迟
#   （服务端→客户端把画面传过去的时间），而他的朝向又是「单程延迟之前」发出的
#   ⇒ 服务端拿「旧朝向」打「新判定箱位置」，两者差了约一整个 RTT（往返延迟）。
#   症状（且只在客机出现）：音符远时角度差小 → 还没到判定线就判；音符贴近判定位置时
#   角度差大（十几度）→ 准星对准了也不判。房主 RTT≈0 ⇒ 没有这个差，这也是补偿对单机零影响的原因。
# 做法：#st_lag = (RTT+30)/50 整数除（RTT ≥ 20ms 就退 1 刻、每多 50ms 再多 1 刻；clamp 0..4），
#   让 move_self 把进度 t 再减这么多重算位置。
#   move_self 里 t 已有下/上钳制 ⇒ 出生前（还没开始飞）与抵达判定位置后都自动退回正确位置。
# 范围：音符盒/木板都补偿 ——
#   线性（note_linear）→ st_lag_apply_lin（闭式公式精确回退，无需历史）；
#   非线性（anim_power≠1）→ st_lag_apply_nl（取位置环 note_vis<L> = 真实历史位置）。
#   唱片机走点击（客户端射线，几何本来就准）、混凝土走区域、玻璃走碰撞 → 都不需要。
# 调用：judgement/st_probe 在做 looking_at 测试**之前**调用一次；测试完由 st_player 还原
#   （每个玩家退场时各还原一次，不能只在整段末尾 —— @a 遍历顺序任意）。
# 性能：#st_lag = 0（房主/单机/关开关）时只多 1 条 matches 判断；
#   非线性音符的位置环维护写在本处 move_write_pair（只对音符盒/木板）。

execute unless score #st_lag play_state matches 1.. run return 0
# 线性（note_linear）：闭式公式直接回退
execute if entity @s[tag=note_linear] run function rhythm_axe:play/judgement/st_lag_apply_lin
# 非线性：只对走视线判定的音符盒/木板（唱片机走点击、混凝土走区域、玻璃走碰撞 → 都不需要回退）
execute unless entity @s[tag=note_linear] if entity @s[tag=note_noteblock] run function rhythm_axe:play/judgement/st_lag_apply_nl
execute unless entity @s[tag=note_linear] if entity @s[tag=note_plank] run function rhythm_axe:play/judgement/st_lag_apply_nl
