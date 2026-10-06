#arg:pnid
# 回填补对的交互实体（O(1) tag 查找，同 place_inter_pair）
# 与 place_inter_pair 的区别：这里**只写 editor_should_***（place_inter_should），不写 Pos。
$execute as @e[tag=editor_n_$(pnid),type=interaction,limit=1] run function rhythm_axe:editor/visual/place_inter_should
