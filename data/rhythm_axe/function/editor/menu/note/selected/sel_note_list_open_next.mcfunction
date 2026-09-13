# 下一刻再打开「已选定音符列表」（由 schedule 调用）
#   ★ 粘贴（含 refresh 重建视觉）与列表渲染同 tick 会撞 maxCommandChainLength = 200000 → 拆到下一 tick
#   ★ schedule 调用时执行者是服务端 → 必须重新 as 玩家（否则 @s 不存在，tellraw 全丢）
execute as @a[tag=editor_active] run function rhythm_axe:editor/menu/note/selected/sel_note_list_open
