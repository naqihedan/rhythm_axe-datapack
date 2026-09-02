# 切换到 pending_mapid（912 丢弃并切换 / 913 直接切换共用）：
# 清当前编辑状态（含未保存改动）后重新初始化并打开新谱面
data modify storage rhythm_axe:prop mapid set from storage rhythm_axe:maps.editor pending_mapid
data remove storage rhythm_axe:maps.editor pending_mapid
tag @s remove editor_active
function rhythm_axe:editor/init_state
function rhythm_axe:editor/open with storage rhythm_axe:prop
data remove storage rhythm_axe:prop mapid
