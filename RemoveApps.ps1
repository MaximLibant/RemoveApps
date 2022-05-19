$logFile = C:\logs\removeAppsLog.txt

Start-Transcript $logFile -Force

#Remove all annoying HP apps
$appList = Get-AppxPackage -allusers | where-object {$_.name -match "HP"}

foreach ($app in $appList) {
    Remove-AppxPackage -package $app -erroraction silentlycontinue
    Write-Output('removing ' + $app + '...')
}

#remove annoying TCO Certified shortcut
$tcoPath = 'C:\Users\Public\Desktop\TCO Certified.lnk'

if (Test-Path -path $tcoPath){

    remove-item -path $tcoPath

}

$appList = @('HP Documentation','HP Wolf Security','HP Security Update Service','HP Connection Optimizer','HP notifications','HP Wolf Security')

foreach($app in $applist) {
    if (winget search $app) {

        winget uninstall --accept-source-agreements --silent --name $app -erroraction silentlycontinue   
    }
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

Stop-Transcript