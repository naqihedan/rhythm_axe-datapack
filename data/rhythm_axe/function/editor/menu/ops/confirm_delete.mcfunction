# 弹出「删除二次确认」对话框（自己什么也不删）
# 调用约定：调用方先写好 rhythm_axe:maps.editor 的 pending_del，再调本函数
#   pending_del.kind   = 删除类型（map / trash_delete / trash_restore，分发见 ops/do_delete）
#   pending_del.detail = 确认框正文（各入口把「删什么 + 能否恢复」写清楚，允许换行）
#   pending_del.cursor / index / mapid = 下游要用的参数
# 【删除】→ ops/do_delete（按 kind 分发） / 【取消】→ ops/do_delete_cancel（清标记）
# ★ 2026-10-01 改成「内联对话框」（写法参考跃动晶界那套）：
#   ① 正文用 data modify 把 pending_del.detail「当 NBT 拼进去」——对话框正文不解析 nbt 组件
#      （MC-297871），旧写法 {"nbt":"pending_del.detail"} 一直渲染成空白。
#   ② 改这个框的文案/结构只需 /reload，不必重启世界。
data modify storage rhythm_axe:prop dialog set value {\
type:"minecraft:confirmation",\
title:{text:"确认删除"},\
body:[\
  {type:"minecraft:plain_message",width:400,contents:{text:"请确认你要删的东西："}},\
  {type:"minecraft:plain_message",width:400,contents:""}\
],\
can_close_with_escape:true,\
pause:false,\
yes:{label:{text:"删除"},tooltip:{text:"执行删除"},action:{type:"run_command",command:"/function rhythm_axe:editor/menu/ops/do_delete"}},\
no:{label:{text:"取消"},action:{type:"run_command",command:"/function rhythm_axe:editor/menu/ops/do_delete_cancel"}}}
data modify storage rhythm_axe:prop dialog.body[1].contents set from storage rhythm_axe:maps.editor pending_del.detail
function rhythm_axe:utilization/dialog_show_inline with storage rhythm_axe:prop
data remove storage rhythm_axe:prop dialog
