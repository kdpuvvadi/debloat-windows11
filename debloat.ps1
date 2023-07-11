# Windows 11 Debloater

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Write-Host "Elevation required. This script will self elevate to run as an Administrator and continue."
    Start-Sleep 1
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}

$logsFolder = "$PWD\logs\"
$logMessage = "The log folder doesn't exist. This folder will be used for storing logs created after the script runs. Creating now."
If (Test-Path $logsFolder) {
    Write-Output "$logsFolder exists. Skipping."
}
Else {
    Write-Output $logMessage
    Start-Sleep 1
    New-Item -Path "$logsFolder" -ItemType Directory
    Write-Output "The folder $logsFolder was successfully created." `n
    Start-Sleep 1
}
$logfile = Get-Date -Format "ddMMyyhh"
$logfilepath =  "$logsFolder/log-$logfile.log"
Start-Transcript -path $logfilepath -IncludeInvocationHeader -Append


Clear-Host


$GetOSVersion = (Get-ItemProperty  -Path "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion").CurrentBuildNumber
if ($GetOSVersion -lt '22000') {
    throw "Windows build number $GetOSVersion is not supported"
}

Add-Type -AssemblyName PresentationFramework

# GUI Start Here

<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    debloat
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$DebloatWindows11                = New-Object system.Windows.Forms.Form
$DebloatWindows11.ClientSize     = New-Object System.Drawing.Point(800,700)
$DebloatWindows11.text           = "Debloat Windows 11"
$DebloatWindows11.TopMost        = $false

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Taskbar and Start Menu"
$Label1.AutoSize                 = $true
$Label1.width                    = 40
$Label1.height                   = 20
$Label1.location                 = New-Object System.Drawing.Point(20,20)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',14,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))

$unpin                           = New-Object system.Windows.Forms.Button
$unpin.text                      = "Unpin Taskbar"
$unpin.width                     = 150
$unpin.height                    = 50
$unpin.location                  = New-Object System.Drawing.Point(20,70)
$unpin.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$unpin.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$unpin.BackColor                 = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$LeftMenu                        = New-Object system.Windows.Forms.Button
$LeftMenu.text                   = "Start to Left"
$LeftMenu.width                  = 150
$LeftMenu.height                 = 50
$LeftMenu.location               = New-Object System.Drawing.Point(220,70)
$LeftMenu.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$LeftMenu.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$LeftMenu.BackColor              = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$StartMenu                       = New-Object system.Windows.Forms.Button
$StartMenu.text                  = "Unpin Start Menu"
$StartMenu.width                 = 150
$StartMenu.height                = 50
$StartMenu.location              = New-Object System.Drawing.Point(420,70)
$StartMenu.Font                  = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$StartMenu.ForeColor             = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$StartMenu.BackColor             = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Appearance"
$Label2.AutoSize                 = $true
$Label2.width                    = 40
$Label2.height                   = 20
$Label2.location                 = New-Object System.Drawing.Point(20,150)
$Label2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',14,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))

$DMode                           = New-Object system.Windows.Forms.Button
$DMode.text                      = "Dark Mode"
$DMode.width                     = 150
$DMode.height                    = 50
$DMode.location                  = New-Object System.Drawing.Point(20,200)
$DMode.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$DMode.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$DMode.BackColor                 = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$LMode                           = New-Object system.Windows.Forms.Button
$LMode.text                      = "Light Mode"
$LMode.width                     = 150
$LMode.height                    = 50
$LMode.location                  = New-Object System.Drawing.Point(220,200)
$LMode.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$LMode.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$LMode.BackColor                 = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "Bloatware"
$Label3.AutoSize                 = $true
$Label3.width                    = 40
$Label3.height                   = 20
$Label3.location                 = New-Object System.Drawing.Point(20,280)
$Label3.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',14,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))

$disablecortana                  = New-Object system.Windows.Forms.Button
$disablecortana.text             = "Disable Cortana"
$disablecortana.width            = 150
$disablecortana.height           = 50
$disablecortana.location         = New-Object System.Drawing.Point(20,330)
$disablecortana.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$disablecortana.ForeColor        = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$disablecortana.BackColor        = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$vbs                             = New-Object system.Windows.Forms.Button
$vbs.text                        = "Disable VBS"
$vbs.width                       = 150
$vbs.height                      = 50
$vbs.location                    = New-Object System.Drawing.Point(220,330)
$vbs.Font                        = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$vbs.ForeColor                   = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$vbs.BackColor                   = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$ListApps                        = New-Object system.Windows.Forms.Button
$ListApps.text                   = "Uninstall Apps"
$ListApps.width                  = 150
$ListApps.height                 = 50
$ListApps.location               = New-Object System.Drawing.Point(420,330)
$ListApps.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$ListApps.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$ListApps.BackColor              = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$Privacy                         = New-Object system.Windows.Forms.Button
$Privacy.text                    = "Privacy"
$Privacy.width                   = 150
$Privacy.height                  = 50
$Privacy.location                = New-Object System.Drawing.Point(620,330)
$Privacy.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Privacy.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$Privacy.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$Label4                          = New-Object system.Windows.Forms.Label
$Label4.text                     = "Extras"
$Label4.AutoSize                 = $true
$Label4.width                    = 40
$Label4.height                   = 20
$Label4.location                 = New-Object System.Drawing.Point(20,502)
$Label4.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',14,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))

$EdgePDF                         = New-Object system.Windows.Forms.Button
$EdgePDF.text                    = "Edge PDF"
$EdgePDF.width                   = 150
$EdgePDF.height                  = 50
$EdgePDF.location                = New-Object System.Drawing.Point(20,552)
$EdgePDF.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$EdgePDF.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$EdgePDF.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$FileExt                         = New-Object system.Windows.Forms.Button
$FileExt.text                    = "File Extensions"
$FileExt.width                   = 150
$FileExt.height                  = 50
$FileExt.location                = New-Object System.Drawing.Point(220,552)
$FileExt.Font                    = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$FileExt.ForeColor               = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$FileExt.BackColor               = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$RemoveKeys                      = New-Object system.Windows.Forms.Button
$RemoveKeys.text                 = "Remove Keys"
$RemoveKeys.width                = 150
$RemoveKeys.height               = 50
$RemoveKeys.location             = New-Object System.Drawing.Point(20,425)
$RemoveKeys.Font                 = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$RemoveKeys.ForeColor            = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$RemoveKeys.BackColor            = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$Apps                            = New-Object system.Windows.Forms.Button
$Apps.text                       = "Install Apps"
$Apps.width                      = 150
$Apps.height                     = 50
$Apps.location                   = New-Object System.Drawing.Point(420,552)
$Apps.Font                       = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$Apps.ForeColor                  = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$Apps.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$OneDrive                        = New-Object system.Windows.Forms.Button
$OneDrive.text                   = "Uninstall OneDrive"
$OneDrive.width                  = 150
$OneDrive.height                 = 50
$OneDrive.location               = New-Object System.Drawing.Point(220,425)
$OneDrive.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$OneDrive.ForeColor              = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$OneDrive.BackColor              = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$3DDir                           = New-Object system.Windows.Forms.Button
$3DDir.text                      = "Remove 3D Objects Directory"
$3DDir.width                     = 150
$3DDir.height                    = 50
$3DDir.location                  = New-Object System.Drawing.Point(420,425)
$3DDir.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$3DDir.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$3DDir.BackColor                 = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$oldMenu                           = New-Object system.Windows.Forms.Button
$oldMenu.text                      = "Old Context Menu"
$oldMenu.width                     = 150
$oldMenu.height                    = 50
$oldMenu.location                  = New-Object System.Drawing.Point(420,200)
$oldMenu.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))
$oldMenu.ForeColor                 = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")
$oldMenu.BackColor                 = [System.Drawing.ColorTranslator]::FromHtml("#4a90e2")

$DebloatWindows11.controls.AddRange(@(
    $unpin,$disablecortana,$vbs,$DMode,$Apps,
    $LMode,$ListApps,$LeftMenu,$StartMenu,
    $EdgePDF,$Privacy,$FileExt,$RemoveKeys,
    $Label1,$Label2,$Label3,$Label4,
    $OneDrive,$3DDir,$oldMenu
    ))

$unpin.Add_Click({ removeTaskIcon })
$disablecortana.Add_Click({ cortana })
$vbs.Add_Click({ DisableVBS })
$DMode.Add_Click({ DarkMode })
$LMode.Add_Click({ LightMode })
$ListApps.Add_Click({ RemoveApps })
$LeftMenu.Add_Click({ leftMenu })
$StartMenu.Add_Click({ UnpinStart })
$EdgePDF.Add_Click({ Stop-EdgePDF })
$Privacy.Add_Click({ Protect-Privacy })
$FileExt.Add_Click({ ShowFileExt })
$RemoveKeys.Add_Click({ Remove-Keys })
$Apps.Add_Click({ InstallApps })
$OneDrive.Add_Click({ UninstallOneDrive  })
$3DDir.Add_Click({ Remove3dObjects })
$oldMenu.Add_Click({ ContextMenu })

#Write your logic code here

function ShowFileExt {
    
    Write-Output "Enabling File Extenstions" -ForegroundColor Red
    $ExpPath = "HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    if (Test-Path $ExpPath) {
        Set-ItemProperty -Path $ExpPath -Name HideFileExt -Value 0
    }
    Stop-Process -ProcessName Explorer -Force
    Start-Sleep 1
    Start-Process Explorer -Wait
    $extStatus = Get-ItemProperty $ExpPath -Name HideFileExt
    if ( $extStatus.HideFileExt -eq 0 ) {
        Write-Host "Done" -ForegroundColor Green -BackgroundColor white `n
    }
}

