# 行100 列码02【生成文本展示实体】（2026-10-01；★ 2026-11-07 预填当前标题）
# 在玩家面前（^ ^ ^1，以眼睛为基准）生成一个文本展示实体，供 Axiom 等工具改文字；
# 玩家改好后点【应用展示实体文字信息】即把文字搬成谱面标题。
# ★ 2026-11-07：谱面**已有非默认标题**时，展示实体的初始文字 = 该标题本身
#   （不再固定占位提示语，方便在已有标题上继续改）。
#   默认标题（缺失 / "" / {"text":""} / "(无标题)"）→ 仍用原占位提示语。
#   文字写入按标题形态分三路（都在 summon 之后写，避免裸文本里含引号时宏拼坏命令）：
#     · 复合 / 列表 NBT → `text set from storage`（整块搬，逐字渐变等样式原样保留）
#     · 裸纯文本字符串 → 先包成字面组件 {text:..,color:white} 再搬（任何引号/反斜杠都安全）
#     · JSON 组件字符串（首字符 { [ "）→ 宏 `text set value $(json)`，由游戏解析成真组件（保留颜色/样式）
# 生命周期：60 秒到期 / 点【应用展示实体文字信息】/ 关闭谱面设置面板 → 清除
#   （见 map_title_display_timeout / map_title_display_clear，reload 时也会清残留）
# 重复点击：先清掉旧实体与旧计时，再生成并重置 60 秒计时（schedule … replace）
function rhythm_axe:editor/menu/map/ops/map_title_display_clear

# —— ① 判定「已有非默认标题」： #td_use = 1 表示要预填 ——
scoreboard players set #td_use editor 1
scoreboard players set #td_kind editor 2
data remove storage rhythm_axe:prop td_ch
data remove storage rhythm_axe:prop td_json
data remove storage rhythm_axe:prop td_wrap
execute unless data storage rhythm_axe:maps.editor panel_temp.title run scoreboard players set #td_use editor 0
execute if data storage rhythm_axe:maps.editor {panel_temp:{title:""}} run scoreboard players set #td_use editor 0
execute if data storage rhythm_axe:maps.editor {panel_temp:{title:"(无标题)"}} run scoreboard players set #td_use editor 0
execute if data storage rhythm_axe:maps.editor {panel_temp:{title:{text:""}}} run scoreboard players set #td_use editor 0
# 新建谱面的默认标题是字符串形态的空组件（map_panel_init 补的 "{\"text\":\"\"}"）
execute if data storage rhythm_axe:maps.editor {panel_temp:{title:"{\"text\":\"\"}"}} run scoreboard players set #td_use editor 0
# 形态判定（#td_kind）：2 = 复合/列表 NBT；0 = 裸纯文本字符串；1 = JSON 组件字符串
# 取标题首字符（非字符串时 set string 失败 ⇒ 保持哨兵 "??" ⇒ 判为 NBT）
data modify storage rhythm_axe:prop td_ch set value "??"
data modify storage rhythm_axe:prop td_ch set string storage rhythm_axe:maps.editor panel_temp.title 0 1
execute unless data storage rhythm_axe:prop {td_ch:"??"} run scoreboard players set #td_kind editor 0
execute if data storage rhythm_axe:prop {td_ch:"{"} run scoreboard players set #td_kind editor 1
execute if data storage rhythm_axe:prop {td_ch:"["} run scoreboard players set #td_kind editor 1
execute if data storage rhythm_axe:prop {td_ch:"\""} run scoreboard players set #td_kind editor 1
data remove storage rhythm_axe:prop td_ch
# 裸纯文本 → 先包成字面组件（NBT 里存字符串，任何引号/反斜杠都安全）
data modify storage rhythm_axe:prop td_wrap set value {text:"",color:"white"}
execute if score #td_kind editor matches 0 run data modify storage rhythm_axe:prop td_wrap.text set from storage rhythm_axe:maps.editor panel_temp.title
# JSON 组件字符串 → 留着给宏注入（解析成真组件，保留颜色/样式）
execute if score #td_kind editor matches 1 run data modify storage rhythm_axe:prop td_json set from storage rhythm_axe:maps.editor panel_temp.title

# —— ② 生成实体（先出占位，非默认标题随后写入文字）——
execute at @s anchored eyes positioned ^ ^ ^1 run summon minecraft:text_display ~ ~ ~ {\
Tags:["rhythm_axe_title_display"],\
text:"",\
billboard:"center",alignment:"center",see_through:1b,Glowing:1b,brightness:{block:15,sky:15}}
# 预填：复合/列表 NBT → 整块搬
execute if score #td_use editor matches 1 if score #td_kind editor matches 2 at @s run data modify entity @e[tag=rhythm_axe_title_display,limit=1,sort=nearest] text set from storage rhythm_axe:maps.editor panel_temp.title
# 预填：裸纯文本 → 搬包装后的字面组件
execute if score #td_use editor matches 1 if score #td_kind editor matches 0 at @s run data modify entity @e[tag=rhythm_axe_title_display,limit=1,sort=nearest] text set from storage rhythm_axe:prop td_wrap
# 预填：JSON 组件字符串 → 宏注入解析
execute if score #td_use editor matches 1 if score #td_kind editor matches 1 at @s run function rhythm_axe:editor/menu/map/ops/map_title_display_set_json with storage rhythm_axe:prop
# 默认标题 → 原占位提示语
execute if score #td_use editor matches 0 run data modify entity @e[tag=rhythm_axe_title_display,limit=1,sort=nearest] text set value {text:"用Axiom更改文字内容，点击复制按钮设为标题，点击保存设置应用更改"}
data remove storage rhythm_axe:prop td_json
data remove storage rhythm_axe:prop td_wrap

schedule function rhythm_axe:editor/menu/map/ops/map_title_display_timeout 1200t replace
# 只改 UI/暂存，不进撤销历史 → 打 no_undo（反馈走纯文本）
data modify storage rhythm_axe:maps.editor no_undo set value 1b
data modify storage rhythm_axe:maps.editor feedback set value "已生成展示实体：用 Axiom 改好文字后点【应用展示实体文字信息】（60 秒内）"
execute if score #td_use editor matches 1 run data modify storage rhythm_axe:maps.editor feedback set value "已生成展示实体（文字已填入当前标题）：用 Axiom 改好后点【应用展示实体文字信息】（60 秒内）"
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
