
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

$DebloatWindows11               = New-Object system.Windows.Forms.Form
$DebloatWindows11.ClientSize    = New-Object System.Drawing.Point(600,500)
$DebloatWindows11.text          = "Debloat Windows 11"
$DebloatWindows11.TopMost       = $false
$DebloatWindows11.BackColor     = [System.Drawing.ColorTranslator]::FromHtml("#ffffff")

$TaskbarLable                    = New-Object system.Windows.Forms.Label
$TaskbarLable.text               = "Taskbar"
$TaskbarLable.AutoSize           = $true
$TaskbarLable.width              = 25
$TaskbarLable.height             = 39
$TaskbarLable.location           = New-Object System.Drawing.Point(22,21)
$TaskbarLable.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',15,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold -bor [System.Drawing.FontStyle]::Underline))
$TaskbarLable.ForeColor          = [System.Drawing.ColorTranslator]::FromHtml("#857bfc")

$unpin                           = New-Object system.Windows.Forms.Button
$unpin.text                      = "unpin Taskbar icons"
$unpin.width                     = 161
$unpin.height                    = 39
$unpin.location                  = New-Object System.Drawing.Point(19,51)
$unpin.Font                      = New-Object System.Drawing.Font('Microsoft Sans Serif',12,[System.Drawing.FontStyle]([System.Drawing.FontStyle]::Bold))

$DebloatWindows11.controls.AddRange(@($TaskbarLable,$unpin))

$unpin.Add_Click({ removeTaskIcon })

#Write your logic code here


function removeTaskIcon {
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
    Stop-Process -Processname Explorer -WarningAction SilentlyContinue -ErrorAction SilentlyContinue -Force
    Start-Sleep 5
    Start-Process -Processname Explorer -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
    Start-Sleep 2
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



[void]$DebloatWindows11.ShowDialog()