# 最小 summon 测试（诊断用；验证 item_display 的 NBT 是否合法，排查"看不到音符"）
# 运行：/function rhythm_axe:test/summon_min
summon item_display 0.0 1.5 4.0 {item:{id:"minecraft:note_block",count:1},Tags:["test_min"],brightness:{block:15,sky:15}}
tellraw @a [{"text":"[summon_min] 执行完毕，若上方有红色报错说明 item NBT(count:1) 不合法","color":"green"}]
