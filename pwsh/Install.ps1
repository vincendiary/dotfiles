function Install-ModuleIfMissing {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [switch]$AllowPrerelease
    )

    if (Get-Module -ListAvailable -Name $Name) {
        Write-Host "$Name is already installed."
        return
    }

    $installParams = @{
        Name = $Name
        Repository = "PSGallery"
        Scope = "CurrentUser"
        Force = $true
    }

    if ($AllowPrerelease) {
        $installParams.AllowPrerelease = $true
    }

    Install-Module @installParams
}

function Install-WingetPackageIfMissing {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Id
    )

    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Warning "winget is not installed. Skipping $Id."
        return
    }

    winget list --id $Id --exact | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "$Id is already installed."
        return
    }

    winget install --id $Id --exact --source winget
}

function Install-PowerShellProfile {
    $profileSourcePath = Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "Profile.ps1")
    $profileLine = ". `"$($profileSourcePath.Path)`""
    $profileDirectory = Split-Path -Parent $PROFILE

    if (-not (Test-Path -LiteralPath $profileDirectory)) {
        New-Item -ItemType Directory -Path $profileDirectory -Force | Out-Null
    }

    if (-not (Test-Path -LiteralPath $PROFILE)) {
        Set-Content -LiteralPath $PROFILE -Value $profileLine
        Write-Host "Created PowerShell profile at $PROFILE."
        return
    }

    $profileContent = Get-Content -LiteralPath $PROFILE -Raw
    if ($profileContent -match [regex]::Escape($profileLine)) {
        Write-Host "PowerShell profile already loads $($profileSourcePath.Path)."
        return
    }

    Add-Content -LiteralPath $PROFILE -Value $profileLine
    Write-Host "Updated PowerShell profile at $PROFILE."
}

Install-ModuleIfMissing -Name "Terminal-Icons"
Install-ModuleIfMissing -Name "posh-git"
Install-ModuleIfMissing -Name "PSReadLine" -AllowPrerelease
Install-WingetPackageIfMissing -Id "JanDeDobbeleer.OhMyPosh"
Install-PowerShellProfile
