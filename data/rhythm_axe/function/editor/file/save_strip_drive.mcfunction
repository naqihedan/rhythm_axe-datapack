# 遍历 maps.(prop.mapid).notes 移除 selected（普通驱动器 + 宏叶子，防宏递归重跑）
# ★ 2026-09-14：曾改为「逐元素存在性探测」以免取长度序列化整表，但实测 `execute store success` 在
#   「根片段不存在」时**不会写值** → 单独调用时会无限递归（靠 maxCommandChainLength 兜住，代价是一次巨卡）。
#   保存不是性能热点，已回滚为「取长度 + 按长度遍历」。
#   防呆：下标超上限直接停（防止将来被误调用时无限递归）。
execute if score #i editor matches 1000000.. run return 0
execute if score #i editor >= #notes_len editor run return 0
execute store result storage rhythm_axe:prop i int 1 run scoreboard players get #i editor
function rhythm_axe:editor/file/save_strip_leaf with storage rhythm_axe:prop
scoreboard players add #i editor 1
function rhythm_axe:editor/file/save_strip_drive
