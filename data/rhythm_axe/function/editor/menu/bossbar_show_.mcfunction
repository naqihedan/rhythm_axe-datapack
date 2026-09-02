#arg:cursor
# 编辑器打开期间 bossbar 一直显示：名称=谱面标题（宏传，26.x nbt interpret 不解析）、可见对象、值、最大值
$execute if data storage rhythm_axe:maps.editor history[$(cursor)].title run data modify storage rhythm_axe:prop title set from storage rhythm_axe:maps.editor history[$(cursor)].title
# ★ title 若为复合 {text:...}，宏 $(title) 传不了（bossbar 名称不显示）→ 清洗为字符串（与 main_header 一致）
execute if data storage rhythm_axe:prop title.text run data modify storage rhythm_axe:prop title set from storage rhythm_axe:prop title.text
execute if data storage rhythm_axe:prop title run function rhythm_axe:editor/menu/bossbar_name with storage rhythm_axe:prop
execute unless data storage rhythm_axe:prop title run bossbar set rhythm_axe:editor_progress name {"text":"播放进度"}
data remove storage rhythm_axe:prop title
bossbar set rhythm_axe:editor_progress players @a
bossbar set rhythm_axe:editor_progress visible true
execute store result bossbar rhythm_axe:editor_progress value run scoreboard players get #playhead editor
# 进度条颜色（0白 1粉 2蓝 3红 4绿 5黄 6紫；缺省 0 白；bossbar 支持色）
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].progress_color
execute if score #temp editor matches 1 run bossbar set rhythm_axe:editor_progress color pink
execute if score #temp editor matches 2 run bossbar set rhythm_axe:editor_progress color blue
execute if score #temp editor matches 3 run bossbar set rhythm_axe:editor_progress color red
execute if score #temp editor matches 4 run bossbar set rhythm_axe:editor_progress color green
execute if score #temp editor matches 5 run bossbar set rhythm_axe:editor_progress color yellow
execute if score #temp editor matches 6 run bossbar set rhythm_axe:editor_progress color purple
execute unless score #temp editor matches 1..6 run bossbar set rhythm_axe:editor_progress color white
$execute store result score #temp editor run data get storage rhythm_axe:maps.editor history[$(cursor)].end_time
execute if score #temp editor matches 1.. run execute store result bossbar rhythm_axe:editor_progress max run scoreboard players get #temp editor