Function UninstallOneDrive {

    Write-Host "Checking for pre-existing files and folders located in the OneDrive folders..."
    Start-Sleep 1
    If (Test-Path "$env:USERPROFILE\OneDrive\*") {
        Write-Host "Files found within the OneDrive folder! Checking to see if a folder named OneDriveBackupFiles exists."
        Start-Sleep 1
              
        If (Test-Path "$env:USERPROFILE\Desktop\OneDriveBackupFiles") {
            Write-Host "A folder named OneDriveBackupFiles already exists on your desktop. All files from your OneDrive location will be moved to that folder." 
        }
        else {
            If (!(Test-Path "$env:USERPROFILE\Desktop\OneDriveBackupFiles")) {
                Write-Host "A folder named OneDriveBackupFiles will be created and will be located on your desktop. All files from your OneDrive location will be located in that folder."
                New-item -Path "$env:USERPROFILE\Desktop" -Name "OneDriveBackupFiles"-ItemType Directory -Force
                Write-Host "Successfully created the folder 'OneDriveBackupFiles' on your desktop."
            }
        }
        Start-Sleep 1
        Move-Item -Path "$env:USERPROFILE\OneDrive\*" -Destination "$env:USERPROFILE\Desktop\OneDriveBackupFiles" -Force
        Write-Host "Successfully moved all files/folders from your OneDrive folder to the folder 'OneDriveBackupFiles' on your desktop."
        Start-Sleep 1
        Write-Host "Proceeding with the removal of OneDrive."
        Start-Sleep 1
    }
    Else {
        Write-Host "Either the OneDrive folder does not exist or there are no files to be found in the folder. Proceeding with removal of OneDrive."
        Start-Sleep 1
        Write-Host "Enabling the Group Policy 'Prevent the usage of OneDrive for File Storage'."
        $OneDriveKey = 'HKLM:Software\Policies\Microsoft\Windows\OneDrive'
        If (!(Test-Path $OneDriveKey)) {
            Mkdir $OneDriveKey
            Set-ItemProperty $OneDriveKey -Name OneDrive -Value DisableFileSyncNGSC
        }
        Set-ItemProperty $OneDriveKey -Name OneDrive -Value DisableFileSyncNGSC
    }

    Write-Host "Uninstalling OneDrive. Please wait..."
    

    New-PSDrive  HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
    $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
    $ExplorerReg1 = "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
    $ExplorerReg2 = "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
    Stop-Process -Name "OneDrive*"
    Start-Sleep 2
    If (!(Test-Path $onedrive)) {
        $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"

        New-PSDrive  HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
        $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
        $ExplorerReg1 = "HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
        $ExplorerReg2 = "HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
        Stop-Process -Name "OneDrive*"
        Start-Sleep 2
        If (!(Test-Path $onedrive)) {
            $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
        }
        Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
        Start-Sleep 2
        Write-Output "Stopping explorer"
        Start-Sleep 1
        taskkill.exe /F /IM explorer.exe
        Start-Sleep 3
        Write-Output "Removing leftover files"
        Remove-Item "$env:USERPROFILE\OneDrive" -Force -Recurse
        Remove-Item "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse
        Remove-Item "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse
        If (Test-Path "$env:SYSTEMDRIVE\OneDriveTemp") {
            Remove-Item "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse
        }
        Write-Output "Removing OneDrive from windows explorer"
        If (!(Test-Path $ExplorerReg1)) {
            New-Item $ExplorerReg1
        }
        Set-ItemProperty $ExplorerReg1 System.IsPinnedToNameSpaceTree -Value 0 
        If (!(Test-Path $ExplorerReg2)) {
            New-Item $ExplorerReg2
        }
        Set-ItemProperty $ExplorerReg2 System.IsPinnedToNameSpaceTree -Value 0
        Write-Output "Restarting Explorer that was shut down before."
        Start-Process explorer.exe -NoNewWindow
    
        Write-Host "Enabling the Group Policy 'Prevent the usage of OneDrive for File Storage'."
        $OneDriveKey = 'HKLM:Software\Policies\Microsoft\Windows\OneDrive'
        If (!(Test-Path $OneDriveKey)) {
            Mkdir $OneDriveKey 
        }
        Start-Process $onedrive "/uninstall" -NoNewWindow -Wait
        Start-Sleep 2
        Write-Host "Stopping explorer"
        Start-Sleep 1
        taskkill.exe /F /IM explorer.exe
        Start-Sleep 3
        Write-Host "Removing leftover files"
        If (Test-Path "$env:USERPROFILE\OneDrive") {
            Remove-Item "$env:USERPROFILE\OneDrive" -Force -Recurse
        }
        If (Test-Path "$env:LOCALAPPDATA\Microsoft\OneDrive") {
            Remove-Item "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse
        }
        If (Test-Path "$env:PROGRAMDATA\Microsoft OneDrive") {
            Remove-Item "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse
        }
        If (Test-Path "$env:SYSTEMDRIVE\OneDriveTemp") {
            Remove-Item "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse
        }
        Write-Host "Removing OneDrive from windows explorer"
        If (!(Test-Path $ExplorerReg1)) {
            New-Item $ExplorerReg1
        }
        Set-ItemProperty $ExplorerReg1 System.IsPinnedToNameSpaceTree -Value 0 
        If (!(Test-Path $ExplorerReg2)) {
            New-Item $ExplorerReg2
        }
        Set-ItemProperty $ExplorerReg2 System.IsPinnedToNameSpaceTree -Value 0
        Write-Host "Restarting Explorer that was shut down before."
        Start-Process explorer.exe -NoNewWindow
        Write-Host "OneDrive has been successfully uninstalled!"
        
        Remove-item env:OneDrive
    }
}

