# 发射组 w2g5：出生 + 三段关键帧 + 删除（相对调用时刻 0/1/7/13/16 刻）
#   先清同 tag 旧实例：重发同一元件 = 重启
kill @e[tag=goodfx_w2g5]
function rhythm_axe:maps/goodworld/goodfx/waves/w2g5_s
schedule function rhythm_axe:maps/goodworld/goodfx/waves/w2g5_k1 1t
schedule function rhythm_axe:maps/goodworld/goodfx/waves/w2g5_k2 7t
schedule function rhythm_axe:maps/goodworld/goodfx/waves/w2g5_k3 13t
schedule function rhythm_axe:maps/goodworld/goodfx/waves/w2g5_d 16t
