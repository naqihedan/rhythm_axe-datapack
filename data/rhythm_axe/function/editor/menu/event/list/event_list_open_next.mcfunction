# 事件列表「下一刻渲染」包装（跨刻安全调用 rhythm_axe:editor/menu/event/list/event_list_open）
# ★ 事件列表渲染与前面的 refresh（整表重建视觉）不要挤在同一命令链里；
#   `schedule` 拉起时执行者是服务端（没有 @s），必须切回「正在用编辑器的玩家」。
# 用法：`schedule function rhythm_axe:editor/menu/event/list/event_list_open_next 1t`
execute as @a[tag=editor_active] run function rhythm_axe:editor/menu/event/list/event_list_open
