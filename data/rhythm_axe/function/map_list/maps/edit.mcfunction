#arg: mapid
# 总表行【编辑】（列码 3）：先收起总表，然后走既有编辑器入口。
# 编辑器入口自带单人锁 / "已在编辑同一张"提示 / 切换谱面确认（面板 15），这里不重复。
function rhythm_axe:map_list/close
$function rhythm_axe:editor/editor {mapid:"$(mapid)"}
