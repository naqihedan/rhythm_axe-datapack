# 主菜单【判定：开/关】（10502）：翻转 options.editor_note_judge（0=自动预览 1=真实判定）
# 播放中切换 → 立即重建音符视觉（判定模式会延长普通音符存活窗口到 miss 时刻，重建才能生效）
# 提示 + 刷新主菜单（本文件由 panel1 分支调用，@a[tag=editor_active] 拿不到执行者，用 as 定位）
scoreboard players set #jd_tmp editor 1
execute if score editor_note_judge options matches 1 run scoreboard players set #jd_tmp editor 0
scoreboard players operation editor_note_judge options = #jd_tmp editor
# 播放中切换 → 重建（暂停/非播放时窗口不影响显示，无需重建）
execute if score editor_note_judge options matches 1 if data storage rhythm_axe:maps.editor {playing:1b} run function rhythm_axe:editor/refresh
execute if score editor_note_judge options matches 0 if data storage rhythm_axe:maps.editor {playing:1b} run function rhythm_axe:editor/refresh
execute if score editor_note_judge options matches 1 as @a[tag=editor_active] run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"真实判定：开","color":"green"},{"text":"（试听时音符须在判定窗内被命中/看向/点击才播音符事件，超窗 miss；不计成绩与连击）","color":"gray"}]
execute if score editor_note_judge options matches 0 as @a[tag=editor_active] run tellraw @s [{"text":"[编辑器] ","color":"gold"},{"text":"真实判定：关","color":"red"},{"text":"（试听时音符自动判定，等同 auto）","color":"gray"}]
schedule function rhythm_axe:editor/menu/main_next 1t
