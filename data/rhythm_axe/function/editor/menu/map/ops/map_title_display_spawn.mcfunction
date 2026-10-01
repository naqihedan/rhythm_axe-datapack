# 行100 列码02【生成文本展示实体】（2026-10-01）
# 在玩家面前（^ ^ ^1，以眼睛为基准）生成一个文本展示实体，供 Axiom 等工具改文字；
# 玩家改好后点【复制展示实体文字信息】即把文字搬成谱面标题。
# 生命周期：60 秒到期 / 点【复制】/ 关闭谱面设置面板 → 清除
#   （见 map_title_display_timeout / map_title_display_clear，reload 时也会清残留）
# 重复点击：先清掉旧实体与旧计时，再生成并重置 60 秒计时（schedule … replace）
function rhythm_axe:editor/menu/map/ops/map_title_display_clear
execute at @s anchored eyes positioned ^ ^ ^1 run summon minecraft:text_display ~ ~ ~ {\
Tags:["rhythm_axe_title_display"],\
text:{text:"用Axiom更改文字内容，点击复制按钮设为标题，点击保存设置应用更改"},\
billboard:"center",alignment:"center",see_through:1b,Glowing:1b,brightness:{block:15,sky:15}}
schedule function rhythm_axe:editor/menu/map/ops/map_title_display_timeout 1200t replace
# 只改 UI/暂存，不进撤销历史 → 打 no_undo（反馈走纯文本）
data modify storage rhythm_axe:maps.editor no_undo set value 1b
data modify storage rhythm_axe:maps.editor feedback set value "已生成展示实体：用 Axiom 改好文字后点【复制展示实体文字信息】（60 秒内）"
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
