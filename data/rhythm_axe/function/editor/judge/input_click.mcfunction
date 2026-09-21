# 编辑器真实判定：点击输入（@s = 玩家；左键 note_click / 右键 note_deselect 在「播放中 + 判定模式」时都转到这里）
# 照搬游玩语义：只有唱片机（type 2）认点击；音符盒/木板（0/1）认视线，点击无效
#   （无效点击也会打标记，但判定只在 type 2 消费它 → 无害，标记由 visual/tick 每刻统一清掉）
# 定位被点的音符：编辑器单人锁 ⇒ 附近唯一编辑者即点击者，用「准星命中 + 配对交互实体临时标签」逐个探测
#   （不依赖 attack.player / interaction.player 的 UUID 匹配，左右键走同一套）
# ★ 时序：advancement reward 在玩家操作当刻执行，可能晚于本刻判定扫描 ⇒ 标记由下一刻 note_check 消费
execute as @e[type=interaction,tag=editor_note] at @s run function rhythm_axe:editor/judge/click_probe
