# 事件指令对话框【取消】（rhythm_axe:editor_event_cmd 的 exit_action）
#
# 普通编辑（✏ 编辑按钮）：什么都不改，只提示。
# 「快捷操作」入口会先打标记，取消语义分流：
#   模式 1 —— editing.quick_flow + editing.is_new：事件列表【新增一个事件点】且播放头处原本**没有**事件点
#             ⇒ 事件点还没写进谱面 ⇒ 取消 = 什么都不发生：丢弃暂存 editing + 回事件列表
#   模式 2 —— editing.quick_flow（无 is_new）：播放头处**已有**事件点
#             ⇒ 谱面本来就没动，把暂存复原（丢掉自动追加的空指令）后回事件面板，已有事件点完全不变
#   模式 3 —— editing.quick_add：事件面板【添加一个指令】刚追加的那一条
#             ⇒ 删掉刚追加的空指令，再回事件面板（其他暂存内容不变）
# ★ 用计分板先固定模式：后续 `data remove editing` 会把判定条件本身删掉。
# ★ 优先级（重要）：模式 1 最高 —— 新增模式下虽然也追加了空指令（quick_add），
#   但整个事件点都还不存在，取消应当整体丢弃（而非只删那一条）。
scoreboard players set #dc_mode editor 0
execute if data storage rhythm_axe:maps.editor editing.quick_flow if data storage rhythm_axe:maps.editor editing.is_new run scoreboard players set #dc_mode editor 1
execute unless score #dc_mode editor matches 1 if data storage rhythm_axe:maps.editor editing.quick_add run scoreboard players set #dc_mode editor 3
execute unless score #dc_mode editor matches 1 unless score #dc_mode editor matches 3 if data storage rhythm_axe:maps.editor editing.quick_flow run scoreboard players set #dc_mode editor 2

# ── 模式 1：丢弃暂存 + 回事件列表（谱面完全没动）
#   current_panel 先置 5，列表渲染推迟到下一格（列表渲染是 O(谱长) 两遍遍历，见 event_panel_confirm）
execute if score #dc_mode editor matches 1 run data remove storage rhythm_axe:maps.editor editing
execute if score #dc_mode editor matches 1 run data modify storage rhythm_axe:maps.editor current_panel set value 5
execute if score #dc_mode editor matches 1 run data modify storage rhythm_axe:maps.editor feedback set value "已取消，未创建事件点"
execute if score #dc_mode editor matches 1 run data modify storage rhythm_axe:maps.editor no_undo set value 1b
execute if score #dc_mode editor matches 1 run schedule function rhythm_axe:editor/menu/event/list/event_list_open_next 1t
execute if score #dc_mode editor matches 1 run return 0

# ── 模式 2：暂存复原 + 回事件面板（已有事件点完全不变）
execute if score #dc_mode editor matches 2 run data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
execute if score #dc_mode editor matches 2 run data modify storage rhythm_axe:prop index set from storage rhythm_axe:maps.editor editing.ref
execute if score #dc_mode editor matches 2 run function rhythm_axe:editor/menu/event/panel/event_panel_quick_revert with storage rhythm_axe:prop
execute if score #dc_mode editor matches 2 run data remove storage rhythm_axe:prop cursor
execute if score #dc_mode editor matches 2 run data remove storage rhythm_axe:prop index
execute if score #dc_mode editor matches 2 run data remove storage rhythm_axe:maps.editor editing.quick_flow
execute if score #dc_mode editor matches 2 run data modify storage rhythm_axe:maps.editor feedback set value "已取消输入"
execute if score #dc_mode editor matches 2 run data modify storage rhythm_axe:maps.editor no_undo set value 1b
execute if score #dc_mode editor matches 2 run function rhythm_axe:editor/menu/event/panel/event_panel
execute if score #dc_mode editor matches 2 run return 0

# ── 模式 3：删掉刚追加的空指令 + 回事件面板
execute if score #dc_mode editor matches 3 run data modify storage rhythm_axe:prop cmd_target set from storage rhythm_axe:maps.editor editing.quick_add
execute if score #dc_mode editor matches 3 run function rhythm_axe:editor/menu/event/panel/event_panel_cmd_delete_ with storage rhythm_axe:prop
execute if score #dc_mode editor matches 3 run data remove storage rhythm_axe:prop cmd_target
execute if score #dc_mode editor matches 3 run data remove storage rhythm_axe:maps.editor editing.quick_add
execute if score #dc_mode editor matches 3 run data remove storage rhythm_axe:maps.editor editing.quick_flow
execute if score #dc_mode editor matches 3 run data remove storage rhythm_axe:maps.editor editing.cmd_target
execute if score #dc_mode editor matches 3 run data modify storage rhythm_axe:maps.editor feedback set value "已取消输入"
execute if score #dc_mode editor matches 3 run data modify storage rhythm_axe:maps.editor no_undo set value 1b
execute if score #dc_mode editor matches 3 run function rhythm_axe:editor/menu/event/panel/event_panel
execute if score #dc_mode editor matches 3 run return 0

# ── 默认（普通编辑/无标记）：什么都不改，只提示
tellraw @s [{"text":"[编辑器] 已取消输入","color":"yellow"}]