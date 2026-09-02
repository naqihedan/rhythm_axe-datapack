# 结算界面显示歌曲标题（宏；title 为谱面标题文本组件）
# ★ 宏行必须以 $ 开头（含 $(title) 的行），否则加载失败（“Failed to load function”）
#arg: title
$tellraw @a ["--------  ",$(title),"  --------"]
