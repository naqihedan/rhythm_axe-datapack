# 下一刻再打开「活跃音符列表」（由 schedule 调用）
#   ★ 粘贴（里头 refresh 会重建全部视觉实体）和列表渲染（两遍遍历 notes + 40 行）挤在同一个 tick 里，
#     会把命令链顶到 maxCommandChainLength = 200000 → 后半段（第二行翻转/镜像/旋转按钮等）被静默丢弃
#   ★ schedule 调用时执行者是服务端、不是玩家 → 必须重新 as 玩家（否则 @s 不存在，所有 tellraw 全丢）
execute as @a[tag=editor_active] run function rhythm_axe:editor/menu/note/list/note_list_open