Function Protect-Privacy {
            
    #Disables Windows Feedback Experience
    Write-Output "Disabling Windows Feedback Experience program"
    $Advertising = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
    If (Test-Path $Advertising) {
        Set-ItemProperty $Advertising Enabled -Value 0 
    }
            
    #Stops Cortana from being used as part of your Windows Search Function
    Write-Output "Stopping Cortana from being used as part of your Windows Search Function"
    $Search = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    If (Test-Path $Search) {
        Set-ItemProperty $Search AllowCortana -Value 0 
    }

    #Disables Web Search in Start Menu
    Write-Output "Disabling Bing Search in Start Menu"
    $WebSearch = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    Set-ItemProperty "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" BingSearchEnabled -Value 0 
    If (!(Test-Path $WebSearch)) {
        New-Item $WebSearch
    }
    Set-ItemProperty $WebSearch DisableWebSearch -Value 1 
            
    #Stops the Windows Feedback Experience from sending anonymous data
    Write-Output "Stopping the Windows Feedback Experience program"
    $Period = "HKCU:\Software\Microsoft\Siuf\Rules"
    If (!(Test-Path $Period)) { 
        New-Item $Period
    }
    Set-ItemProperty $Period PeriodInNanoSeconds -Value 0 

    #Prevents bloatware applications from returning and removes Start Menu suggestions               
    Write-Output "Adding Registry key to prevent bloatware apps from returning"
    $registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
    $registryOEM = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
    If (!(Test-Path $registryPath)) { 
        New-Item $registryPath
    }
    Set-ItemProperty $registryPath DisableWindowsConsumerFeatures -Value 1 

    If (!(Test-Path $registryOEM)) {
        New-Item $registryOEM
    }
    Set-ItemProperty $registryOEM  ContentDeliveryAllowed -Value 0 
    Set-ItemProperty $registryOEM  OemPreInstalledAppsEnabled -Value 0 
    Set-ItemProperty $registryOEM  PreInstalledAppsEnabled -Value 0 
    Set-ItemProperty $registryOEM  PreInstalledAppsEverEnabled -Value 0 
    Set-ItemProperty $registryOEM  SilentInstalledAppsEnabled -Value 0 
    Set-ItemProperty $registryOEM  SystemPaneSuggestionsEnabled -Value 0          
    
    #Prepping mixed Reality Portal for removal    
    Write-Output "Setting Mixed Reality Portal value to 0 so that you can uninstall it in Settings"
    $Holo = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Holographic"    
    If (Test-Path $Holo) {
        Set-ItemProperty $Holo  FirstRunSucceeded -Value 0 
    }

    #Disables Wi-fi Sense
    Write-Output "Disabling Wi-Fi Sense"
    $WifiSense1 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"
    $WifiSense2 = "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots"
    $WifiSense3 = "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config"
    If (!(Test-Path $WifiSense1)) {
        New-Item $WifiSense1
    }
    Set-ItemProperty $WifiSense1  Value -Value 0 
    If (!(Test-Path $WifiSense2)) {
        New-Item $WifiSense2
    }
    Set-ItemProperty $WifiSense2  Value -Value 0 
    Set-ItemProperty $WifiSense3  AutoConnectAllowedOEM -Value 0 
        
    #Disables live tiles
    Write-Output "Disabling live tiles"
    $Live = "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications"    
    If (!(Test-Path $Live)) {      
        New-Item $Live
    }
    Set-ItemProperty $Live  NoTileApplicationNotification -Value 1 
        
    #Turns off Data Collection via the Allow Telemetry key by changing it to 0
    Write-Output "Turning off Data Collection"
    $DataCollection1 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
    $DataCollection2 = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
    $DataCollection3 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection"    
    If (Test-Path $DataCollection1) {
        Set-ItemProperty $DataCollection1  AllowTelemetry -Value 0 
    }
    If (Test-Path $DataCollection2) {
        Set-ItemProperty $DataCollection2  AllowTelemetry -Value 0 
    }
    If (Test-Path $DataCollection3) {
        Set-ItemProperty $DataCollection3  AllowTelemetry -Value 0 
    }
    
    #Disabling Location Tracking
    Write-Output "Disabling Location Tracking"
    $SensorState = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}"
    $LocationConfig = "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration"
    If (!(Test-Path $SensorState)) {
        New-Item $SensorState
    }
    Set-ItemProperty $SensorState SensorPermissionState -Value 0 
    If (!(Test-Path $LocationConfig)) {
        New-Item $LocationConfig
    }
    Set-ItemProperty $LocationConfig Status -Value 0 
        
    #Disables People icon on Taskbar
    Write-Output "Disabling People icon on Taskbar"
    $People = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
    If (Test-Path $People) {
        Set-ItemProperty $People -Name PeopleBand -Value 0
    }
        
    #Disables scheduled tasks that are considered unnecessary 
    Write-Output "Disabling scheduled tasks"
    Get-ScheduledTask  XblGameSaveTaskLogon | Disable-ScheduledTask
    Get-ScheduledTask  XblGameSaveTask | Disable-ScheduledTask
    Get-ScheduledTask  Consolidator | Disable-ScheduledTask
    Get-ScheduledTask  UsbCeip | Disable-ScheduledTask
    Get-ScheduledTask  DmClient | Disable-ScheduledTask
    Get-ScheduledTask  DmClientOnScenarioDownload | Disable-ScheduledTask

    Write-Output "Stopping and disabling Diagnostics Tracking Service"
    #Disabling the Diagnostics Tracking Service
    Stop-Service "DiagTrack"
    Set-Service "DiagTrack" -StartupType Disabled

    
    Write-Output "Removing CloudStore from registry if it exists"
    $CloudStore = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore'
    If (Test-Path $CloudStore) {
        Stop-Process Explorer.exe -Force
        Remove-Item $CloudStore -Recurse -Force
        Start-Process Explorer.exe -Wait
    }
    Clear-Host
}

