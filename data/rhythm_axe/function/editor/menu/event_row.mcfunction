#arg: ep,fc,fh
# 主菜单行107：事件播放 $(ep) + 音符聊天反馈 $(fc) + 音符hotbar反馈 $(fh)（同一行）
# 三个按钮组件由 main.mcfunction 组装进 prop（ep/fc/fh），本叶子经宏整行注入 tellraw
$tellraw @s [$(ep),{"text":"  ","color":"white"},$(fc),{"text":"  ","color":"white"},$(fh)]
