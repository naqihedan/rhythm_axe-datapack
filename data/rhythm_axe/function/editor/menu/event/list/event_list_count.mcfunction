#arg:cursor
# 事件总数 → #event_total
$execute store result score #event_total editor run data get storage rhythm_axe:maps.editor history[$(cursor)].events