Function Stop-EdgePDF {
    
    #Stops edge from taking over as the default .PDF viewer    
    Write-Output "Stopping Edge from taking over as the default .PDF viewer"
    $NoPDF = "HKCR:\.pdf"
    $NoProgids = "HKCR:\.pdf\OpenWithProgids"
    $NoWithList = "HKCR:\.pdf\OpenWithList" 
    If (!(Get-ItemProperty $NoPDF  NoOpenWith)) {
        New-ItemProperty $NoPDF NoOpenWith 
    }        
    If (!(Get-ItemProperty $NoPDF  NoStaticDefaultVerb)) {
        New-ItemProperty $NoPDF  NoStaticDefaultVerb 
    }        
    If (!(Get-ItemProperty $NoProgids  NoOpenWith)) {
        New-ItemProperty $NoProgids  NoOpenWith 
    }        
    If (!(Get-ItemProperty $NoProgids  NoStaticDefaultVerb)) {
        New-ItemProperty $NoProgids  NoStaticDefaultVerb 
    }        
    If (!(Get-ItemProperty $NoWithList  NoOpenWith)) {
        New-ItemProperty $NoWithList  NoOpenWith
    }        
    If (!(Get-ItemProperty $NoWithList  NoStaticDefaultVerb)) {
        New-ItemProperty $NoWithList  NoStaticDefaultVerb 
    }
            
    #Appends an underscore '_' to the Registry key for Edge
    $Edge = "HKCR:\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_"
    If (Test-Path $Edge) {
        Set-Item $Edge AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_ 
    }
    Clear-Host
}

