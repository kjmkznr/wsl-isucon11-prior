Param(
  [parameter(mandatory=$true)][string]$Distro,
  [parameter(mandatory=$true)][string]$InstallLocation
)

$ErrorActionPreference = "Stop"

$uri = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-wsl.rootfs.tar.gz"
$sha256sum = "cce3eacd16c3686436bd1faba7b23802d133f0b8771affcf837ab97cf512f48e"
$tarball = Join-Path $PSScriptRoot ([System.IO.Path]::GetFileName($uri))

If (![System.IO.File]::Exists($tarball)) {
  Invoke-WebRequest -Uri $uri -OutFile $tarball
}

$hash = (Get-FileHash $tarball -Algorithm SHA256).Hash
If ($hash -ne $sha256sum) {
  Write-Error "checksum failed"
}

wsl.exe --import $Distro $InstallLocation $tarball

$scriptsdir = Join-Path $PSScriptRoot "scripts"
Get-ChildItem $scriptsdir -Filter *.sh | Foreach-Object {
  Get-Content $_.FullName -Raw | wsl.exe -d $Distro /bin/bash -l
}

wsl.exe -t $Distro

#Remove-Item $tarball
