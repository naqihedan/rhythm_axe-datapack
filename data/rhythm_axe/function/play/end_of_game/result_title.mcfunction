# 结算界面显示歌曲标题（宏；title_comp 已由 util/title_comp 归一化为可安全注入的文本组件）
# ★ 宏行必须以 $ 开头（含 $(title_comp) 的行），否则加载失败（“Failed to load function”）
#arg: title_comp
$tellraw @a ["--------  ",$(title_comp),"  --------"]
