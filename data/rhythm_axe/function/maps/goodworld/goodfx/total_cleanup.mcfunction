# total 专用清场：先补回 on 标记再调 cleanup
#   ★ 为什么需要它：中途若有 spawn/repeat 的清场先把 on 删了，256 刻这次带守卫的 remove 会跳过
#     ⇒ 计分项泄漏。补回标记保证 total 这条链的清场一定生效
data merge storage rhythm_axe:gfx_good {on:1b}
function rhythm_axe:maps/goodworld/goodfx/cleanup
