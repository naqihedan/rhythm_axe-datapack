# 播放头 +1 并同步镜像与 bossbar；到达结束时间自动暂停
# 注：tick rate 已按谱面速度×播放速度缩放，故每游戏刻 = 谱面 1 刻，+1 即正确
scoreboard players add #playhead editor 1
execute store result storage rhythm_axe:maps.editor playhead int 1 run scoreboard players get #playhead editor
execute store result bossbar rhythm_axe:editor_progress value run scoreboard players get #playhead editor
execute store result score #temp editor run bossbar get rhythm_axe:editor_progress max
# ★ 播放经过时间点（红线）→ 重算当前段 bpm/tpb，变化则更新 tick rate（文档：播放经过红线时随之更新）
#   current_timing 输出 prop.bpm/tpb/bpb；与 #rate_bpm/#rate_tpb（play_ 时记录）不同才执行 tick rate
#   （每刻都算段、只在变化时发 tick rate 命令，避免每刻调整计时字段的累积漂移）
execute store result storage rhythm_axe:prop playhead int 1 run scoreboard players get #playhead editor
execute store result storage rhythm_axe:prop cursor int 1 run data get storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/playback/current_timing
execute store result score #cur_bpm editor run data get storage rhythm_axe:prop bpm 1000
execute store result score #cur_tpb editor run data get storage rhythm_axe:prop tpb
execute store result score #cur_bpb editor run data get storage rhythm_axe:prop bpb
execute store result score #cur_time editor run data get storage rhythm_axe:prop time
execute unless score #cur_bpm editor = #rate_bpm editor run function rhythm_axe:editor/playback/rate_update
execute unless score #cur_tpb editor = #rate_tpb editor run function rhythm_axe:editor/playback/rate_update
# ★ 节拍器：播放中开启时，每拍起点/每小节开头播音
execute if score #metronome editor matches 1 as @a[tag=editor_active] run function rhythm_axe:editor/playback/metronome_check
data remove storage rhythm_axe:prop bpm
data remove storage rhythm_axe:prop tpb
data remove storage rhythm_axe:prop bpb
data remove storage rhythm_axe:prop time
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop playhead
data remove storage rhythm_axe:prop cursor
# ★ 延迟音乐对齐：播放头为负开始的播放，playhead==0 时从 0 播音乐（与音符 time=0 同一刻，同游玩 time==0）
execute if score #playhead editor matches 0 if data storage rhythm_axe:editor.runtime music_wait run execute as @a[tag=editor_active] run function rhythm_axe:editor/playback/music_wait_go
# ★ 到尾自动暂停：先无条件停播放头（避免 @s 为空时整条失效），再对编辑者执行 pause（pausemusic @s 需要玩家）
# 暂停后刷新主菜单：⏸ 变 ▶，避免用户再点"暂停"被 toggle 成重新播放（"暂停不暂停"根因）
execute if score #playhead editor >= #temp editor run data modify storage rhythm_axe:maps.editor playing set value 0b
execute if score #playhead editor >= #temp editor as @a[tag=editor_active] run function rhythm_axe:editor/playback/pause
execute if score #playhead editor >= #temp editor as @a[tag=editor_active] run function rhythm_axe:editor/menu/resume
# 世界音符实时显示：新出生 + 已有实体移动/清理（暂停时不调用本函数）
function rhythm_axe:editor/visual/tick
