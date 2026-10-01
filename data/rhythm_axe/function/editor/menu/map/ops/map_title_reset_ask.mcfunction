# 行114 列码03【重置谱面标题】：弹对话框确认（2026-10-01，学【删除谱面】10404 那套）
#   确认 → map_title_reset（真正重置）/ 取消 → map_title_reset_cancel
#   ⚠️ 会话缺少面板暂存时给明确提示：否则对话框正文空白、点了像没反应
# ★ 内联对话框：正文把「当前标题」当 NBT 拼进去（对话框正文不解析 nbt/score/selector 组件，
#   见 AI常见问题 / MC-297871）；顺带改文案只需 /reload，不必重启世界。
execute unless data storage rhythm_axe:maps.editor panel_temp run tellraw @s [{"text":"[编辑器] 面板暂存副本不存在——请先打开【谱面设置】面板再用这个按钮","color":"red"}]
execute unless data storage rhythm_axe:maps.editor panel_temp run return fail
data modify storage rhythm_axe:prop dialog set value {\
type:"minecraft:confirmation",\
title:{text:"确认重置谱面标题"},\
body:[\
  {type:"minecraft:plain_message",width:400,contents:{text:"当前标题："}},\
  {type:"minecraft:plain_message",width:400,contents:""},\
  {type:"minecraft:plain_message",width:400,contents:{text:"\n要把标题重置为「(无标题)」占位。\n只改面板暂存，点【保存设置】才写回谱面。\n\n若 主菜单 / bossbar / 谱面设置面板 里都找不到标题行，说明标题存了无法解析的内容 —— 重置即可恢复。"}}\
],\
can_close_with_escape:true,\
pause:false,\
yes:{label:{text:"重置"},tooltip:{text:"把标题重置为「(无标题)」"},action:{type:"run_command",command:"/function rhythm_axe:editor/menu/map/ops/map_title_reset"}},\
no:{label:{text:"取消"},tooltip:{text:"什么都不改，回到面板"},action:{type:"run_command",command:"/function rhythm_axe:editor/menu/map/ops/map_title_reset_cancel"}}}
data modify storage rhythm_axe:prop dialog.body[1].contents set from storage rhythm_axe:maps.editor panel_temp.title
function rhythm_axe:utilization/dialog_show_inline with storage rhythm_axe:prop
data remove storage rhythm_axe:prop dialog
