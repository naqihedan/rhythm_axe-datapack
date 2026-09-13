#arg: cursor
# 主菜单播放进度条（在播放控件行下方）：51 个 '='，未播放灰色 / 已播放黄绿 / 播放头那格黄色
# 前 50 格把 end_time 等分，第 51 格是「跳到结尾」捷径；点第 i 格跳到该格左端时刻 → 见 editor/menu/progress/click
# 调用方式：先设 prop.cursor = history_cursor，再 function .../line with storage rhythm_axe:prop
# 顺带算好 #prog_head（当前刻）/ #prog_end（最终刻，未定义时 = -1）供节拍器行显示
# 总长 = 工作副本 end_time（未定义 → 整条灰 + 提示，不可点）
scoreboard players set #prog_end editor -1
execute store result score #prog_head editor run data get storage rhythm_axe:maps.editor playhead
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].end_time run tellraw @s [{"text":"===================================================","color":"gray"},{"text":"  （未定义谱面结束时间）","color":"dark_gray","italic":true}]
$execute unless data storage rhythm_axe:maps.editor history[$(cursor)].end_time run return 0
$execute store result score #prog_end editor run data get storage rhythm_axe:maps.editor history[$(cursor)].end_time
# 已播放格数 = 播放头 × 50 ÷ 总长（下取整）；播放头格 = 已播放格数 + 1（钳到 51，格 51 = 结尾捷径）
scoreboard players operation #prog_fill editor = #prog_head editor
scoreboard players set #prog_tmp editor 50
scoreboard players operation #prog_fill editor *= #prog_tmp editor
scoreboard players operation #prog_fill editor /= #prog_end editor
scoreboard players operation #prog_mark editor = #prog_fill editor
scoreboard players add #prog_mark editor 1
execute if score #prog_mark editor matches 52.. run scoreboard players set #prog_mark editor 51
# 逐格拼接 JSON 组件串，最后由 $(pro) 整行注入 tellraw（emit）
data modify storage rhythm_axe:prop pro set value ""
scoreboard players set #i editor 1
function rhythm_axe:editor/menu/progress/drive
function rhythm_axe:editor/menu/progress/emit with storage rhythm_axe:prop
data remove storage rhythm_axe:prop pro
data remove storage rhythm_axe:prop col
data remove storage rhythm_axe:prop pad
data remove storage rhythm_axe:prop comma
data remove storage rhythm_axe:prop i
