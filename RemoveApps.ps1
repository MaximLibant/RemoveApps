$logFilePath = C:\logs\
$appName = "removeApps"

if (!$logFilePath) {

    mkdir $logFilePath
}

#Start Recording logs
Start-Transcript C:\logs\$appName -Force

#Region RemoveHP-Software
$appList = Get-AppxPackage -allusers | where-object {$_.name -match "HP"}

foreach ($app in $appList) {
    Remove-AppxPackage -package $app -erroraction silentlycontinue
    Write-Output('removing ' + $app + '...')
}
#endRegion

#region delShortcuts
$tcoPath = 'C:\Users\Public\Desktop\TCO Certified.lnk'

if (Test-Path -path $tcoPath){

    remove-item -path $tcoPath

}

#remove shortcuts
$shortcut = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\HP Sure Click Pro Secure Browser.lnk'
if (Test-Path $shortcut) {

    Remove-Item $shortcut
}

$shortcut = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\HP Wolf Security.lnk'
if (Test-Path $shortcut) {

    Remove-Item $shortcut
}

$shortcut = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\HP Documentation.lnk'
if (Test-Path $shortcut) {

    Remove-Item $shortcut
}
#endRegion

Stop-Transcript