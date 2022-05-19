$logFilePath = C:\logs\
$appName = "winGet-App-Removal.txt"

if (!$logFilePath) {

    mkdir $logFilePath
}
#Start Recording logs
Start-Transcript C:\logs\$appName -Force

#region remove apps
$appList = @('HP Documentation','HP Wolf Security','HP Security Update Service','HP Connection Optimizer','HP notifications','HP Wolf Security')

foreach($app in $applist) {
    if (winget search $app) {
        
        try {
            Write-Host "removing $app..."
            winget uninstall --accept-source-agreements --silent --name $app -erroraction silentlycontinue
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
}
#end region
#stop recording logs
Write-Host "Script completed succsefully"
Stop-Transcript
