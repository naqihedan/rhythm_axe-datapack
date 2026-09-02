# 播放头跳到上一个事件点（播放中自动重同步音乐与 tick rate）
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop list_name set value "events"
data modify storage rhythm_axe:prop jump_mode set value "prev"
data modify storage rhythm_axe:prop index set value 0
data modify storage rhythm_axe:prop candidate_time set value -1
function rhythm_axe:editor/util/jump_find with storage rhythm_axe:prop