function leftMenu {
    $ErrorActionPreference = 'silentlycontinue'

    $explorerPath = "HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

    Write-Host "Setting Start Menu to Left" -ForegroundColor Red
    if(Test-Path $explorerPath) {
        Set-ItemProperty -Path $explorerPath -Name TaskbarAl -Value 0
    }
    $checkStart = Get-ItemProperty -Path $explorerPath -Name TaskbarAl
    if( $checkStart.TaskbarAl -eq 0 ) {
        Write-Host "Done" -ForegroundColor Green -BackgroundColor white `n
    }
}

function removeTaskIcon {
    $ErrorActionPreference = 'silentlycontinue'

    $explorerPath = "HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

    Write-Host "Setting Start Menu to Left" -ForegroundColor Red
    if(Test-Path $explorerPath) {
        Set-ItemProperty -Path $explorerPath -Name TaskbarMn -Value 0
    }
    $checkChat = Get-ItemProperty -Path $explorerPath -Name TaskbarMn
    if( $checkChat.TaskbarMn -eq 0 ) {
        Write-Host "Done" -ForegroundColor Green -BackgroundColor white `n
    }

    Write-Host "Removing Taskview Button" -ForegroundColor Red
    if(Test-Path $explorerPath) {
        Set-ItemProperty -Path $explorerPath -Name ShowTaskViewButton -Value 0
    }
    $checkChat = Get-ItemProperty -Path $explorerPath -Name ShowTaskViewButton
    if( $checkChat.ShowTaskViewButton -eq 0 ) {
        Write-Host "Done" -ForegroundColor Green -BackgroundColor white `n
    }

    Write-Host "Removing Widget Button" -ForegroundColor Red
    if(Test-Path $explorerPath) {
        Set-ItemProperty -Path $explorerPath -Name TaskbarDa -Value 0
    }
    $checkChat = Get-ItemProperty -Path $explorerPath -Name TaskbarDa
    if( $checkChat.TaskbarDa -eq 0 ) {
        Write-Host "Done" -ForegroundColor Green -BackgroundColor white `n
    }


    Write-Host "Removing search on Taskbar" -ForegroundColor Red
    $SearchKeyPath = "HKCU:Software\Microsoft\Windows\CurrentVersion\Search"
    if(Test-Path $explorerPath) {
        Set-ItemProperty -Path $SearchKeyPath -Name SearchboxTaskbarMode -Value 0
    }
    $checkSearch = Get-ItemProperty -Path $SearchKeyPath -Name SearchboxTaskbarMode
    if( $checkSearch.SearchboxTaskbarMode -eq 0 ) {
        Write-Host "Done" -ForegroundColor Green -BackgroundColor white `n
    }

    # Remove edge taskbar icon
    Write-Host "Removing Microsft Edge from taskbar" -ForegroundColor Red
    $edgeKeyPath = "HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband"
    if(Test-Path $edgeKeyPath) {
        Remove-Item $edgeKeyPath -Recurse -Force
    }
    Stop-Process -Processname Explorer -WarningAction SilentlyContinue -Force
    Start-Sleep 5
    Start-Process Explorer -Wait -WarningAction SilentlyContinue
    Start-Sleep 1
    Write-Host "Done" -ForegroundColor Green -BackgroundColor white `n
}

Function cortana {
    Write-Host "Disabling Cortana" -ForegroundColor Red 
    $Cortana1 = "HKCU:\SOFTWARE\Microsoft\Personalization\Settings"
    $Cortana2 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization"
    $Cortana3 = "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore"
    If (!(Test-Path $Cortana1)) {
        New-Item $Cortana1
    }
    Set-ItemProperty $Cortana1 AcceptedPrivacyPolicy -Value 0 
    If (!(Test-Path $Cortana2)) {
        New-Item $Cortana2
    }
    Set-ItemProperty $Cortana2 RestrictImplicitTextCollection -Value 1 
    Set-ItemProperty $Cortana2 RestrictImplicitInkCollection -Value 1 
    If (!(Test-Path $Cortana3)) {
        New-Item $Cortana3
    }
    Set-ItemProperty $Cortana3 HarvestContacts -Value 0
    Write-Host "Done" -ForegroundColor Red -BackgroundColor White `n
}

Function UnpinStart {

$START_MENU_LAYOUT = @"
<LayoutModificationTemplate xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout" xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout" Version="1" xmlns:taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout" xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification">
    <LayoutOptions StartTileGroupCellWidth="6" />
    <DefaultLayoutOverride>
        <StartLayoutCollection>
            <defaultlayout:StartLayout GroupCellWidth="6" />
        </StartLayoutCollection>
    </DefaultLayoutOverride>
</LayoutModificationTemplate>
"@

    $layoutFile="C:\Windows\StartMenuLayout.xml"

    #Delete layout file if it already exists
    If(Test-Path $layoutFile)
    {
        Remove-Item $layoutFile
    }

    #Creates the blank layout file
    $START_MENU_LAYOUT | Out-File $layoutFile -Encoding ASCII

    $regAliases = @("HKLM", "HKCU")

    #Assign the start layout and force it to apply with "LockedStartLayout" at both the machine and user level
    foreach ($regAlias in $regAliases){
        $basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
        $keyPath = $basePath + "\Explorer" 
        IF(!(Test-Path -Path $keyPath)) { 
            New-Item -Path $basePath -Name "Explorer"
        }
        Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 1
        Set-ItemProperty -Path $keyPath -Name "StartLayoutFile" -Value $layoutFile
    }

    #Restart Explorer, open the start menu (necessary to load the new layout), and give it a few seconds to process
    Stop-Process -name explorer
    Start-Sleep -s 5
    $wshell = New-Object -ComObject wscript.shell; $wshell.SendKeys('^{ESCAPE}')
    Start-Sleep -s 5

    #Enable the ability to pin items again by disabling "LockedStartLayout"
    foreach ($regAlias in $regAliases){
        $basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
        $keyPath = $basePath + "\Explorer" 
        Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 0
    }

    #Restart Explorer and delete the layout file
    Stop-Process -name explorer

    Remove-Item $layoutFile
}


function DisableVBS {
    Write-Host "Disabling Virtualization based Security" -ForegroundColor Red
    $VBSPath = "HKLM:SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"

    if(Test-Path $VBSPath) {
        Set-ItemProperty -Path $VBSPath -Name Enabled -Value 0
    }
    $checkSearch = Get-ItemProperty -Path $VBSPath -Name Enabled
    if( $checkSearch.Enabled -eq 0 ) {
        Write-Host "Done" -ForegroundColor Green -BackgroundColor white `n
    }

}


