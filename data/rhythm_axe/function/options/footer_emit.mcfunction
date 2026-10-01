#arg: foot_head, foot_tail
# 设置面板页脚输出（正常态，宏叶子）。
#   foot_head = 公共部分（上一页 / 页码 / 下一页 / 收起），用 `{"text":"","extra":[…]}` 包成一个组件；
#   foot_tail = 最后那个按钮 —— **模组页（页 1）= 【关闭所有模组】、其它页 = 【恢复默认】**
# 两个参数都经 storage rhythm_axe:op_ui 传入（与 num_row / bool_row 同一套通道）。
$tellraw @s [$(foot_head),$(foot_tail)]
