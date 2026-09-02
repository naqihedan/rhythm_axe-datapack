# 音符工具右键进度奖励（@s = 玩家，26.x：grant 后每次点击触发一次，先 revoke 即可重复）
advancement revoke @s only rhythm_axe:editor/tool_use

# 非编辑状态 / 主副手都没有工具 → 忽略
execute unless data storage rhythm_axe:maps.editor active run return fail
execute unless items entity @s weapon.mainhand *[custom_data~{editor_tool:true}] unless items entity @s weapon.offhand *[custom_data~{editor_tool:true}] run return fail

# ★ 统一操作反馈音：工具右键有效操作（校验通过）即播放（与 trigger 通道按钮点击同款）
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1

# 下一刻才能执行命令
tag @s add editor_used_tool
schedule function rhythm_axe:editor/tool/use_ 1t

