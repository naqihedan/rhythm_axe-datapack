# 扫描端点：遍历工作副本 notes，按开关把「最早 / 最晚选中音符」的 time 与判定位置填进 editing.df
#   prop.w_ta / w_sa / w_tb / w_sb = 填 起的时间 / 起的位置 / 止的时间 / 止的位置（谁存在就填谁）
#   notes 按 time 升序（编辑器一直维护）⇒ 正序遍历：首个命中的是「最早」，末个是「最晚」

data remove storage rhythm_axe:prop got_first
data modify storage rhythm_axe:prop cursor set from storage rhythm_axe:maps.editor history_cursor
data modify storage rhythm_axe:prop idx set value 0
function rhythm_axe:editor/menu/note/df/df_scan_leaf with storage rhythm_axe:prop
data remove storage rhythm_axe:prop cursor
data remove storage rhythm_axe:prop idx
data remove storage rhythm_axe:prop got_first
data remove storage rhythm_axe:prop w_ta
data remove storage rhythm_axe:prop w_sa
data remove storage rhythm_axe:prop w_tb
data remove storage rhythm_axe:prop w_sb
