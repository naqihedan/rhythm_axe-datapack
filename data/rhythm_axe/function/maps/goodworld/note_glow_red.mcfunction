# 音符展示实体「发红光」——配【击打事件】的【生成时(spawn)】用
# 用法：编辑器 → 音符 → 击打事件 → 添加指令 `function rhythm_axe:maps/goodworld/note_glow_red`，并打开该项【生成时】
# 红 = glow_color_override 16733525 (#FF5555，与锚点/「自动」同一支红)；要纯红改 16711680 (#FF0000)
# 生成时 = 音符延迟期结束、开始移动那一刻（音符刚可见）⇒ 一亮就是「这个音符出现时」；光会留到该音符消失
# 执行者（游玩与编辑器试听一致）= 音符交互实体；本函数按 note_id 反查同一音符的展示实体
# 两种 tag 都覆盖：游玩 note_display / 编辑器 editor_note

# 先读本音符 id（守卫：执行者身上没有 note_id 就一律不动手，避免用上一次的残留 id 点错音符）
execute if score @s note_id matches 0.. run execute store result score #ngr_id play_state run scoreboard players get @s note_id

# 游玩：给 tag=note_display 的展示实体上红光
execute if score @s note_id matches 0.. run execute as @e[type=item_display,tag=note_display] if score @s note_id = #ngr_id play_state run data modify entity @s Glowing set value 1b
execute if score @s note_id matches 0.. run execute as @e[type=item_display,tag=note_display] if score @s note_id = #ngr_id play_state run data modify entity @s glow_color_override set value 16733525

# 编辑器试听：同一套逻辑，展示实体 tag 换成 editor_note
execute if score @s note_id matches 0.. run execute as @e[type=item_display,tag=editor_note] if score @s note_id = #ngr_id play_state run data modify entity @s Glowing set value 1b
execute if score @s note_id matches 0.. run execute as @e[type=item_display,tag=editor_note] if score @s note_id = #ngr_id play_state run data modify entity @s glow_color_override set value 16733525
