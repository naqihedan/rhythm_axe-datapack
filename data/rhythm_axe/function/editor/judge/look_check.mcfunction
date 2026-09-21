# 编辑器真实判定：视线命中检测（@s = 编辑器音符展示实体；type 0/1）
# 机制与游玩 judgement 完全一致：
#   ① 给「本音符配对的交互实体」打临时标签 to_be_looked_at
#   ② @a[...predicate=rhythm_axe:looking_at] —— 谓词按 NBT {Tags:[to_be_looked_at]} 匹配「玩家准星命中的实体」
#      ⇒ 一次只能给一个实体打标签（否则可能匹配到别的音符），故必须逐音符打/撤
#   ③ 撤标签
# 距离基准与游玩一致：执行位置下移 1.62 格（= 玩家眼睛高度）后测距离，与视线射线起点统一
# 结果写 @s editor_n_hit（1 = 命中；由 judge/probe 预扫时调用，note_check 直接读该标记）
scoreboard players operation #ed_nid editor = @s note_id
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #ed_nid editor run tag @s add to_be_looked_at
execute positioned ~ ~-1.62 ~ if entity @a[tag=editor_active,sort=nearest,distance=..4.5,predicate=rhythm_axe:looking_at] run scoreboard players set @s editor_n_hit 1
execute as @e[type=interaction,tag=editor_note] if score @s note_id = #ed_nid editor run tag @s remove to_be_looked_at
