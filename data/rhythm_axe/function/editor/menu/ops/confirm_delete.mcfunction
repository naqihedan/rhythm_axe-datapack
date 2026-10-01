# 弹出「删除二次确认」原生确认框（自己什么也不删）
# 调用约定：调用方先写好 rhythm_axe:maps.editor 的 pending_del，再调本函数
#   pending_del.kind   = 删除类型（timing / event / map / trash_delete / trash_restore，分发见 ops/do_delete）
#   pending_del.detail = 确认框正文（各入口把「删什么 + 能否恢复」写清楚）
#   pending_del.cursor / index / mapid = 下游要用的参数
# 【删除】→ ops/do_delete（按 kind 分发） / 【取消】→ ops/do_delete_cancel（清标记）
# ⚠️ 新增或改动 data/rhythm_axe/dialog/*.json 需要**重启世界**才会加载（/reload 不重读 dialog 注册表，见《AI常见问题》）
dialog show @s rhythm_axe:editor_confirm_delete
