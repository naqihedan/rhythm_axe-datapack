#arg:u0,u1,u2,u3,name
# 追加一名「待写回最高分」的参与者（key = UUID 四个 int 拼串，见 collect_；name = 显示名）
$data modify storage rhythm_axe:runtime hs_players append value {key:"$(u0)-$(u1)-$(u2)-$(u3)", name:"$(name)"}
