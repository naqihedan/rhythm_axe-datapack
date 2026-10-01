# 本局参与者身份采集（@s = 参与者；必须在 end_of_game 清空名单（team leave）之前调用）
# 原理：原版读不到玩家的 name / UUID 字符串（玩家实体 NBT 里没有名字字段）。
#   但 text_display 的 text 标签会做「文本组件解析」（wiki: Text component format → Component resolution
#   明确列出「Writing a text component to a text display's text tag」），于是
#   {"selector":"@p"} 会被展开为**已解析**组件：
#     {text:"名字", insertion:"名字", click_event:{...}, hover_event:{action:"show_entity",id:"minecraft:player",uuid:[I;..],name:"名字"}}
#   ⇒ 这是原版把「玩家名 + 稳定 UUID」写进 storage 的唯一途径。
#   ⚠ 选择器 @p 相对「展示实体」（就在玩家脚下）解析；队友同格极罕见，可接受。
tag @s add ra_id_probe
execute at @s run summon minecraft:text_display ~ ~ ~ {Tags:["ra_id_tmp"],text:{selector:"@p"}}
execute at @s run data modify storage rhythm_axe:runtime pid set from entity @e[type=text_display,tag=ra_id_tmp,limit=1] text
kill @e[type=text_display,tag=ra_id_tmp]
tag @s remove ra_id_probe
# 解析失败（组件结构变化 / 没解析出玩家）→ 跳过该玩家，给一条警告（宁可不记，也不要写坏数据）
execute unless data storage rhythm_axe:runtime pid run tellraw @a [{"text":"[节奏地图] 警告：读取玩家身份失败，本局不为该玩家记录最高分","color":"yellow"}]
execute unless data storage rhythm_axe:runtime pid run return fail
execute unless data storage rhythm_axe:runtime pid.hover_event.uuid run tellraw @a [{"text":"[节奏地图] 警告：玩家身份里没有 UUID，本局不为该玩家记录最高分","color":"yellow"}]
execute unless data storage rhythm_axe:runtime pid.hover_event.uuid run return fail
# 拆出 4 个 UUID int（键 = "<u0>-<u1>-<u2>-<u3>"：只含数字与 - ⇒ NBT 路径可裸写，不用引号）
execute store result storage rhythm_axe:prop u0 int 1 run data get storage rhythm_axe:runtime pid.hover_event.uuid[0]
execute store result storage rhythm_axe:prop u1 int 1 run data get storage rhythm_axe:runtime pid.hover_event.uuid[1]
execute store result storage rhythm_axe:prop u2 int 1 run data get storage rhythm_axe:runtime pid.hover_event.uuid[2]
execute store result storage rhythm_axe:prop u3 int 1 run data get storage rhythm_axe:runtime pid.hover_event.uuid[3]
# 名字：优先解析出的 text；兜底 hover_event.name；再兜底 "?"
# ★ 2026-10-01 用户实测踩到 name:"" —— 空串也算「没拿到」：`execute unless data` 只查**存在性**，
#   空串是存在的 ⇒ 必须显式判空后删掉重取，否则会往排行榜写一个无名条目（行里名字位置就空了）。
data remove storage rhythm_axe:prop name
data modify storage rhythm_axe:prop name set from storage rhythm_axe:runtime pid.text
execute if data storage rhythm_axe:prop {name:""} run data remove storage rhythm_axe:prop name
execute unless data storage rhythm_axe:prop name run data modify storage rhythm_axe:prop name set from storage rhythm_axe:runtime pid.hover_event.name
execute if data storage rhythm_axe:prop {name:""} run data remove storage rhythm_axe:prop name
execute unless data storage rhythm_axe:prop name run data modify storage rhythm_axe:prop name set value "?"
# 诊断：把原始 pid 留一份（只留最后一次，供排查「名字为空/名字异常」；不清理）
data remove storage rhythm_axe:runtime pid_dbg
data modify storage rhythm_axe:runtime pid_dbg set from storage rhythm_axe:runtime pid
function rhythm_axe:play/highscore/append_ with storage rhythm_axe:prop
data remove storage rhythm_axe:runtime pid
data remove storage rhythm_axe:prop u0
data remove storage rhythm_axe:prop u1
data remove storage rhythm_axe:prop u2
data remove storage rhythm_axe:prop u3
data remove storage rhythm_axe:prop name
