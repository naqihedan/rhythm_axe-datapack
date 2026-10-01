# 面板 22：设置面板（菜单系统页面，计分板 menu_click）。规范 v2：
#   页序：0 = 游玩（行 122~130；131 已挪走 / 127 废弃留空）
#         1 = 模组（行 170~179）★ 2026-09-30 新增
#         2 = 编辑器（行 132~141；134/135/136/138/139 废弃或挪走）
#         3 = 高级（行 142~153；152 = 伤害扣血冷却 / 153 = 音乐自动对齐游戏）
#   行 160 = 页脚（16001 上一页 / 16002 下一页 / 16003 收起 / 16004 恢复默认→待确认 / 16005 确认恢复 /
#             16006 取消 / 16007 关闭所有模组（仅模组页渲染））。
#   每项列码：1 = −（布尔项＝切换） / 2 = ＋
# 入口：options/main（设 rhythm_axe:options.open = 1b、panel = 22）。
# 入口白名单守卫（两行：先提示再 return fail）
execute unless score #menu_value menu matches 12201..15302 unless score #menu_value menu matches 16001..16007 unless score #menu_value menu matches 17001..17902 run function rhythm_axe:options/wrong_panel
execute unless score #menu_value menu matches 12201..15302 unless score #menu_value menu matches 16001..16007 unless score #menu_value menu matches 17001..17902 run return fail

# ==================== 页脚（行 160）====================
# 翻页：页号循环 0/1/2/3（页号在 @s 自己的 options_page 计分项）
execute if score #menu_value menu matches 16001 run scoreboard players remove @s options_page 1
execute if score #menu_value menu matches 16001 if score @s options_page matches ..-1 run scoreboard players set @s options_page 3
execute if score #menu_value menu matches 16002 run scoreboard players add @s options_page 1
execute if score #menu_value menu matches 16002 if score @s options_page matches 4.. run scoreboard players set @s options_page 0
# 收起：提前返回（不重绘）
execute if score #menu_value menu matches 16003 run return run function rhythm_axe:options/close
# 恢复默认：**两步确认**（学编辑器「删除谱面」）—— 16004 只进入待确认状态，
#   确认态下页脚换成【确认恢复】16005 / 【取消】16006；确认后才真正重置
execute if score #menu_value menu matches 16004 run return run function rhythm_axe:options/reset_confirm
execute if score #menu_value menu matches 16005 run function rhythm_axe:options/reset_all
execute if score #menu_value menu matches 16006 run return run function rhythm_axe:options/reset_cancel
# 【关闭所有模组】（只在模组页渲染出来，16007）：把 mods 计分板所有模组开关置 0
execute if score #menu_value menu matches 16007 run return run function rhythm_axe:options/mods_off

# ==================== 页 0 游玩（行 122~130）====================
# 122 流速 note_speed
execute if score #menu_value menu matches 12201 run function rhythm_axe:options/step {key:"note_speed",delta:-1,min:1,max:100}
execute if score #menu_value menu matches 12202 run function rhythm_axe:options/step {key:"note_speed",delta:1,min:1,max:100}
# 123 音符 hotbar 反馈
execute if score #menu_value menu matches 12301 run function rhythm_axe:options/toggle {key:"feedback_actionbar",obj:"options"}
# 124 音符聊天反馈
execute if score #menu_value menu matches 12401 run function rhythm_axe:options/toggle {key:"feedback_chat",obj:"options"}
# 125 击打挥砍动画
execute if score #menu_value menu matches 12501 run function rhythm_axe:options/toggle {key:"swing_anim",obj:"options"}
# 126 歌曲进度条
execute if score #menu_value menu matches 12601 run function rhythm_axe:options/toggle {key:"song_progress_display",obj:"options"}
# 127 【已废弃 2026-09-29】进度条颜色：改为谱面级 progress_color（编辑器「谱面设置」面板 11201/11202），
#   全局不再提供该选项 ⇒ 12701/12702 无分支（留空不重排，守卫范围仍涵盖 127xx 无影响）
#
# 128 结算详细判定
execute if score #menu_value menu matches 12801 run function rhythm_axe:options/toggle {key:"detailed_judgements",obj:"options"}
# 129 全局击打音效组（1..6）
execute if score #menu_value menu matches 12901 run function rhythm_axe:options/step {key:"note_hitsound",delta:-1,min:1,max:6}
execute if score #menu_value menu matches 12902 run function rhythm_axe:options/step {key:"note_hitsound",delta:1,min:1,max:6}
# 130 全局击打粒子组（1..6）
execute if score #menu_value menu matches 13001 run function rhythm_axe:options/step {key:"note_particle",delta:-1,min:1,max:6}
execute if score #menu_value menu matches 13002 run function rhythm_axe:options/step {key:"note_particle",delta:1,min:1,max:6}
# 131 【已挪走 2026-09-29】伤害扣血冷却 → 页 3 行 152（13101/13102 无分支，留空不重排）

# ==================== 页 1 模组（行 170~179）★ 2026-09-30 新增 ====================
# 170 自动模式（auto）—— 模组开关存在 mods 计分板（不是 options）
execute if score #menu_value menu matches 17001 run function rhythm_axe:options/toggle {key:"auto",obj:"mods"}

