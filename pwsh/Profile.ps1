$isInteractive = -not [Console]::IsInputRedirected -and -not [Console]::IsOutputRedirected

$dotfilesRoot = Split-Path -Parent $PSScriptRoot
$themeName = "hearthside"
$themePath = Join-Path $dotfilesRoot "oh-my-posh\$themeName.omp.yaml"
$env:POSH_GIT_ENABLED = $true

function Register-Git {
  Invoke-Expression -Command "function global:$($args[0]) { git $($args[1]) @args }"
  $tab = [Scriptblock]::Create("
    param(`$wordToComplete, `$commandAst, `$cursorPosition)
    `$cmdline = `$commandAst.ToString().Replace(`"$($args[0])`", `"`")
    if (`$wordToComplete.Length -ne 0) { `$tail = '' } else { `$tail = ' ' }
    Expand-GitCommand `"git $($args[1]) `$cmdline`$tail`"
  ")
  Register-ArgumentCompleter -CommandName $args[0] -ScriptBlock $tab
}

if ($isInteractive) {
    # Aliases
    function gfo { & git fetch origin "$($args[0]):$($args[0])" }
    function ghcl { & git clone "git@github.com:$($args[0]).git" }
    Register-Git ga "add"
    Register-Git gb "branch"
    Register-Git gco "checkout"
    Register-Git gs "status"
    Register-Git log "log --oneline --graph --decorate"
    Register-Git gd "diff"
    Register-Git gds "diff --staged"
    Register-Git gcl "clone"
    Register-Git gf "fetch --all"
    Register-Git pull "pull"
    Register-Git gpf "push --force-with-lease"
    Register-Git grb "rebase"
    Register-Git gft "fetch --tags --force"
    function rmf { Remove-Item -LiteralPath $args[0] -Force }
    function rmr { Remove-Item -LiteralPath $args[0] -Recurse }
    function rmrf { Remove-Item -LiteralPath $args[0] -Recurse -Force }
    function cpy { & cat $args[0] | clip.exe }
    function fpg { & flutter pub get }
    function dbr { & dart run build_runner build }
    Set-Alias code "cursor"
    Set-Alias omp "oh-my-posh"
    Set-Alias cl "clear"
    function reload { Invoke-Expression ". $PROFILE" }

    # Modules
    if (Get-Module -ListAvailable -Name Terminal-Icons) {
        Import-Module -Name Terminal-Icons
    }

    if (Get-Module -ListAvailable -Name PSReadLine) {
        Import-Module -Name PSReadLine

        Set-PSReadLineOption -HistorySearchCursorMovesToEnd
        Set-PSReadLineOption -PredictionViewStyle ListView
        Set-PSReadLineKeyHandler -Key Tab -Function Complete
        Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
        Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    }

    # oh-my-posh
    if ((Get-Command oh-my-posh -ErrorAction SilentlyContinue) -and (Test-Path -LiteralPath $themePath)) {
        oh-my-posh init pwsh --config $themePath | Invoke-Expression
    }

    if (Get-Module -ListAvailable -Name posh-git) {
        Import-Module -Name posh-git
    }
}
