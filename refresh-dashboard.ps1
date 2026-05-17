# refresh-dashboard.ps1
# Reads deal-file.md from each case folder and regenerates the data section in dashboard.html.
# Run via refresh-dashboard.bat — do not run directly.

$ErrorActionPreference = "Stop"

$scriptDir    = Split-Path -Parent $MyInvocation.MyCommand.Path
$casesDir     = Join-Path $scriptDir "_shared\cases"
$dashFile     = Join-Path $scriptDir "dashboard.html"
$today        = (Get-Date).ToString("yyyy-MM-dd")

# ---- helpers ----------------------------------------------------------------

function Js([string]$s) {
    if ([string]::IsNullOrWhiteSpace($s)) { return '""' }
    $s = $s.Trim()
    $s = $s -replace '\\', '\\\\'
    $s = $s -replace '"',  '\"'
    $s = $s -replace "`r`n|`r|`n", ' '
    return '"' + $s + '"'
}

function Get1([string]$text, [string]$pattern) {
    if ($text -match $pattern) { return $Matches[1].Trim() }
    return ""
}

function ExtractSection([string]$text, [string]$header) {
    $opts = [System.Text.RegularExpressions.RegexOptions]::Multiline -bor
            [System.Text.RegularExpressions.RegexOptions]::Singleline
    $pattern = "### $([regex]::Escape($header))\n(.*?)(?=\n###|\n##|\z)"
    $m = [regex]::Match($text, $pattern, $opts)
    if ($m.Success) { return $m.Groups[1].Value } else { return "" }
}

function ListLines([string]$section) {
    $section -split "`n" |
        Where-Object { $_ -match '^\s*-\s+\S' } |
        ForEach-Object { ($_ -replace '^\s*-\s+', '').Trim() } |
        Where-Object { $_ -and $_ -ne 'None' }
}

function FindContractPrice([string[]]$sessionUpdates) {
    # Search sessions in reverse for a dollar amount that looks like a contract price.
    # Filter out small amounts (< $100k) which are likely concessions/credits, not prices.
    for ($i = $sessionUpdates.Count - 1; $i -ge 0; $i--) {
        $u = $sessionUpdates[$i]
        # Full dollar amount e.g. $625,000 — take last match in session, must be >= $100,000
        $fullMatches = [regex]::Matches($u, '\$(\d{1,3},\d{3})') |
                       Where-Object { [int]($_.Groups[1].Value -replace ',','') -ge 100000 }
        if ($fullMatches.Count -gt 0) {
            return '$' + $fullMatches[$fullMatches.Count - 1].Groups[1].Value
        }
        # Short form e.g. $625k — take last match, must be >= $100k
        $kMatches = [regex]::Matches($u, '\$(\d+)k\b') |
                    Where-Object { [int]$_.Groups[1].Value -ge 100 }
        if ($kMatches.Count -gt 0) {
            $num = [int]$kMatches[$kMatches.Count - 1].Groups[1].Value * 1000
            return '$' + ("{0:N0}" -f $num)
        }
    }
    return ""
}

# ---- parse each case folder -------------------------------------------------

$dealBlocks = [System.Collections.Generic.List[string]]::new()

$caseFolders = Get-ChildItem -LiteralPath $casesDir -Directory -ErrorAction SilentlyContinue |
               Where-Object { $_.Name -notlike '_*' } |
               Sort-Object Name

