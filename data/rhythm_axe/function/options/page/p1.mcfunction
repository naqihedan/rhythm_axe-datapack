# 设置面板 · 页 1：模组（行 170~179）
# 模组开关存在 **mods 计分板**（不是 options）—— 全局单值，开局时由 play/start_of_game/start
#   复制到 play_state 同名项（`scoreboard players operation auto play_state = auto mods`）。
#   行号段 170~179 独立于其它页（161~169 空着备用、154~159 留给高级页扩展）。
# 值 = 行号×100 + 列码（布尔项列码 1 = 切换）；每行由 options/bool_row 生成（obj = mods）

# 行 170 自动模式（auto）：1 = 自动模式（auto 接管判定，玩家不能判定；结算显示 AUTO PLAY、不覆盖最高分）
data modify storage rhythm_axe:op_ui label set value "自动模式（auto）"
data modify storage rhythm_axe:op_ui key set value "auto"
data modify storage rhythm_axe:op_ui obj set value "mods"
data modify storage rhythm_axe:op_ui blo set value 17001
function rhythm_axe:options/bool_row with storage rhythm_axe:op_ui

# —— 分类名（分节线；页尾，紧接在页脚之前）——
tellraw @s [{"text":"───────── 模组 ─────────","color":"dark_gray"}]
