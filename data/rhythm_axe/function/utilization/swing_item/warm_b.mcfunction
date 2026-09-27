#arg:type,last,skin
# 预热（B）：写「最后一帧的孪生副本」——外观与 A 完全相同、item_model ID 不同
# → 每刻交替 A/B，客户端就一直认为「物品在变」，第 4 刻的动画帧才能立即生效
$item modify entity @s weapon.mainhand rhythm_axe:swing/$(type)_$(last)_$(skin)b
