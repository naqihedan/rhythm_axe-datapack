#arg:skin
# 收尾恢复：按皮肤编号把 item_model 恢复成静止模型（宏；skin 来自 storage rhythm_axe:prop swing）
# 只有手持物品还是斧头时才 restore（中途换物品时别把新物品的 item_model 改掉）
$execute if items entity @s weapon.mainhand *[minecraft:custom_data~{rhythm_axe:1}] run item modify entity @s weapon.mainhand rhythm_axe:swing/restore_$(skin)
