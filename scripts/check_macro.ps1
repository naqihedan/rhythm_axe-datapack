# Macro validation: join continuation lines, check $ lines contain $(), vars declared in #arg, no missing $
param([string]$file)
$content = Get-Content -LiteralPath $file -Raw -Encoding UTF8
$lines = $content -split "`r?`n"
$logical = New-Object System.Collections.Generic.List[string]
$buf = ""
foreach ($l in $lines) {
    if ($l -match '\\\s*$') {
        $buf += ($l -replace '\\\s*$', '') + " "
    } else {
        $buf += $l
        $logical.Add($buf)
        $buf = ""
    }
}
if ($buf) { $logical.Add($buf) }

$argDecl = ""
foreach ($l in $logical) {
    if ($l -match '^\s*#arg\s*:\s*(.+)$') { $argDecl = $Matches[1]; break }
}
$declared = @{}
if ($argDecl) {
    ($argDecl -split ',' | ForEach-Object { $_.Trim() }) | ForEach-Object { if ($_) { $declared[$_] = $true } }
}

$errs = 0
for ($i = 0; $i -lt $logical.Count; $i++) {
    $l = $logical[$i].TrimEnd()
    if ($l -match '^\s*#') { continue }
    $hasDollarPrefix = $l -match '^\s*\$'
    $body = $l -replace '^\s*\$', ''
    $hasMacro = $body -match '\$\('
    if ($hasDollarPrefix) {
        if (-not $hasMacro) {
            Write-Host ("LINE {0}: dollar-prefix but no \$() -> [ERR] {1}" -f ($i + 1), $l)
            $errs++
        }
        $refs = [regex]::Matches($body, '\$\(([A-Za-z0-9_]+)\)')
        foreach ($m in $refs) {
            $v = $m.Groups[1].Value
            if (-not $declared.ContainsKey($v)) {
                Write-Host ("LINE {0}: undeclared macro var \$( {1} ) -> [ERR] {2}" -f ($i + 1), $v, $l)
                $errs++
            }
        }
    } else {
        if ($hasMacro) {
            Write-Host ("LINE {0}: has \$() but no dollar prefix -> [ERR] {1}" -f ($i + 1), $l)
            $errs++
        }
    }
}
Write-Host ("DONE: {0} logical lines, {1} errors" -f $logical.Count, $errs)
