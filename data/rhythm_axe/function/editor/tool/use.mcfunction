# 音符工具右键进度奖励（@s = 玩家，26.x：grant 后每次点击触发一次，先 revoke 即可重复）
advancement revoke @s only rhythm_axe:editor/tool_use

# 非编辑状态 / 主副手都没有工具 → 忽略
execute unless data storage rhythm_axe:maps.editor active run return fail
execute unless items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] unless items entity @s weapon.offhand *[custom_data~{editor_tool:true}] run return fail

# ★ 统一操作反馈音：工具右键有效操作（校验通过）即播放（与 trigger 通道按钮点击同款）
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1
# ★ 多人并发锁（与 menu/consume 同款；本人连点不受限）
execute store result score #op_now editor run time query gametime
execute if score #lock_until editor >= #op_now editor unless entity @s[tag=editor_lock_holder] run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"另一位编辑者正在操作，请稍候再试","color":"yellow"}]
execute if score #lock_until editor >= #op_now editor unless entity @s[tag=editor_lock_holder] run return fail
tag @a[tag=editor_lock_holder] remove editor_lock_holder
tag @s add editor_lock_holder
scoreboard players operation #lock_until editor = #op_now editor
scoreboard players add #lock_until editor 3

# 下一刻才能执行命令
tag @s add editor_used_tool
schedule function rhythm_axe:editor/tool/use_ 1t

