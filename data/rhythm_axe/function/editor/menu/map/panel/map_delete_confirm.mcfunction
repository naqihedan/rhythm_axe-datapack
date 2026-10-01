# 【删除谱面】（10404）：弹**原生确认框**（★ 2026-10-01 用户要求：统一用这个删除对话框）
#   确认后 → ops/do_delete（kind=map → 移入回收站 + 退出编辑器）；取消 → ops/do_delete_cancel
#   ⚠️ 会话缺少 mapid 时给明确提示：否则 pending_del 写不进去、点了没反应
#   （旧的聊天栏确认面板 map_delete_confirm_ / panel16 保留但不再调用，这里换成原生对话框）
execute unless data storage rhythm_axe:maps.editor mapid run tellraw @s [{"text":"[编辑器] 当前会话缺少谱面 id（mapid），无法删除","color":"red"}]
execute unless data storage rhythm_axe:maps.editor mapid run tellraw @s [{"text":"请退出编辑器后重新打开该谱面再试","color":"yellow"}]
execute unless data storage rhythm_axe:maps.editor mapid run return fail
data modify storage rhythm_axe:maps.editor pending_del set value {}
data modify storage rhythm_axe:maps.editor pending_del.kind set value "map"
data modify storage rhythm_axe:maps.editor pending_del.mapid set from storage rhythm_axe:maps.editor mapid
data modify storage rhythm_axe:maps.editor pending_del.detail set value "把当前谱面移入回收站？\n（之后可以在【回收站】里还原；保存过的内容才会进回收站）"
function rhythm_axe:editor/menu/ops/confirm_delete
