#arg:skin
# 空闲循环的 B 份：写静止位模型的孪生 item_model（外观与 A 完全相同，只是 ID 不同）
# 只改手持物品；中途换物品时不写（避免改到别的物品）
$execute if items entity @s weapon.mainhand *[minecraft:custom_data~{rhythm_axe:1}] run item modify entity @s weapon.mainhand rhythm_axe:swing/idle_$(skin)b
