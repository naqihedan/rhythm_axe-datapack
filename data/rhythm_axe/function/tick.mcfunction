# ========== display_animation 游戏刻循环 ==========
# 每 tick 调用，驱动所有活跃动画
execute as @e[scores={anim_status=1}] run function rhythm_axe:utilization/display_animation/step

# ========== 编辑器：聊天栏点击逐刻消费 ==========
# 玩家点击编辑器按钮（/trigger editor_click set N）→ 本行检测后分发到编辑器 consume
execute as @a[scores={editor_click=1..}] run function rhythm_axe:editor/menu/consume
# 协作兜底：trigger 计分板必须对本人 enabled —— 后进服的玩家 / 被 reset 过的玩家靠这行自愈
#   （同 map_list/open 里 `enable @s menu_click` 的写法；没有它会出现「点了没反应 / 提示无法触发计分项」）
scoreboard players enable @a[tag=editor_active] editor_click

# ========== 菜单系统：聊天栏点击逐刻消费 ==========
# 玩家点击菜单按钮（/trigger menu_click set N）→ 本行检测后分发到菜单层 consume
execute as @a[scores={menu_click=1..}] run function rhythm_axe:menu/consume

# ========== 判定延迟补偿：手动覆盖的自助入口 ==========
# lag_rtt_manual = 该玩家自己的判定箱回退量（毫秒，0 = 不补偿；不设 = 自动读 net）
#   ★ 非 OP 玩家也能自己用：/trigger lag_rtt_manual set <毫秒>（/trigger 用过即失效 ⇒ 每刻重 enable）
#   用途：房主没装 mod（读不到 RTT）时手动指定；或多人实测时让对方自己扫档（0/20/70 = 0/1/2 刻）
scoreboard players enable @a lag_rtt_manual

# （已选定音符列表改为同步高效渲染，无需此处异步驱动）

# ========== 编辑器：播放推进 ==========
# 播放中每 tick 播放头 +1、更新 bossbar、到尾自动停
execute if data storage rhythm_axe:maps.editor active run function rhythm_axe:editor/playback/advance

# 出点跟手（编辑器打开 + 暂停中）：出点始终 = 播放头，让时间轴实时预览范围；
# ★ 刚点完入点（出入点同刻）时不显示出点/色带 —— 由 mod 侧（TimelineGui）按「只有入点」画。
execute if data storage rhythm_axe:maps.editor active unless data storage rhythm_axe:maps.editor {playing:1b} run function rhythm_axe:editor/tool/select/time_select_out_sync

# ========== 编辑器：选择工具占用者（协作：同一时间只允许一人驱动选择工具）==========
execute if data storage rhythm_axe:maps.editor active run function rhythm_axe:editor/tool/select/select_owner_tick
# ========== 编辑器：物品栏工具游标 ==========
# 手持音符/选择工具时维护 ^^^3 光标玻璃（协作：每人一块，见 cursor_tick / glow_note / select_glow_tick）
# ★ 存活标记：先清标记 → 各人认领自己那块 → 再杀掉本刻没人认领的（没手持 / 蹲下 / 被踢 / 下线）
execute if data storage rhythm_axe:maps.editor active run tag @e[tag=editor_tool_glow] remove glow_alive
execute if data storage rhythm_axe:maps.editor active run tag @e[tag=editor_tool_select_glow] remove glow_alive
execute as @a[tag=editor_active] at @s run function rhythm_axe:editor/tool/cursor_tick
execute if data storage rhythm_axe:maps.editor active run kill @e[tag=editor_tool_glow,tag=!glow_alive]
execute if data storage rhythm_axe:maps.editor active run kill @e[tag=editor_tool_select_glow,tag=!glow_alive]

# ========== 编辑器：工具常驻检测（方向工具/事件时间点工具 动态名与模型，随蹲下状态切换） ==========
function rhythm_axe:editor/tool/tool_regular_tick

