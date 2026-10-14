# ② 给 ① 生成的静态组加整组动画（16 刻：缩放 0→1→0、旋转 0→60°，四段线性）
#   先把满大小的静态组立即压到缩放 0，再排三段关键帧 + 删除
#   ★ 关键帧用 schedule 排在本刻之后（1/7/13/16 刻），与出生不同刻，客户端插值才有起点
function rhythm_axe:maps/goodworld/goodfx/waves/static_a0
schedule function rhythm_axe:maps/goodworld/goodfx/waves/static_k1 1t
schedule function rhythm_axe:maps/goodworld/goodfx/waves/static_k2 7t
schedule function rhythm_axe:maps/goodworld/goodfx/waves/static_k3 13t
schedule function rhythm_axe:maps/goodworld/goodfx/waves/static_d 16t
