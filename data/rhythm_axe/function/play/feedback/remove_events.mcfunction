# 清理音符的 hit_events（宏参数 fb_nid；判定/清除音符对时调用）
#arg: fb_nid
$execute if data storage rhythm_axe:runtime hit_events.$(fb_nid) run data remove storage rhythm_axe:runtime hit_events.$(fb_nid)
