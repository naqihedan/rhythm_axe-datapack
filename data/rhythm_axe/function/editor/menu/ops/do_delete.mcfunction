# 原生确认框的【删除】：按 maps.editor.pending_del.kind 执行真正的删除 —— **只有这里会删**
#   kind=timing        → editor/timing/delete（删时间点，自带 begin/commit/scale_sync，可撤销）
#   kind=event         → editor/event/delete（删事件点，自带 begin/commit，可撤销）
#   kind=map           → editor/file/delete（移入回收站）+ 退出编辑器（复刻原 map_delete_go 的行为）
#   kind=trash_delete  → trash_delete_go（彻底删回收站条目 + 清该谱排行榜数据）
#   kind=trash_restore → trash_restore_go（用回收站版本覆盖同名谱面）
# 下游函数都从 prop 读参数（index / mapid），所以先把 pending_del 里的参数搬过去；末尾统一清干净。
execute unless data storage rhythm_axe:maps.editor pending_del.kind run return fail
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop mapid
execute if data storage rhythm_axe:maps.editor pending_del.index run data modify storage rhythm_axe:prop index set from storage rhythm_axe:maps.editor pending_del.index
execute if data storage rhythm_axe:maps.editor pending_del.mapid run data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor pending_del.mapid
execute if data storage rhythm_axe:maps.editor {pending_del:{kind:"timing"}} run function rhythm_axe:editor/timing/delete
execute if data storage rhythm_axe:maps.editor {pending_del:{kind:"event"}} run function rhythm_axe:editor/event/delete
execute if data storage rhythm_axe:maps.editor {pending_del:{kind:"map"}} run function rhythm_axe:editor/file/delete with storage rhythm_axe:prop
execute if data storage rhythm_axe:maps.editor {pending_del:{kind:"map"}} run function rhythm_axe:editor/exit_do
execute if data storage rhythm_axe:maps.editor {pending_del:{kind:"trash_delete"}} run function rhythm_axe:editor/menu/trash/trash_delete_go with storage rhythm_axe:prop
execute if data storage rhythm_axe:maps.editor {pending_del:{kind:"trash_restore"}} run function rhythm_axe:editor/menu/trash/trash_restore_go with storage rhythm_axe:prop
data remove storage rhythm_axe:maps.editor pending_del
data remove storage rhythm_axe:prop index
data remove storage rhythm_axe:prop mapid
