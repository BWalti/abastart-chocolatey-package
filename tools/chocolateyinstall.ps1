$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url        = 'https://classic.abacus.ch/downloads/applikationen/abastart/abastart_3.3_setup.exe.zip'

$packageArgs = @{
  fullZipPath   = "$toolsDir\abastart.zip"
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  file          = "$toolsDir\abastart_setup.exe"

  softwareName  = 'ABACUS AbaStart version *'

  checksum      = '3BC6C20E4FEB34A592C82CC6D0462F58B87176FF2DC426BB149387FF55D539B9'
  checksumType  = 'sha256'

  silentArgs    = "/silent /nocancel /norestart /closeapplications /log=`"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
  validExitCodes= @(0, 3010, 1641)
}

Get-ChocolateyWebFile `
  -PackageName $packageArgs.packageName `
  -FileFullPath $packageArgs.fullZipPath `
  -Url $packageArgs.url

Get-ChocolateyUnzip `
  -PackageName $packageArgs.packageName `
  -FileFullPath $packageArgs.fullZipPath `
  -Destination $toolsDir

Install-ChocolateyInstallPackage `
  -PackageName $packageArgs.packageName `
  -FileType $packageArgs.fileType `
  -File $packageArgs.file `
  -SilentArgs $packageArgs.silentArgs `
  -ValidExitCodes $packageArgs.validExitCodes
