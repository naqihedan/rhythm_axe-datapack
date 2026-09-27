# 结算界面显示歌曲标题（宏；title_comp 已由 util/title_comp 归一化为可安全注入的文本组件）
# ★ 宏行必须以 $ 开头（含 $(title_comp) 的行），否则加载失败（“Failed to load function”）
# 曲师（artist）/谱面作者（charter）用 runtime 的 nbt 组件取（start 里已补兜底，缺失不会让整行失效）
#arg: title_comp
$tellraw @a ["--------  ",$(title_comp),{"text":" - ","color":"gray"},{"nbt":"artist","storage":"rhythm_axe:runtime","color":"aqua"},{"text":" - ","color":"gray"},{"nbt":"charter","storage":"rhythm_axe:runtime","color":"gold"},{"text":"  --------"}]
