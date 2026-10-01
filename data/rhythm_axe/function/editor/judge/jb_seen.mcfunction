# 编辑器真实判定：唱片机判定保护记录（@s = 编辑器音符展示实体，type 2）
# 判定窗口内任一刻「视线与本音符配对的交互实体相交」→ 打 editor_n_jb_seen（只记一次）
# 末刻兜底（judge/note_check）：life == -2x 仍未点击 → 有记录 good_late；无记录 miss
# 机制同 judge/look_check：给配对的交互实体打临时标签 to_be_looked_at → 谓词命中 → 撤标签
#   （谓词 looking_at 靠 {Tags:[to_be_looked_at]} 选中"准星命中的实体"，一次只能给一个实体打标签）
# 距离基准与游玩一致：执行位置下移 1.62 格（= 玩家眼睛高度）
scoreboard players operation #ed_nid editor = @s note_id
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #ed_nid editor run tag @s add to_be_looked_at
execute positioned ~ ~-1.62 ~ if entity @a[tag=editor_active,sort=nearest,distance=..4.5,predicate=rhythm_axe:looking_at] run tag @s add editor_n_jb_seen
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #ed_nid editor run tag @s remove to_be_looked_at
