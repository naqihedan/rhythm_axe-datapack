# 播放头跳到结尾：读工作副本的 end_time（未定义则提示）；跳转后暂停并刷新主菜单
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
function rhythm_axe:editor/menu/jump/jump_end_ with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
# 任意面板可用：返回当前面板（resume）而非强制主菜单
function rhythm_axe:editor/menu/resume
