$isInteractive = -not [Console]::IsInputRedirected -and -not [Console]::IsOutputRedirected

if ($isInteractive -and (Get-Module -ListAvailable -Name Terminal-Icons)) {
    Import-Module -Name Terminal-Icons -ErrorAction SilentlyContinue
}

$dotfilesRoot = Split-Path -Parent $PSScriptRoot
$themePath = Join-Path $dotfilesRoot "themes\catppuccino.omp.json"

if ($isInteractive -and (Get-Command oh-my-posh -ErrorAction SilentlyContinue) -and (Test-Path -LiteralPath $themePath)) {
    oh-my-posh init pwsh --config $themePath | Invoke-Expression
}

if ($isInteractive -and (Get-Module -ListAvailable -Name posh-git)) {
    Import-Module -Name posh-git -ErrorAction SilentlyContinue
}

if ($isInteractive -and (Get-Module -ListAvailable -Name PSReadLine)) {
    Import-Module -Name PSReadLine -ErrorAction SilentlyContinue

    Set-PSReadLineOption -HistorySearchCursorMovesToEnd
    Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineKeyHandler -Key Tab -Function Complete
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
}

if ($isInteractive) {
    function gfa { & git fetch --all $args }
    function gpr { & git fetch origin "$($args[0]):$($args[0])" }
    function rmf { Remove-Item -LiteralPath $args[0] -Force }
    function rmr { Remove-Item -LiteralPath $args[0] -Recurse }
    function rmrf { Remove-Item -LiteralPath $args[0] -Recurse -Force }
}