function DarkMode {
    Write-Host "Enabling Darkmode. Please wait..." -ForegroundColor Red
    $DarkModePath = "HKCU:Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    Start-Sleep 2
    Set-ItemProperty -Path $DarkModePath -Name AppsUseLightTheme -Value 0
    Set-ItemProperty -Path $DarkModePath -Name SystemUsesLightTheme -Value 0
    Write-Host "Done" -ForegroundColor Green -BackgroundColor White
    Write-Host
}

function LightMode {
    Write-Host "Enabling Light mode. Please wait..." -ForegroundColor Red
    $LightModePath = "HKCU:Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    Start-Sleep 2
    Set-ItemProperty -Path $LightModePath -Name AppsUseLightTheme -Value 1
    Set-ItemProperty -Path $LightModePath -Name SystemUsesLightTheme -Value 1
    Write-Host "Done" -ForegroundColor Green -BackgroundColor White
    Write-Host 
}

Function RemoveApps {

    $RemoveAppList = @(

        #Unnecessary Windows 11 AppX Apps
        "Microsoft.BingNews"
        "Microsoft.GetHelp"
        "Microsoft.Getstarted"
        "Microsoft.Messaging"
        "Microsoft.Microsoft3DViewer"
        "Microsoft.MicrosoftOfficeHub"
        "Microsoft.MicrosoftSolitaireCollection"
        "Microsoft.NetworkSpeedTest"
        "Microsoft.News"
        "Microsoft.Office.Lens"
        "Microsoft.Office.OneNote"
        "Microsoft.Office.Sway"
        "Microsoft.OneConnect"
        "Microsoft.People"
        "Microsoft.Print3D"
        "Microsoft.RemoteDesktop"
        "Microsoft.SkypeApp"
        "Microsoft.StorePurchaseApp"
        "Microsoft.Office.Todo.List"
        "Microsoft.Whiteboard"
        "Microsoft.WindowsAlarms"
	"Microsoft.MicrosoftStickyNotes"
 	"MicrosoftCorporationII.QuickAssist"
  	"MicrosoftTeams"
        #"Microsoft.WindowsCamera"
        "microsoft.windowscommunicationsapps"
        "Microsoft.WindowsFeedbackHub"
        "Microsoft.WindowsMaps"
        "Microsoft.WindowsSoundRecorder"
        "Microsoft.Xbox.TCUI"
        "Microsoft.XboxApp"
	"Microsoft.GamingApp"
 	"Microsoft.GamingServices"
        "Microsoft.XboxGamingOverlay"
        "Microsoft.XboxIdentityProvider"
        "Microsoft.XboxSpeechToTextOverlay"
	"Microsoft.XboxDevices"
        "Microsoft.ZuneMusic"
        "Microsoft.ZuneVideo"
        # ClipChamp package name & Package family name. Little stubborn it is.
        "Clipchamp.Clipchamp_yxz26nhyzhsrt"
        "Clipchamp.Clipchamp"
        "Microsoft.YourPhone"
        "Microsoft.MSPaint"
        "Microsoft.MixedReality.Portal"
	"Microsoft.Todos"
	"Microsoft.PowerAutomateDesktop"
	#McAfee
	"5A894077.McAfeeSecurity"
	#Asus Specific
	"B9ECED6F.ScreenPadMaster"
	"B9ECED6F.ASUSPCAssistant"
        #Sponsored Windows 11 AppX Apps
        #Add sponsored/featured apps to remove in the "*AppName*" format
        "*EclipseManager*"
        "*ActiproSoftwareLLC*"
        "AdobeSystemsIncorporated.AdobePhotoshopExpress"
        "*Duolingo-LearnLanguagesforFree*"
        "*PandoraMediaInc*"
        "*CandyCrush*"
        "*BubbleWitch3Saga*"
        "*Wunderlist*"
        "*Flipboard*"
        "*Twitter*"
        "*Facebook*"
        "*Spotify*"
        "*Minecraft*"
        "*Royal Revolt*"
        "*Sway*"
        "*Speed Test*"
        "*Dolby*"
    )
    foreach ($RemoveApp in $RemoveAppList) {
        Write-Host -NoNewline "Trying to remove $RemoveApp."
        Get-AppxPackage -Name $RemoveApp | Remove-AppxPackage
        Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $RemoveApp | Remove-AppxProvisionedPackage -Online
        if ($?) {
            Write-Host " Done" -ForegroundColor Green
        }
    }
    
	#Setting these keys is nessasary if on-demand apps (like instagram, Amazon Prime etc.) should be removed from start menu.
	#Those apps are not installed and cannot be uninstalled since they get installed after you click on them
	$ccExist = Test-path -Path "HKLM:Software\Policies\Microsoft\Windows\CloudContent"
	if (!$ccExist)
	{
		New-Item -Path "HKLM:Software\Policies\Microsoft\Windows" -Name CloudContent 
	}
	New-ItemProperty -Path "HKLM:Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableConsumerAccountStateContent" -Value "1"  -PropertyType "DWORD" -Force
	New-ItemProperty -Path "HKLM:Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableCloudOptimizedContent" -Value "1"  -PropertyType "DWORD" -Force
	
	#!!!Enable this if you want to reset values to default!!!
	#Remove-Item -Path "HKLM:Software\Policies\Microsoft\Windows\CloudContent" -Force
}

