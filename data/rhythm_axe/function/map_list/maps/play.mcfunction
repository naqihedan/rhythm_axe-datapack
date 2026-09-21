#arg: mapid
# 总表行【游玩】（列码 1）：先收起总表，然后走既有开局入口。
# 开局检查（mod 已安装 / 没有正在运行的谱面 / 谱面存在）都在 start_of_game 里，这里不重复。
# 注：$(mapid) 在本函数**实例化时**就已替换成实际 id，所以下面 close 清掉 prop.mapid 也无影响。
function rhythm_axe:map_list/close
$function rhythm_axe:play/start_of_game/start_of_game {mapid:"$(mapid)"}
