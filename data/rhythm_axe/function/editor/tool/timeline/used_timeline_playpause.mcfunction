# advancement has been revoked at use.mcfunction
# tag has been removed at use_.mcfunction

# 站立：播放/暂停切换（播放中→暂停，若存在记录点则跳回；未播放→播放）
# 蹲下：记录点开关（无→记录当前播放头并开始播放；有→删除记录点），不改播放状态
# 两种形态名称/提示不同（站立【播放/暂停】、蹲下【添加/删除记录点】），由 tool_pp_update / tool_pp_write 维护
execute if entity @s[predicate=rhythm_axe:sneaking] run return run function rhythm_axe:editor/playback/record_toggle
function rhythm_axe:editor/menu/playback_toggle