# [已废弃 2026-09-14 D1b] 旧版线性插入点查找的子函数；insert_find 已改为指数+二分，不再调用
# 插入点 = 末尾：写 insert_mode 标记（入口据此分发 apply 函数）
data modify storage rhythm_axe:prop insert_mode set value "append"
