#arg:mapid
# 打开收尾：谱面快照进 history[0] → 传送到 spawn_pos → 反馈（@s = 玩家）
$data modify storage rhythm_axe:maps.editor mapid set value "$(mapid)"
$data modify storage rhythm_axe:maps.editor history append from storage rhythm_axe:maps.$(mapid)

# ★ 打开已有谱面后同步 next_note_id = 最大 id + 1（否则新音符 id 会与已有音符冲突，产生重复 id）
function rhythm_axe:editor/util/scan_next_id

# 拆初始位置标量到 prop（宏参数通道，用后即删；旧谱面缺字段时补 0）
$execute if data storage rhythm_axe:maps.$(mapid) spawn_x run data modify storage rhythm_axe:prop spawn_x set from storage rhythm_axe:maps.$(mapid) spawn_x
$execute unless data storage rhythm_axe:maps.$(mapid) spawn_x run data modify storage rhythm_axe:prop spawn_x set value 0.0d
$execute if data storage rhythm_axe:maps.$(mapid) spawn_y run data modify storage rhythm_axe:prop spawn_y set from storage rhythm_axe:maps.$(mapid) spawn_y
$execute unless data storage rhythm_axe:maps.$(mapid) spawn_y run data modify storage rhythm_axe:prop spawn_y set value 0.0d
$execute if data storage rhythm_axe:maps.$(mapid) spawn_z run data modify storage rhythm_axe:prop spawn_z set from storage rhythm_axe:maps.$(mapid) spawn_z
$execute unless data storage rhythm_axe:maps.$(mapid) spawn_z run data modify storage rhythm_axe:prop spawn_z set value 0.0d
$execute if data storage rhythm_axe:maps.$(mapid) spawn_yaw run data modify storage rhythm_axe:prop spawn_yaw set from storage rhythm_axe:maps.$(mapid) spawn_yaw
$execute unless data storage rhythm_axe:maps.$(mapid) spawn_yaw run data modify storage rhythm_axe:prop spawn_yaw set value 0.0d
$execute if data storage rhythm_axe:maps.$(mapid) spawn_pitch run data modify storage rhythm_axe:prop spawn_pitch set from storage rhythm_axe:maps.$(mapid) spawn_pitch
$execute unless data storage rhythm_axe:maps.$(mapid) spawn_pitch run data modify storage rhythm_axe:prop spawn_pitch set value 0.0d
# 按谱面传送开关决定是否传送（未开启静默不传送）
$execute if data storage rhythm_axe:maps.$(mapid) teleport run data modify storage rhythm_axe:prop teleport set from storage rhythm_axe:maps.$(mapid) teleport
execute store result score #temp editor run data get storage rhythm_axe:prop teleport
execute if score #temp editor matches 1 run function rhythm_axe:editor/tp_to_spawn with storage rhythm_axe:prop
data remove storage rhythm_axe:prop teleport
data remove storage rhythm_axe:prop spawn_x
data remove storage rhythm_axe:prop spawn_y
data remove storage rhythm_axe:prop spawn_z
data remove storage rhythm_axe:prop spawn_yaw
data remove storage rhythm_axe:prop spawn_pitch

# 标题用宏传（26.x nbt interpret 不解析，会显示原始 JSON）；history[0] 固定无宏参数，此行不加 $
data modify storage rhythm_axe:prop title set from storage rhythm_axe:maps.editor history[0].title
# ★ title 若为复合 {text:...}，宏 $(title) 传不了（反馈标题不显示）→ 清洗为字符串
execute if data storage rhythm_axe:prop title.text run data modify storage rhythm_axe:prop title set from storage rhythm_axe:prop title.text
function rhythm_axe:editor/finish_open_title with storage rhythm_axe:prop
data remove storage rhythm_axe:prop title

# ★ 打开即预热音乐解码（后台解码整首 OGG，之后的 playmusic 缓存命中零延迟）
$execute if data storage rhythm_axe:maps.$(mapid) music run data modify storage rhythm_axe:prop music set from storage rhythm_axe:maps.$(mapid) music
execute if data storage rhythm_axe:prop music run function rhythm_axe:editor/playback/preload_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop music

# 播放头回到开头（= min(0, 最早出生)-1，与游玩一致）再刷新视觉
function rhythm_axe:editor/visual/seek_start
# 恢复编辑器保存的播放头位置（旧谱面无该字段则保留 seek_start 的开头位置）
$execute if data storage rhythm_axe:maps.$(mapid) editor_playhead run data modify storage rhythm_axe:maps.editor playhead set from storage rhythm_axe:maps.$(mapid) editor_playhead
execute store result score #playhead editor run data get storage rhythm_axe:maps.editor playhead
execute store result bossbar rhythm_axe:editor_progress value run scoreboard players get #playhead editor
function rhythm_axe:editor/visual/progress_actionbar
# 显示聊天栏主菜单（点击 /trigger editor_click 不弹确认窗）
function rhythm_axe:editor/refresh
function rhythm_axe:editor/menu/main
