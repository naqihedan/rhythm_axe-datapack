# 对话框取消：仅提示，不改动任何暂存（默认路径）
#
# ★ 兼容转发（2026-11-08）：事件指令对话框（rhythm_axe:editor_event_cmd）由「快捷操作」入口弹出
#   （事件列表【新增一个事件点】/ 事件面板【添加一个指令】）弹出时，会打 editing.quick_flow / editing.quick_add
#   标记 —— 此时必须走真正的取消分流（丢弃暂存 / 撤销刚追加的指令）。
#   ⚠️ 为什么写在这里：dialog JSON 属**注册表数据**，`/reload` **不会**重载它 ⇒ 已改好的
#   `editor_event_cmd.json` 的 exit_action 要**重启世界**才生效；在那之前旧 JSON 仍把【取消】
#   指到本函数。加这句转发 ⇒ 新旧两种指向都能正确取消，不用等重启。
#   其他对话框（标题/曲师/音乐…）不带这些标记，行为完全不变。
execute if data storage rhythm_axe:maps.editor editing.quick_flow run return run function rhythm_axe:editor/menu/event/dialog/dialog_cancel_event_cmd
execute if data storage rhythm_axe:maps.editor editing.quick_add run return run function rhythm_axe:editor/menu/event/dialog/dialog_cancel_event_cmd

tellraw @s [{"text":"[编辑器] 已取消输入","color":"yellow"}]