# ==================== 页 2 编辑器（行 132~141）====================
# 132 编辑器试听真实判定
execute if score #menu_value menu matches 13201 run function rhythm_axe:options/toggle {key:"editor_note_judge",obj:"options"}
execute if score #menu_value menu matches 13201 if data storage rhythm_axe:maps.editor {playing:1b} run function rhythm_axe:editor/refresh
# 133 编辑器试听事件播放
execute if score #menu_value menu matches 13301 run function rhythm_axe:options/toggle {key:"editor_play_events",obj:"options"}
# 134 【已废弃 2026-09-29】时间轴显示长度：该设置从未被读取（实际长度由客户端按屏幕上报）
#   整项移除 ⇒ 13401/13402 无分支（留空不重排，守卫范围仍涵盖 134xx 无影响）
# 135 【已移除 2026-09-29】每页事件数；136 【已移除】可视化时间轴（由编辑器自动管理）
#   ⇒ 13501/13502/13601 无分支（留空不重排）
# 137 撤销历史上限（1..200，步 10）
execute if score #menu_value menu matches 13701 run function rhythm_axe:options/step {key:"editor_history_limit",delta:-10,min:1,max:200}
execute if score #menu_value menu matches 13702 run function rhythm_axe:options/step {key:"editor_history_limit",delta:10,min:1,max:200}
# 138/139 【已合并挪走 2026-09-29】音乐自动对齐 → 页 2 行 153（13801/13901 无分支）
# 140 音乐同步偏移（-500..500，步 5）
execute if score #menu_value menu matches 14001 run function rhythm_axe:options/step {key:"audio_sync_offset",delta:-5,min:-500,max:500}
execute if score #menu_value menu matches 14002 run function rhythm_axe:options/step {key:"audio_sync_offset",delta:5,min:-500,max:500}
# 141 多人判定延迟补偿（⏸ 已搁置；load reload 会强制置 0）
execute if score #menu_value menu matches 14101 run function rhythm_axe:options/toggle {key:"judge_lag_comp",obj:"options"}

# ==================== 页 3 高级（行 142~153）====================
# 142 调试等级（0..2）
execute if score #menu_value menu matches 14201 run function rhythm_axe:options/step {key:"debug_output",delta:-1,min:0,max:2}
execute if score #menu_value menu matches 14202 run function rhythm_axe:options/step {key:"debug_output",delta:1,min:0,max:2}
# 143 SS 评级线（0..100000，步 1000）
execute if score #menu_value menu matches 14301 run function rhythm_axe:options/step {key:"SS",delta:-1000,min:0,max:100000}
execute if score #menu_value menu matches 14302 run function rhythm_axe:options/step {key:"SS",delta:1000,min:0,max:100000}
# 144 S
execute if score #menu_value menu matches 14401 run function rhythm_axe:options/step {key:"S",delta:-1000,min:0,max:100000}
execute if score #menu_value menu matches 14402 run function rhythm_axe:options/step {key:"S",delta:1000,min:0,max:100000}
# 145 A
execute if score #menu_value menu matches 14501 run function rhythm_axe:options/step {key:"A",delta:-1000,min:0,max:100000}
execute if score #menu_value menu matches 14502 run function rhythm_axe:options/step {key:"A",delta:1000,min:0,max:100000}
# 146 B
execute if score #menu_value menu matches 14601 run function rhythm_axe:options/step {key:"B",delta:-1000,min:0,max:100000}
execute if score #menu_value menu matches 14602 run function rhythm_axe:options/step {key:"B",delta:1000,min:0,max:100000}
# 147 C
execute if score #menu_value menu matches 14701 run function rhythm_axe:options/step {key:"C",delta:-1000,min:0,max:100000}
execute if score #menu_value menu matches 14702 run function rhythm_axe:options/step {key:"C",delta:1000,min:0,max:100000}
# 148 Failed
execute if score #menu_value menu matches 14801 run function rhythm_axe:options/step {key:"Failed",delta:-1000,min:0,max:100000}
execute if score #menu_value menu matches 14802 run function rhythm_axe:options/step {key:"Failed",delta:1000,min:0,max:100000}
# 149~151 判定权重（score_calculate 计分板）
execute if score #menu_value menu matches 14901 run function rhythm_axe:options/step_sc {key:"1th_weight",delta:-1,min:0,max:10}
execute if score #menu_value menu matches 14902 run function rhythm_axe:options/step_sc {key:"1th_weight",delta:1,min:0,max:10}
execute if score #menu_value menu matches 15001 run function rhythm_axe:options/step_sc {key:"2nd_weight",delta:-1,min:0,max:10}
execute if score #menu_value menu matches 15002 run function rhythm_axe:options/step_sc {key:"2nd_weight",delta:1,min:0,max:10}
execute if score #menu_value menu matches 15101 run function rhythm_axe:options/step_sc {key:"3rd_weight",delta:-1,min:0,max:10}
execute if score #menu_value menu matches 15102 run function rhythm_axe:options/step_sc {key:"3rd_weight",delta:1,min:0,max:10}
# 152 伤害扣血冷却（0..200；2026-09-29 从页 0 行 131 挪来）
execute if score #menu_value menu matches 15201 run function rhythm_axe:options/step {key:"damage_cooldown",delta:-1,min:0,max:200}
execute if score #menu_value menu matches 15202 run function rhythm_axe:options/step {key:"damage_cooldown",delta:1,min:0,max:200}
# 153 音乐自动对齐游戏（编辑器试听 + 正式游玩共用；2026-09-29 由 138/139 合并而来）
execute if score #menu_value menu matches 15301 run function rhythm_axe:options/toggle {key:"audio_align",obj:"options"}

# ==================== 改动后重绘 ====================
function rhythm_axe:options/render
