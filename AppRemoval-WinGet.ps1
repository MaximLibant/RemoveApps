$logFilePath = C:\logs\
$appName = "winGet-App-Removal"

#Start Recording logs
Start-Transcript C:\logs\$appName -Force

#region remove apps
$appList = @('HP Documentation','HP Wolf Security','HP Security Update Service','HP Connection Optimizer','HP notifications','HP Wolf Security')

foreach($app in $applist) {
    if (winget search $app) {
        
        winget uninstall --accept-source-agreements --silent --name $app -erroraction silentlycontinue   
    }
}
#end region

#stop recording logs
Stop-Transcript
