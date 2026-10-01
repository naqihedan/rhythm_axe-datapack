# 【关闭所有模组】（模组页页脚的按钮，16007）：把 mods 计分板上**所有**模组开关置 0，然后重绘。
#   ⚠️ 加新模组时记得在这里补一行 `scoreboard players set <新键> mods 0`。
#   用 `set 0` 而不是 `reset`：reset 会把计分项删掉，而 play/start_of_game/start 里
#   `scoreboard players operation auto play_state = auto mods` 从"不存在的计分项"读会失败
#   ⇒ play_state.auto 会保留上一局的值（危险）；置 0 则语义明确。
scoreboard players set auto mods 0
function rhythm_axe:options/render
