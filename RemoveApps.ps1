#Remove all annoying HP apps
$appList = Get-AppxPackage -allusers | where-object {$_.name -match "HP"}

foreach ($app in $appList) {
    Remove-AppxPackage -package $app -erroraction silentlycontinue
    Write-Output('removing ' + $app + '...')
}

#remove annoying TCO Certified shortcut
$tcoPath = 'C:\Users\public\Desktop\TCO Certified.ink'

if (Test-Path -path $tcoPath -PathType Leaf){

    remove-item -path $tcoPath

}