# 创建歌曲进度条（宏；title_comp 为已归一化的标题文本组件，由调用方 with storage 提供）
# bossbar name 不支持 nbt 引用，用宏传组件 SNBT 解析（组件存 storage）
#arg: title_comp
$bossbar add rhythm_axe:song_progress $(title_comp)
