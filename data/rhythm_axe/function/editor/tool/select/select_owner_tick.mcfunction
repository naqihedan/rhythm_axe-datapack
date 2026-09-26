# 选择工具「占用者」维护（由 tick.mcfunction 每刻调用一次；协作：同一时间只允许一人驱动选择工具）
# ★ 为什么需要：选择工具是「两次右键定两角」的状态机，state/corner1 存在全局 maps.editor.select_tool 里；
#   两人同时点会把角点交叉混在一起 ⇒ 用「占用者」把驱动权收给一个人（最先手持工具的那位）。
#   - 释放 = 占用者不再手持选择工具（主手/副手都没有）；玩家下线时标签随实体消失，天然释放。
#   - 接任 = 无人占用时，「第一个手持者」立刻成为占用者，并可沿用前一位设好的第一角继续点第二角。
#   - 非占用者右键 → used_select / used_time_select 顶部提示「选择工具已被占用」并中止（也不给黄绿玻璃预览）。
# ① 释放：占用者已不再手持选择工具
execute as @a[tag=editor_select_owner] unless items entity @s weapon.mainhand *[custom_data~{editor_tool_select:true}] unless items entity @s weapon.offhand *[custom_data~{editor_tool_select:true}] run tag @s remove editor_select_owner
# ② 认领：只在「无人占用」时进行；#sel_own_take 保证只认领「第一个手持者」
#    （0 = 可认领 / 1 = 本轮刚认领 / 2 = 已有人占用。注意条件必须写在 as 之后才是逐玩家判定，
#      写成 unless entity ... 再 as 只会整体判一次 ⇒ 会把所有手持者都认领了）
scoreboard players set #sel_own_take editor 0
execute if entity @a[tag=editor_select_owner] run scoreboard players set #sel_own_take editor 2
execute as @a[tag=editor_active] if score #sel_own_take editor matches 0 if items entity @s weapon.mainhand *[custom_data~{editor_tool_select:true}] run tag @s add editor_select_owner
execute as @a[tag=editor_active] if score #sel_own_take editor matches 0 if items entity @s weapon.mainhand *[custom_data~{editor_tool_select:true}] run scoreboard players set #sel_own_take editor 1
execute as @a[tag=editor_active] if score #sel_own_take editor matches 0 if items entity @s weapon.offhand *[custom_data~{editor_tool_select:true}] run tag @s add editor_select_owner
execute as @a[tag=editor_active] if score #sel_own_take editor matches 0 if items entity @s weapon.offhand *[custom_data~{editor_tool_select:true}] run scoreboard players set #sel_own_take editor 1
