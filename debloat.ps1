
# Windows 11 Debloater

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue."
    Start-Sleep 1
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}

$GetOSVersion = (Get-ItemProperty  -Path "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion").DisplayVersion

if ($GetOSVersion -ne '21H2') {
    throw "debloat-windows11 only works on Windows 11"
}


Clear-Host


$logsFolder = "$PWD\logs\"
If (Test-Path $logsFolder) {
    Write-Output "$logsFolder exists. Skipping."
}
Else {
    Write-Output "The log folder doesn't exist. This folder will be used for storing logs created after the script runs. Creating now."
    Start-Sleep 1
    New-Item -Path "$logsFolder" -ItemType Directory
    Write-Output "The folder $logsFolder was successfully created." `n
    Start-Sleep 1
}


# GUI Start Here

<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    debloat
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$DebloatWindows11                = New-Object system.Windows.Forms.Form
$DebloatWindows11.ClientSize     = New-Object System.Drawing.Point(600,500)
$DebloatWindows11.text           = "Debloat Windows 11"
$DebloatWindows11.TopMost        = $false
$DebloatWindows11.BackColor      = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$unpin                           = New-Object system.Windows.Forms.Button
$unpin.text                      = "Taskbar icons"
$unpin.width                     = 150
$unpin.height                    = 44
$unpin.location                  = New-Object System.Drawing.Point(29,29)
$unpin.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$disablecortana                  = New-Object system.Windows.Forms.Button
$disablecortana.text             = "Cortana"
$disablecortana.width            = 150
$disablecortana.height           = 44
$disablecortana.location         = New-Object System.Drawing.Point(210,29)
$disablecortana.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$vbs                             = New-Object system.Windows.Forms.Button
$vbs.text                        = "VBS"
$vbs.width                       = 150
$vbs.height                      = 44
$vbs.location                    = New-Object System.Drawing.Point(390,29)
$vbs.Font                        = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$DMode                           = New-Object system.Windows.Forms.Button
$DMode.text                      = "Dark Mode"
$DMode.width                     = 150
$DMode.height                    = 44
$DMode.location                  = New-Object System.Drawing.Point(29,75)
$DMode.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$LMode                           = New-Object system.Windows.Forms.Button
$LMode.text                      = "Light Mode"
$LMode.width                     = 150
$LMode.height                    = 44
$LMode.location                  = New-Object System.Drawing.Point(210,75)
$LMode.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$ListApps                        = New-Object system.Windows.Forms.Button
$ListApps.text                   = "Light Mode"
$ListApps.width                  = 150
$ListApps.height                 = 44
$ListApps.location               = New-Object System.Drawing.Point(390,75)
$ListApps.Font                   = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$DebloatWindows11.controls.AddRange(@($unpin,$disablecortana,$vbs,$DMode,$LMode,$ListApps))

$unpin.Add_Click({ removeTaskIcon })
$disablecortana.Add_Click({ cortana })
$vbs.Add_Click({ DisableVBS })
$DMode.Add_Click({ DarkMode })
$LMode.Add_Click({ LightMode })
$ListApps.Add_Click({ RemoveApps })

#Write your logic code here


function removeTaskIcon {
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
    $edgeKeyPath = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband"
    if(Test-Path $edgeKeyPath) {
        Remove-Item $edgeKeyPath -Recurse -Force
    }
    Stop-Process -Processname Explorer -WarningAction SilentlyContinue -Force
    Start-Sleep 5
    Start-Process -Processname Explorer -WarningAction SilentlyContinue
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

    $AppList = @(

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
        #"Microsoft.WindowsCamera"
        "microsoft.windowscommunicationsapps"
        "Microsoft.WindowsFeedbackHub"
        "Microsoft.WindowsMaps"
        "Microsoft.WindowsSoundRecorder"
        "Microsoft.Xbox.TCUI"
        "Microsoft.XboxApp"
        "Microsoft.XboxGameOverlay"
        "Microsoft.XboxIdentityProvider"
        "Microsoft.XboxSpeechToTextOverlay"
        "Microsoft.ZuneMusic"
        "Microsoft.ZuneVideo"

        #Sponsored Windows 11 AppX Apps
        #Add sponsored/featured apps to remove in the "*AppName*" format
        "*EclipseManager*"
        "*ActiproSoftwareLLC*"
        "*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
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
    foreach ($App in $AppList) {
        Get-AppxPackage -Name $App| Remove-AppxPackage
        Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $App | Remove-AppxProvisionedPackage -Online
        Write-Output "Trying to remove $Bloat."
    }
}


[void]$DebloatWindows11.ShowDialog()