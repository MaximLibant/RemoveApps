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
    try {
    
        Remove-AppxPackage -package $app -erroraction silentlycontinue
        Write-Output('removing ' + $app + '...')
    }
    catch {
        <#Do this if a terminating exception happens#>
        $fail = $_.exception.message   
    }
    finally {
        <#Do this after the try block regardless of whether an exception occurred or not#>
        if ($fail) {

            Write-Host $fail
            Stop-Transcript
            throw $fail

        } else {
            Write-Host "Apps removed, moving on."
        }
    }
}
#endRegion

#region delShortcuts
$tcoPath = 'C:\Users\Public\Desktop\TCO Certified.lnk'

if (Test-Path -path $tcoPath){

    remove-item -path $tcoPath
    Write-Output('removing ' + $tcoPath + '...')
}

#remove shortcuts
$shortcut = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\HP Sure Click Pro Secure Browser.lnk'
if (Test-Path $shortcut) {

    Remove-Item $shortcut
    Write-Output('removing ' + $shortcut + '...')
}

$shortcut = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\HP Wolf Security.lnk'
if (Test-Path $shortcut) {

    Remove-Item $shortcut
    Write-Output('removing ' + $shortcut + '...')
}

$shortcut = 'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\HP Documentation.lnk'
if (Test-Path $shortcut) {

    Remove-Item $shortcut
    Write-Output('removing ' + $shortcut + '...')
}
#endRegion

Write-Output('Script completed succsefully')
Stop-Transcript