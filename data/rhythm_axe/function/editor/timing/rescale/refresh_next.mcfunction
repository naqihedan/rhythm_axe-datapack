# 缩放收尾·下一刻：重建世界视觉（refresh 整表重建实体，单独占一格）
function rhythm_axe:editor/refresh
scoreboard players add #content_ver editor 1
execute store result storage rhythm_axe:maps.editor content_ver int 1 run scoreboard players get #content_ver editor