Function Remove-Keys {
        
    #These are the registry keys that it will delete.
            
    $Keys = @(
            
        #Remove Background Tasks
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.BackgroundTasks\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
            
        #Windows File
        "HKCR:\Extensions\ContractId\Windows.File\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
            
        #Registry keys to delete if they aren't uninstalled by RemoveAppXPackage/RemoveAppXProvisionedPackage
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\46928bounde.EclipseManager_2.2.4.51_neutral__a5h4egax66k6y"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Launch\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
            
        #Scheduled Tasks to delete
        "HKCR:\Extensions\ContractId\Windows.PreInstalledConfigTask\PackageId\Microsoft.MicrosoftOfficeHub_17.7909.7600.0_x64__8wekyb3d8bbwe"
            
        #Windows Protocol Keys
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.PPIProjection_10.0.15063.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.15063.0.0_neutral_neutral_cw5n1h2txyewy"
        "HKCR:\Extensions\ContractId\Windows.Protocol\PackageId\Microsoft.XboxGameCallableUI_1000.16299.15.0_neutral_neutral_cw5n1h2txyewy"
               
        #Windows Share Target
        "HKCR:\Extensions\ContractId\Windows.ShareTarget\PackageId\ActiproSoftwareLLC.562882FEEB491_2.6.18.18_neutral__24pqs290vpjk0"
    )
        
    #This writes the output of each key it is removing and also removes the keys listed above.
    ForEach ($Key in $Keys) {
        Write-Output "Removing $Key from registry"
        Remove-Item $Key -Recurse
    }
    Clear-Host
}

