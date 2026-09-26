# 邀请玩家加入协作（@s = 被邀请者；操作者 = @a[tag=coop_self,limit=1]）
# 等价编辑：加入后他看得到面板/时间轴/听得到音乐，也能点按钮、用工具（与房主同权限）
# 已在协作中 → 只提示
execute if entity @s[tag=editor_active] run tellraw @a[tag=coop_self,limit=1] [{"text":"[编辑器] ","color":"gold"},{"text":"该玩家已在协作中","color":"yellow"}]
execute if entity @s[tag=editor_active] run return 0
# 广播用的标记（tellraw 里的 selector 组件要放在「被操作者」身上；不能用 @s —— 那会按接收者解析）
tag @s add coop_just_now
# 正式加入：tag（= 所有 @a[tag=editor_active] 选择器自动覆盖新成员）+ trigger 开关 + 三个输入 advancement
tag @s add editor_active
advancement grant @s only rhythm_axe:editor/note_click
advancement grant @s only rhythm_axe:editor/note_deselect
# ★ 顺序不能反：reset 会把 trigger 的「已启用」标记一起清掉（同 init_state / consume 的写法）
scoreboard players reset @s editor_click
scoreboard players enable @s editor_click
# 发协作工具（他需要它才能再邀请别人）+ 立刻渲染当前面板（共享同一面板 ⇒ 与房主看到的一样）
function rhythm_axe:editor/tool/give_coop_tool
function rhythm_axe:editor/menu/resume
# 提示
tellraw @a[tag=editor_active] [{"text":"[编辑器] ","color":"gold"},{"selector":"@a[tag=coop_just_now]"},{"text":" 加入了协作","color":"green"}]
tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"你现在与房主同权限：","color":"green"},{"text":"面板/时间轴/音乐/工具/按钮 都可以用（面板与播放头是大家共享的）","color":"gray"}]
tag @s remove coop_just_now
