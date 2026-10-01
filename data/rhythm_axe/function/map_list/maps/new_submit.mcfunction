#arg: mapid
# 【＋新建谱面】输入框的【新建】：拿玩家填的 id 走既有编辑器入口。
#   已存在同名谱面 → 不覆盖，直接打开它（在聊天栏说明一声）；
#   不存在 → editor/open 会调 editor/create_new 写一份默认模板进工作副本。
#   （模板内容见 editor/create_new：bpm 150 / bpb 4 / tpb 8 / preview 0~200 等）
$execute if data storage rhythm_axe:maps.$(mapid) id run tellraw @s [{"text":"[谱面总表] 已存在同名谱面（","color":"yellow"},{"text":"$(mapid)","color":"aqua"},{"text":"），直接打开它","color":"yellow"}]

# 收尾照搬 map_list/maps/edit：先停预览、收起总表，再进编辑器
#（编辑器入口自带单人锁 / "已在编辑同一张"提示 / 切换谱面确认，这里不重复）
function rhythm_axe:map_list/preview/stop
function rhythm_axe:map_list/close
$function rhythm_axe:editor/editor {mapid:"$(mapid)"}