function InstallApps {

    $Warn = [Windows.MessageBoxImage]::Warning
    $Button = [Windows.MessageBoxButton]::YesNoCancel

    $InstallNET = "Do you want to install .NET 3.5?"
    $InstallWinget = "Do you want to install Winget Package Manager"

    $Prompt1 = [Windows.MessageBox]::Show($InstallNET, "Install .Net", $Button, $Warn)
        Switch ($Prompt1) {
            Yes {
                Write-Host "Initializing the installation of .NET 3.5..."
                DISM /Online /Enable-Feature /FeatureName:NetFx3 /All
                Write-Host ".NET 3.5 has been successfully installed!"
            }
            No {
                Write-Host "Skipping .NET install."
            }
        }
    
    #check winget installation
    winget -v 
    if (!$?) { 
        $Prompt2 = [Windows.MessageBox]::Show($InstallWinget, "Install Winget", $Button, $Warn)
        $wingetURI = 'https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
    
        Switch ($Prompt2) {
            Yes {
                Write-Host "Downloading the winget package"
                Invoke-WebRequest -Uri $wingetURI -OutFile $env:TEMP/winget.msixbundle
                Add-AppPackage -Path $env:TEMP/winget.msixbundle
                Write-Host "winget has been successfully installed!"
                Remove-Item -Path $env:TEMP/winget.msixbundle
            }
            No {
                Write-Host "Skipping winget install."
            }
        } 
    } 
    winget -v
    if ($?) { 

        $apps = @{

            'Google Chrome' = 'Google.Chrome'
            'Mazilla Firefox' = 'Mozilla.Firefox'
            '7-Zip' = '7zip.7zip'
            'VLC Media Player' = 'VideoLAN.VLC'
            'Notepad++' = 'Notepad++.Notepad++'
            'Visual Studio Code' = 'Microsoft.VisualStudioCode'
            'Powertoys' = 'Microsoft.PowerToys'
            'WinDirStat' = 'WinDirStat.WinDirStat'
            'Git' = 'Git.Git'
            'Github CLI' = 'GitHub.cli'
            'NodeJS' = 'OpenJS.NodeJS.LTS'
            'Python 3' = 'Python.Python.3'
            'Postman' = 'Postman.Postman'
            'Docker Desktop' = 'Docker.DockerDesktop'
        }
        
        foreach($app in $apps.GetEnumerator()) {

            $AppPrompt = [Windows.MessageBox]::Show("Install $($app.Name)", $($app.Name), $Button, $Warn)

            Switch ($AppPrompt) {
                Yes {
                    Write-Host "Installing $($app.Name)"
                    winget install --id $($app.value) --silent --accept-source-agreements --accept-package-agreements
                    Write-Host "$($app.Name) has been successfully installed!"
                }
                No {
                    Write-Host "Skipping $($app.Name)"
                }
            }   

        }
    }
    
}

Function Remove3dObjects {
    #Removes 3D Objects from the 'My Computer' submenu in explorer
    Write-Host "Removing 3D Objects from explorer 'My Computer' submenu"
    $Objects32 = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
    $Objects64 = "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"
    If (Test-Path $Objects32) {
        Remove-Item $Objects32 -Recurse
        Stop-Process -ProcessName explorer -Force
    }
    If (Test-Path $Objects64) {
        Remove-Item $Objects64 -Recurse 
        Stop-Process -ProcessName explorer -Force
    }
    if ( 
	    ( -not (Test-Path $Objects32) ) -and (-not (Test-Path $Objects64)) 
        ) 
        {
            Write-Host "Done"-ForegroundColor Green -BackgroundColor white `n 
        }
    Start-Process explorer -Wait
}

function ContextMenu {
    $menuPath = "HKCU:Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
    New-Item -Path $menuPath -Value 1 -Force
    Stop-Process -Processname Explorer -WarningAction SilentlyContinue -Force
    Start-Sleep 5
    Start-Process Explorer -Wait -WarningAction SilentlyContinue
    Start-Sleep 1
    Write-Host "Done" -ForegroundColor Green -BackgroundColor white `n
} 

[void]$DebloatWindows11.ShowDialog()
