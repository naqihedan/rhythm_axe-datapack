# 创建歌曲进度条（宏；title 为谱面标题文本组件，由调用方 with storage 提供）
# bossbar name 不支持 nbt 引用，用宏传组件 SNBT 解析（组件存 storage）
#arg: title
$bossbar add rhythm_axe:song_progress $(title)
