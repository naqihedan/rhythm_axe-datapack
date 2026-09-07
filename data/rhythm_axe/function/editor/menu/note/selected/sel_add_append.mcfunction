#arg:nid,sel_idx
# 在 selection 末尾追加 {id:$(nid), idx:$(sel_idx)}
$data modify storage rhythm_axe:maps.editor selection append value {id:$(nid),idx:$(sel_idx)}