foreach ($folder in $caseFolders) {
    $dealFilePath = Join-Path $folder.FullName "deal-file.md"
    if (-not (Test-Path $dealFilePath)) { continue }

    Write-Host "  Parsing $($folder.Name)..." -ForegroundColor Cyan

    $raw  = [System.IO.File]::ReadAllText($dealFilePath)
    $text = $raw -replace "`r`n", "`n" -replace "`r", "`n"

    # -- header fields
    $client = Get1 $text '# Deal File: (.+)'
    $caseId = Get1 $text '\*\*Case ID:\*\* (.+)'
    $type   = Get1 $text '\*\*Deal Type:\*\* (.+)'
    $agent  = Get1 $text '\*\*Agent:\*\* (.+)'
    $opened = Get1 $text '\*\*Opened:\*\* (.+)'
    $stage  = Get1 $text '\*\*Stage:\*\* (.+)'

    # -- sessions
    $opts = [System.Text.RegularExpressions.RegexOptions]::Multiline -bor
            [System.Text.RegularExpressions.RegexOptions]::Singleline
    $sessionPat = '### (\d{4}-\d{2}-\d{2})[^\n]*\n.*?\*\*Update from agent:\*\* ([^\n]+).*?\*\*Work completed:\*\* ([^\n]+)'
    $sessionMatches = [regex]::Matches($text, $sessionPat, $opts)

    $sessionsJs    = [System.Collections.Generic.List[string]]::new()
    $sessionDates  = [System.Collections.Generic.List[string]]::new()
    $sessionUpdates = [System.Collections.Generic.List[string]]::new()
    $lastSession    = $opened

    foreach ($m in $sessionMatches) {
        $sDate   = $m.Groups[1].Value.Trim()
        $sUpdate = $m.Groups[2].Value.Trim()
        $sWork   = $m.Groups[3].Value.Trim()
        $sessionsJs.Add("      { date: $(Js $sDate), update: $(Js $sUpdate), work: $(Js $sWork) }")
        $sessionDates.Add($sDate)
        $sessionUpdates.Add($sUpdate)
        $lastSession = $sDate
    }

    $summary = if ($sessionUpdates.Count -gt 0) { $sessionUpdates[$sessionUpdates.Count - 1] } `
               else { "$stage deal opened $opened." }

    # -- lead card
    $lcIntent    = Get1 $text '\*\*Intent:\*\* ([^\n]+)'
    $lcBudget    = Get1 $text '\*\*Budget:\*\* ([^\n]+)'
    $lcTimeline  = Get1 $text '\*\*Timeline:\*\* ([^\n]+)'
    $lcLocation  = Get1 $text '\*\*Location preferences:\*\* ([^\n]+)'
    $lcMust      = Get1 $text '\*\*Must-haves:\*\* ([^\n]+)'
    $lcBreakers  = Get1 $text '\*\*Deal-breakers:\*\* ([^\n]+)'
    $lcComm      = Get1 $text '\*\*Communication style:\*\* ([^\n]+)'

    # -- comms log
    $commsJs = [System.Collections.Generic.List[string]]::new()
    $commsSectionPat = '(?ms)## Comms Log\n.*?\|[-\s|]+\n(.*?)(?=\n##|\z)'
    $commsMatch = [regex]::Match($text, $commsSectionPat, $opts)
    if ($commsMatch.Success) {
        $commsRows = [regex]::Matches($commsMatch.Groups[1].Value,
                     '\| (\d{4}-\d{2}-\d{2}) \| ([^\|]+) \| ([^\|]+) \|')
        foreach ($r in $commsRows) {
            $rawPath  = $r.Groups[2].Value.Trim()
            $fileName = [System.IO.Path]::GetFileNameWithoutExtension($rawPath.Split('/')[-1])
            $status   = $r.Groups[3].Value.Trim()
            $commsJs.Add("      { date: $(Js $r.Groups[1].Value.Trim()), file: $(Js $fileName), status: $(Js $status) }")
        }
    }

    # -- risk flags
    $riskSection = ExtractSection $text "Risk Flags"
    $riskJs = ListLines $riskSection | ForEach-Object {
        # Strip leading emoji/warning chars
        ($_ -replace '^[⚠️\s]+', '').Trim()
    } | Where-Object { $_ } | ForEach-Object { "      $(Js $_)" }

    # -- open items
    $openSection = ExtractSection $text "Open Items"
    $openJs = ListLines $openSection | ForEach-Object { "      $(Js $_)" }

    # -- key dates
    $kdJs = [System.Collections.Generic.List[string]]::new()
    $kdPat = '(?ms)### Key Dates.*?\|[-|\s]+\n(.*?)(?=\n###|\n##|\z)'
    $kdMatch = [regex]::Match($text, $kdPat, $opts)
    if ($kdMatch.Success) {
        $dateRows = [regex]::Matches($kdMatch.Groups[1].Value, '\| ([^\|]+) \| ([^\|]+) \| ([^\|]+) \|')
        foreach ($r in $dateRows) {
            $ms  = $r.Groups[1].Value.Trim()
            $dt  = $r.Groups[2].Value.Trim()
            $st  = $r.Groups[3].Value.Trim().ToUpper()
            if ($ms -eq "Milestone") { continue }
            $status = if ($st -match 'COMPLETE') { 'complete' } `
                      elseif ($st -match 'URGENT|PROGRESS|IN PROGRESS') { 'urgent' } `
                      else { 'pending' }
            $kdJs.Add("      { milestone: $(Js $ms), date: $(Js $dt), status: `"$status`" }")
        }
    }

    # -- closed/cancelled extra fields
    $closedLine  = ""
    $priceLine   = ""
    if ($stage -eq "closed") {
        $closedLine = "`n    closedDate: $(Js $lastSession),"
        $price = FindContractPrice $sessionUpdates
        if ($price) { $priceLine = "`n    closedPrice: $(Js $price)," }
    }

    # -- assemble block
    $sessStr  = if ($sessionsJs.Count  -gt 0) { $sessionsJs  -join ",`n" } else { "" }
    $commsStr = if ($commsJs.Count     -gt 0) { $commsJs     -join ",`n" } else { "" }
    $riskStr  = if ($riskJs.Count      -gt 0) { ($riskJs | Where-Object {$_}) -join ",`n" } else { "" }
    $openStr  = if ($openJs.Count      -gt 0) { ($openJs | Where-Object {$_}) -join ",`n" } else { "" }
    $kdStr    = if ($kdJs.Count        -gt 0) { $kdJs        -join ",`n" } else { "" }

    $block = @"
  {
    id: $(Js $caseId),
    client: $(Js $client),
    type: $(Js $type),
    agent: $(Js $agent),
    stage: $(Js $stage),
    opened: $(Js $opened),
    lastSession: $(Js $lastSession),$closedLine$priceLine
    summary: $(Js $summary),
    riskFlags: [$riskStr],
    openItems: [$openStr],
    leadCard: {
      intent: $(Js $lcIntent),
      budget: $(Js $lcBudget),
      timeline: $(Js $lcTimeline),
      location: $(Js $lcLocation),
      mustHaves: $(Js $lcMust),
      dealBreakers: $(Js $lcBreakers),
      commStyle: $(Js $lcComm)
    },
    sessions: [
$sessStr
    ],
    comms: [
$commsStr
    ],
    keyDates: [
$kdStr
    ]
  }
