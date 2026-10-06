# 蹲下 + 播放/暂停工具 = 「记录点」开关（只有工具路径会分派到这里，见 tool/timeline/used_timeline_playpause）
# ★ 蹲下右键**只操作记录点，完全不控制播放/暂停**（播放/暂停只由「站立点击」负责）
#   · 播放头**正停在记录点上**（且已有记录点）→ **删除**记录点（不改变播放状态、不跳转）
#   · 其它情况（未设 / 播放头不在记录点处）→ 把**当前播放头**记为记录点（覆盖旧的），并发一行聊天栏提示
# ★ 记录点是**持久**的：只要存在，之后每次「播放/暂停」暂停都会跳回这里（可反复使用），
#   不随暂停/播放清除；删除只能在「记录点处蹲下右键」。
# ★ 存储位：rhythm_axe:maps.editor.record_head（Int，与 time_select 同层，mod 侧可读 → 画半透明播放头）
execute unless data storage rhythm_axe:maps.editor active run return 0
# 先判定本次点击是「删除」还是「记录」：记录点存在 且 播放头 = 记录点 → 删除
scoreboard players set #rt_mode editor 0
execute if data storage rhythm_axe:maps.editor record_head run execute store result score #rt_head editor run data get storage rhythm_axe:maps.editor record_head
execute if data storage rhythm_axe:maps.editor record_head run execute store result score #rt_cur editor run data get storage rhythm_axe:maps.editor playhead
execute if data storage rhythm_axe:maps.editor record_head if score #rt_cur editor = #rt_head editor run scoreboard players set #rt_mode editor 1
# 删除记录点
execute if score #rt_mode editor matches 1 run data remove storage rhythm_axe:maps.editor record_head
execute if score #rt_mode editor matches 1 run tellraw @s [\
    {"text":"[编辑器] ","color":"gold"},{"text":"已删除记录点","color":"red"},{"score":{"name":"#rt_head","objective":"editor"},"color":"gold"},\
    {"text":"，蹲下右键可以创建新的记录点","color":"green"}\
    ]
# 记录 / 覆盖为当前播放头 + 聊天栏提示
execute if score #rt_mode editor matches 0 run execute store result score #rt_head editor run data get storage rhythm_axe:maps.editor playhead
execute if score #rt_mode editor matches 0 run execute store result storage rhythm_axe:maps.editor record_head int 1 run scoreboard players get #rt_head editor
execute if score #rt_mode editor matches 0 run tellraw @s [\
    {"text":"[编辑器] ","color":"gold"},{"text":"已添加记录点","color":"green"},{"score":{"name":"#rt_head","objective":"editor"},"color":"gold"},\
    {"text":"，\n在记录点处蹲下右键可以清除记录点，移动播放头蹲下右键可以移动当前记录点","color":"green"}\
    ]
execute if score debug_output options matches 1.. run tellraw @s [{"text":"[调试.lv1][编辑器]","color":"gray"},{"text":" 记录点已","color":"green"},{"score":{"name":"#rt_mode","objective":"editor"},"color":"aqua"},{"text":"（0=记录/覆盖 1=删除）","color":"gray"}]
