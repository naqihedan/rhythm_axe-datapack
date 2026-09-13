# 下一刻再回来源面板（由 schedule 调用，独立命令链）：只做面板列表渲染 + 反馈
# 前置：#from editor 已设置；★ schedule 调用时执行者是服务端 → 必须重新 as 玩家（否则 @s 不存在、tellraw 全丢）
execute as @a[tag=editor_active] run function rhythm_axe:editor/menu/note/panel/note_panel_return