"@
    $dealBlocks.Add($block)
}

# ---- build replacement data block -------------------------------------------

$dealsJs = $dealBlocks -join ",`n"

$newDataBlock = @"
// ============================================================
// DEAL DATA -- regenerated by refresh-dashboard.bat
// ============================================================
const LAST_REFRESHED = "$today";

const DEALS = [
$dealsJs
];
"@

# ---- splice into dashboard.html ---------------------------------------------

$html = [System.IO.File]::ReadAllText($dashFile)

$startMarker = "// DEAL DATA"
$endMarker   = "// DASHBOARD LOGIC"

$startPos = $html.IndexOf($startMarker)
$endPos   = $html.IndexOf($endMarker)

if ($startPos -lt 0 -or $endPos -lt 0) {
    Write-Error "Could not locate data section markers in dashboard.html."
    exit 1
}

# Walk back from startPos to find the beginning of its comment line
$sectionStart = $html.LastIndexOf("//", $startPos - 2)
if ($sectionStart -lt 0) { $sectionStart = $startPos }

# Walk back from endPos to find the beginning of its comment line
$sectionEnd = $html.LastIndexOf("//", $endPos - 2)
if ($sectionEnd -lt 0) { $sectionEnd = $endPos }

$before  = $html.Substring(0, $sectionStart)
$after   = $html.Substring($sectionEnd)

$newHtml = $before + $newDataBlock + "`r`n`r`n" + $after

[System.IO.File]::WriteAllText($dashFile, $newHtml, [System.Text.Encoding]::UTF8)

Write-Host ""
Write-Host "Dashboard refreshed." -ForegroundColor Green
Write-Host "  Deals loaded : $($dealBlocks.Count)"
Write-Host "  Date stamp   : $today"
Write-Host "  File         : $dashFile"
