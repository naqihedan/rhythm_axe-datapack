# 自动模式音符判定（@s = 音符交互实体；音符盒/木板/唱片机统一，由 interact_judge 在 auto=1 时调用）
# auto 语义：玩家不能判定谱面音符，由 auto 接管——音符在寿命=0 时自动判大P
#   （等价"玩家恰在完美时刻注视着音符盒/木板、恰在完美时刻击打唱片机"）
# 流程：
#   1. 寿命 == 0 → #judge_life=0 判大P（judge 走完整反馈链：击打事件照常、计数、配对删除）
#   2. 出窗兜底：寿命 < -2x 仍未判定（异常/提前结束残留）→ 也判大P，保证判到所有音符
# 判定保护/视线/点击检测全部跳过（玩家不参与）；玻璃不在此入口（碰撞在 glass_sweep，auto 短路）
scoreboard players operation #life play_state = @s note_life

# 寿命 == 0 → 自动判大P
execute if score #life play_state matches 0 run scoreboard players set #judge_life play_state 0
execute if score #life play_state matches 0 run function rhythm_axe:play/judgement/judge

# 出窗兜底：寿命越过 goodL 末刻（< -2x）仍未判定 → 补判大P（防御：正常寿命=0 已判，实体已被删）
scoreboard players operation #tn2 play_state = #judgement_scale play_state
scoreboard players operation #tn2 play_state *= -2 const
execute if score #life play_state < #tn2 play_state run scoreboard players set #judge_life play_state 0
execute if score #life play_state < #tn2 play_state run function rhythm_axe:play/judgement/judge
