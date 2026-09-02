# mod 检测：若 mod 已安装（其自定义 gamerule 存在），本命令执行成功 → 函数返回成功
# mod 未安装时 gamerule 未知，本命令运行时失败 → 函数返回失败
# 用法：execute if function rhythm_axe:play/start_of_game/mod_test（装了 mod 才为真）
gamerule rhythm_axe_mod:confirm_command false
# 本命令是mod添加，报错属正常