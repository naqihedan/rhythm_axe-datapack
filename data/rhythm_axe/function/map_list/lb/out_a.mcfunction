#arg:bi,mapid
# 输出第一层：取出第 bi 名的 key，并把它从待选列表里删掉（避免下一轮重复）
$data modify storage rhythm_axe:prop key set from storage rhythm_axe:lb keys[$(bi)]
$data remove storage rhythm_axe:lb keys[$(bi)]
