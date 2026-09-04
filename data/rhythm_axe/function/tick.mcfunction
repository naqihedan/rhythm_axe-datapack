# ========== display_animation 游戏刻循环 ==========
# 每 tick 调用，驱动所有活跃动画。
# 由 #minecraft:tick 标签触发。
execute as @e[scores={anim_status=1}] run function rhythm_axe:utilization/display_animation/step

# ========== 编辑器：聊天栏点击逐刻消费 ==========
# 玩家点击聊天文本（/trigger editor_click set N）→ 本行检测后分发到菜单处理
execute as @a[scores={editor_click=1..}] run function rhythm_axe:editor/menu/consume

# （已选定音符列表改为同步高效渲染，无需此处异步驱动）

# ========== 编辑器：播放推进 ==========
# 播放中每 tick 播放头 +1、更新 bossbar、到尾自动停
execute if data storage rhythm_axe:maps.editor active run function rhythm_axe:editor/playback/advance

# ========== 编辑器：物品栏工具游标 ==========
# 手持音符工具时维护 ^^^3 游标（右键放置音符）
execute as @a[tag=editor_active] at @s run function rhythm_axe:editor/tool/cursor_tick

# ========== 编辑器：工具常驻检测（方向工具/事件时间点工具 动态名与模型，随蹲下状态切换） ==========
function rhythm_axe:editor/tool/tool_regular_tick

