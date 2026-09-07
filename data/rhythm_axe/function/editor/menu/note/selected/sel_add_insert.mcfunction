#arg:nid,sel_idx,i
# 在 selection 第 $(i) 位插入 {id:$(nid), idx:$(sel_idx)}
$data modify storage rhythm_axe:maps.editor selection insert $(i) value {id:$(nid),idx:$(sel_idx)}
