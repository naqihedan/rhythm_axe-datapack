#arg:i,key,mapid
# 第 i 个 key：等于要删的那个就跳过，否则追加进 rhythm_axe:lb.rebuilt
$data modify storage rhythm_axe:lb tmp set from storage rhythm_axe:scores_index $(mapid)[$(i)]
$execute if data storage rhythm_axe:lb {tmp:"$(key)"} run return 0
data modify storage rhythm_axe:lb rebuilt append from storage rhythm_axe:lb tmp
