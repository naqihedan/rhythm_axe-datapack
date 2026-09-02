# Generate stress-test chart build_stress_map.mcfunction (5 lanes side by side)
# Purpose: mspt stress test (Stage C motion system perf verification)
# After generating: /reload + function rhythm_axe:test/build_stress_map + start_of_game {mapid:"stress"}
$ErrorActionPreference = "Stop"
$base = "d:\Program Files (x86)\Minecrafts\PCL 正式版 2.10.3 (1)\.minecraft\versions\节奏地图 高版本重制版\saves\节奏地图模板2026\datapacks\rhythm_axe"
$path = Join-Path $base "data\rhythm_axe\function\test\build_stress_map.mcfunction"

$lines = New-Object System.Collections.Generic.List[string]
function Add-Line($text) { $lines.Add($text) | Out-Null }

Add-Line "# ============ Stress chart: 5 lanes side by side (2026-08-08 rewrite) ============"
Add-Line "# Five note types spread across x=0.5~4.5 (type0 noteblock / 1 plank / 2 jukebox / 3 concrete / 4 glass, one lane each)"
Add-Line "# Four segments (120 ticks each, bpm 240):"
Add-Line "#   seg1 0~119   linear easing1/1  interval 5 tick (1 per tick, light)"
Add-Line "#   seg2 120~239 nonlinear easing3/3 interval 5 tick (1 per tick, light)"
Add-Line "#   seg3 240~359 linear easing1/1  interval 1 tick (5 per tick, heavy)"
Add-Line "#   seg4 360~479 nonlinear easing3/3 interval 1 tick (5 per tick, heavy)"
Add-Line "# note_base_life=32 -> seg3/4 steady-state ~160 concurrent notes + glass center markers + concrete zone markers"
Add-Line "# concrete duration=8 density=8; glass duration=4 (pass-through after judgement)"
Add-Line "# Run: function rhythm_axe:play/start_of_game/start_of_game {mapid:\"stress\"}"
Add-Line "# Watch mspt: F3 / /tick rate / /debug mspt (target: high-BPM chart mspt < 30)"
Add-Line ""

Add-Line "execute if data storage rhythm_axe:maps.stress timing_points run data remove storage rhythm_axe:maps.stress timing_points"
Add-Line "execute if data storage rhythm_axe:maps.stress notes run data remove storage rhythm_axe:maps.stress notes"
Add-Line "execute if data storage rhythm_axe:maps.stress events run data remove storage rhythm_axe:maps.stress events"
Add-Line 'data merge storage rhythm_axe:maps.stress {id:"stress",title:''{"text":"Stress Test"}'',artist:"test",music:"rhythm_axe:rhythm_axe.audio",health:1000,player_count:1,end_time:540,teleport:0b}'
Add-Line ""
Add-Line "data modify storage rhythm_axe:maps.stress timing_points append value {time:0,bpm:240,bpb:4,tpb:8,offset:0,judgement_scale:1}"
Add-Line ""
Add-Line "# Event: at time 0, let @p run tick sprint 240 (fast-forward to heavy seg3/seg4, skip light seg1/seg2 for mspt stress)"
Add-Line "#   NOTE: tick sprint needs permission level 2 (player must have OP/cheats); used to jump straight to the heavy section"
Add-Line 'data modify storage rhythm_axe:maps.stress events append value {time:0,commands:["execute as @p run tick sprint 240"]}'
Add-Line ""

# Lanes: type -> x
$tracks = @(
    @{ type = 0; x = "0.5" },
    @{ type = 1; x = "1.5" },
    @{ type = 2; x = "2.5" },
    @{ type = 3; x = "3.5" },
    @{ type = 4; x = "4.5" }
)

# Segments: label / start / end / easing / power / step
$segments = @(
    @{ label = "seg1 linear easing1/1 step5"; start = 0;   end = 120; easing = 1; power = 1; step = 5 },
    @{ label = "seg2 nonlinear easing3/3 step5"; start = 120; end = 240; easing = 3; power = 3; step = 5 },
    @{ label = "seg3 linear easing1/1 step1(heavy)"; start = 240; end = 360; easing = 1; power = 1; step = 1 },
    @{ label = "seg4 nonlinear easing3/3 step1(heavy)"; start = 360; end = 480; easing = 3; power = 3; step = 1 }
)

# Collect all notes, then output sorted by time ascending.
# CRITICAL: start_of_game/sort_notes uses recursive bubble sort O(n^2) capped by
# max_command_sequence_length 200000. If the notes array is NOT already in _birth
# order, 1420 notes would blow past the cap (interleaved runs need ~n/2 passes ->
# millions of commands) and init_game aborts -> no notes spawn (user found: none appeared).
# note_base_life is identical (32) here so _birth order == time order -> sort in 1 pass (no swap).
$id = 0
$all = New-Object System.Collections.Generic.List[object]
foreach ($seg in $segments) {
    foreach ($ti in 0..4) {
        $t = $tracks[$ti]
        $phase = $ti   # seg1/2 with step=5: lanes offset by phase 0~4 -> exactly 1 note/tick
        for ($time = $seg.start + $phase; $time -lt $seg.end; $time += $seg.step) {
            $extra = ""
            if ($t.type -eq 3) { $extra = "duration:8,density:8," }
            if ($t.type -eq 4) { $extra = "duration:4," }
            $all.Add([pscustomobject]@{
                time = $time
                line = "data modify storage rhythm_axe:maps.stress notes append value {id:$id,type:$($t.type),time:$time,note_base_life:32,size:1.0,${extra}anim_easing:$($seg.easing),anim_power:$($seg.power),position:[$($t.x),0.5,0.5],start_pos:[0.0,0.0,16.0]}"
            }) | Out-Null
            $id++
        }
    }
}
# stable sort by time (PowerShell Sort-Object is stable) -> _birth ascending
$sorted = $all | Sort-Object time
foreach ($n in $sorted) { Add-Line $n.line }

Add-Line ""
Add-Line "# total notes: $id"

$content = [string]::Join("`n", $lines)
[System.IO.File]::WriteAllText($path, $content, (New-Object System.Text.UTF8Encoding($false)))
Write-Output "written: $path"
Write-Output "total notes: $id"
