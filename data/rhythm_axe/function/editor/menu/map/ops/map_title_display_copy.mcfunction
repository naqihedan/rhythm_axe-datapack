# 行100 列码03【复制展示实体文字信息】（2026-10-01）
# 把展示实体的文字搬成谱面标题：用 set from entity 直接搬 NBT 文字组件 —— 不用转义，
# 颜色/样式原样保留；只改暂存副本 panel_temp，需在面板点【保存设置】才写回谱面。
# ① 展示实体不在（60 秒到期 / 已关闭面板）→ 提示后中止
execute unless entity @e[tag=rhythm_axe_title_display] run return run tellraw @s [{"text":"[编辑器] ","color":"green"},{"text":"展示实体已消失（60 秒到期或已关闭面板），请重新点【生成文本展示实体】","color":"red"}]
# ② 换行检测：标题含换行会撑坏面板行 / bossbar / 结算行 → 拒绝（在 Axiom 里改回单行再点）
#    先逐层剥出候选字符串（字符串本身 / {text:…} / [{text:…}]，后一条取不到就保留前一条），
#    再逐字符扫描找换行。`#title_nl` = 1 正常 / 0 命中换行（扫描原理见 map_title_nl_scan 文件头）
scoreboard players set #title_nl editor 1
data remove storage rhythm_axe:prop title_nl_cand
execute at @s run data modify storage rhythm_axe:prop title_nl_cand set from entity @e[tag=rhythm_axe_title_display,limit=1,sort=nearest] text
execute at @s run data modify storage rhythm_axe:prop title_nl_cand set from entity @e[tag=rhythm_axe_title_display,limit=1,sort=nearest] text.text
execute at @s run data modify storage rhythm_axe:prop title_nl_cand set from entity @e[tag=rhythm_axe_title_display,limit=1,sort=nearest] text[0].text
data remove storage rhythm_axe:prop title_nl_ch
execute store result score #title_nl_len editor run data get storage rhythm_axe:prop title_nl_cand
# 病态超长输入只扫前 1000 字符（标题不可能这么长；再长的话换行漏检可接受）
# ⚠️ 字面量比较必须用 matches（`if score X obj > 1000` 非法：右侧要「目标+计分板」，写成它会整个函数加载失败）
execute if score #title_nl_len editor matches 1001.. run scoreboard players set #title_nl_len editor 1000
scoreboard players set #title_nl_i editor 0
scoreboard players set #title_nl_j editor 1
data modify storage rhythm_axe:prop title_nl_i set value 0
data modify storage rhythm_axe:prop title_nl_j set value 1
execute if data storage rhythm_axe:prop title_nl_cand run function rhythm_axe:editor/menu/map/ops/map_title_nl_scan with storage rhythm_axe:prop
data remove storage rhythm_axe:prop title_nl_cand
data remove storage rhythm_axe:prop title_nl_ch
data remove storage rhythm_axe:prop title_nl_i
data remove storage rhythm_axe:prop title_nl_j
execute if score #title_nl editor matches 0 run return run tellraw @s [{"text":"[编辑器] ","color":"green"},{"text":"标题不能含换行——请在 Axiom 里改成单行后重试","color":"red"}]
# ③ 搬到暂存 → 清实体 → 提示 → 刷面板
#    排版：手动「清屏 → 反馈 → 面板」，让反馈落在十行换行**下面**（和面板其它反馈一致）；
#    `skip_clear` 让随后的 map_panel 不再重复清屏（用完立刻删）
execute at @s run data modify storage rhythm_axe:maps.editor panel_temp.title set from entity @e[tag=rhythm_axe_title_display,limit=1,sort=nearest] text
function rhythm_axe:editor/menu/map/ops/map_title_display_clear
data modify storage rhythm_axe:maps.editor no_undo set value 1b
data modify storage rhythm_axe:maps.editor skip_clear set value 1b
function rhythm_axe:editor/menu/clear_lines
tellraw @s [{"text":"[编辑器] ","color":"green"},{"text":"已将谱面标题设为 ","color":"white"},{"nbt":"panel_temp.title","storage":"rhythm_axe:maps.editor","interpret":true},{"text":"，点击保存设置应用更改","color":"white"}]
function rhythm_axe:editor/menu/map/panel/map_panel_refresh
data remove storage rhythm_axe:maps.editor skip_clear
