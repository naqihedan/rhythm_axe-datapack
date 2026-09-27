#arg:type,last,skin
# 预热（A）：写「最后一帧」。开头这几刻的写入本来就会被原版忽略，只用来占位/让物品保持「在变」
$item modify entity @s weapon.mainhand rhythm_axe:swing/$(type)_$(last)_$(skin)
