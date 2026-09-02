# 左键点击交互实体（advancement reward，@s = 玩家）
# 26.x 已验证：advancement 完整获得（grant 整个）后永久激活，点击每次触发一次；reward 只 revoke 整个即可可重复
#   ⚠️ 绝不能 grant（任何 grant 都会因玩家历史交互记录立即完成 → 无限循环 200000）
advancement revoke @s only rhythm_axe:jukebox_left_click
# 通用实体点击捕获：给被点击的唱片机交互实体打通用点击标记 interacted
#   （唱片机判定消费该标记；之后其它需要点击交互的功能可复用同一套 advancement + 标记）
execute on target if entity @s[type=interaction,tag=note_jukebox] run scoreboard players add @s interacted 1
