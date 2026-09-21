# 点击探测（@s = 编辑器音符交互实体；at @s 由 input_click 保证）
# 机制：给自身打临时标签 to_be_looked_at → 问「附近编辑者是否正看着我」（looking_at 谓词）→ 撤标签
# ★ 一次只能给一个实体打标签（谓词按 NBT {Tags:[to_be_looked_at]} 匹配准星命中的实体），故必须逐实体探测
# ★ 距离基准与视线判定一致（执行位置 = 交互实体位置；游玩用 ..4.5）
tag @s add to_be_looked_at
execute if entity @a[tag=editor_active,sort=nearest,distance=..4.5,predicate=rhythm_axe:looking_at] run tag @s add editor_n_clicked
tag @s remove to_be_looked_at
