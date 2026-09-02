# Batch macro check: scan all .mcfunction in the datapack for common macro syntax errors.
# Usage: .\check_all_macros.ps1 [-Root <datapack root>]   (default = parent of script dir)
# Checks (same logic as check_macro.ps1, inlined to avoid per-file process overhead):
#   1) [ERR] dollar-prefix line but no $(...) macro ref   <- root cause of trigger_ load failure
#   2) [ERR] $(...) referencing a var not declared in #arg
#   3) [ERR] has $(...) but no dollar prefix
# Exit code: 0 = all pass, 1 = errors found (usable for pre-commit / CI)
param([string]$Root = "")

if (-not $Root) { $Root = Split-Path -Parent $PSScriptRoot }
# 跳过 editor_old（旧编辑器归档，非当前运行代码，不参与宏语法检查）
$files = Get-ChildItem -Path $Root -Recurse -Filter *.mcfunction | Where-Object { $_.FullName -notmatch '\\editor_old\\' }
$totalErr = 0
$badFiles = @()

foreach ($f in $files) {
    $content = Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8
    $lines = $content -split "`r?`n"

    # join continuation lines (backslash ending)
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

    # find #arg declaration
    $argDecl = ""
    foreach ($l in $logical) {
        if ($l -match '^\s*#arg\s*:\s*(.+)$') { $argDecl = $Matches[1]; break }
    }
    $declared = @{}
    if ($argDecl) {
        ($argDecl -split ',' | ForEach-Object { $_.Trim() }) | ForEach-Object { if ($_) { $declared[$_] = $true } }
    }

    $fileErr = 0
    for ($i = 0; $i -lt $logical.Count; $i++) {
        $l = $logical[$i].TrimEnd()
        if ($l -match '^\s*#') { continue }
        $hasDollarPrefix = $l -match '^\s*\$'
        $body = $l -replace '^\s*\$', ''
        $hasMacro = $body -match '\$\('
        if ($hasDollarPrefix) {
            if (-not $hasMacro) {
                Write-Host ("[{0}] LINE {1}: dollar-prefix but no `$() -> ERR" -f $f.Name, ($i + 1))
                $fileErr++
            }
            $refs = [regex]::Matches($body, '\$\(([A-Za-z0-9_]+)\)')
            foreach ($m in $refs) {
                $v = $m.Groups[1].Value
                if (-not $declared.ContainsKey($v)) {
                    Write-Host ("[{0}] LINE {1}: undeclared macro var `$({2}) -> ERR" -f $f.Name, ($i + 1), $v)
                    $fileErr++
                }
            }
        } else {
            if ($hasMacro) {
                Write-Host ("[{0}] LINE {1}: has `$() but no dollar prefix -> ERR" -f $f.Name, ($i + 1))
                $fileErr++
            }
        }
    }
    if ($fileErr -gt 0) {
        $totalErr += $fileErr
        $badFiles += $f.Name
    }
}

Write-Host ""
if ($totalErr -eq 0) {
    Write-Host ("OK: {0} files checked, all passed (0 errors)" -f $files.Count)
    exit 0
} else {
    Write-Host ("FAIL: {0} files checked, {1} files with {2} errors ->" -f $files.Count, $badFiles.Count, $totalErr)
    $badFiles | ForEach-Object { Write-Host "  - $_" }
    exit 1
}
