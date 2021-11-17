
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
$explorerPath = "HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

function SetLeftStart {
    Write-Host "Setting Start Menu to Left" -ForegroundColor Red
    
    if(Test-Path $explorerPath) {
        Set-ItemProperty -Path $explorerPath -Name TaskbarAl -Value 0
    }
    $checkStart = Get-ItemProperty -Path $explorerPath -Name TaskbarAl
    if( $checkStart.TaskbarAl -eq 0 ) {
        Write-Host "Done" -ForegroundColor Green -BackgroundColor white
    }

}

function RemoveChat {
    Write-Host "Setting Start Menu to Left" -ForegroundColor Red

    if(Test-Path $explorerPath) {
        Set-ItemProperty -Path $explorerPath -Name TaskbarMn -Value 0
    }
    $checkChat = Get-ItemProperty -Path $explorerPath -Name TaskbarMn
    if( $checkChat.TaskbarMn -eq 0 ) {
        Write-Host "Done" -ForegroundColor Green -BackgroundColor white
    }

}

function RemoveTaskView {
    Write-Host "Removing Taskview Button" -ForegroundColor Red

    if(Test-Path $explorerPath) {
        Set-ItemProperty -Path $explorerPath -Name ShowTaskViewButton -Value 0
    }
    $checkChat = Get-ItemProperty -Path $explorerPath -Name ShowTaskViewButton
    if( $checkChat.ShowTaskViewButton -eq 0 ) {
        Write-Host "Done" -ForegroundColor Green -BackgroundColor white
    }

}

function RemoveWidgeticon {
    Write-Host "Removing Widget Button" -ForegroundColor Red

    if(Test-Path $explorerPath) {
        Set-ItemProperty -Path $explorerPath -Name TaskbarDa -Value 0
    }
    $checkChat = Get-ItemProperty -Path $explorerPath -Name TaskbarDa
    if( $checkChat.TaskbarDa -eq 0 ) {
        Write-Host "Done" -ForegroundColor Green -BackgroundColor white
    }

}

function RemoveSearchIcon {
    Write-Host "Removing search on Taskbar" -ForegroundColor Red
    $SearchKeyPath = "HKCU:Software\Microsoft\Windows\CurrentVersion\Search"

    if(Test-Path $explorerPath) {
        Set-ItemProperty -Path $SearchKeyPath -Name SearchboxTaskbarMode -Value 0
    }
    $checkSearch = Get-ItemProperty -Path $SearchKeyPath -Name SearchboxTaskbarMode
    if( $checkSearch.SearchboxTaskbarMode -eq 0 ) {
        Write-Host "Done" -ForegroundColor Green -BackgroundColor white
    }

}

function DisableVBS {
    Write-Host "Disabling Virtualization based Security" -ForegroundColor Red
    $VBSPath = "HKLM:SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"

    if(Test-Path $VBSPath) {
        Set-ItemProperty -Path $VBSPath -Name Enabled -Value 0
    }
    $checkSearch = Get-ItemProperty -Path $VBSPath -Name Enabled
    if( $checkSearch.Enabled -eq 0 ) {
        Write-Host "Done" -ForegroundColor Green -BackgroundColor white
    }

}



write-host -nonewline "Set Start Menu to Left?(Y/N)"
$response = read-host
if ( $response -match "[Y/y]" ) { SetLeftStart }

write-host -nonewline "Remove chat from Start?(Y/N)"
$response = read-host
if ( $response -match "[Y/y]" ) { RemoveChat }

write-host -nonewline "Remove Search from Taskbar?(Y/N)"
$response = read-host
if ( $response -match "[Y/y]" ) { RemoveSearchIcon }

write-host -nonewline "Remove Taskview Button from Taskbar?(Y/N)"
$response = read-host
if ( $response -match "[Y/y]" ) { RemoveTaskView }

write-host -nonewline "Remove Widget Button from Taskbar?(Y/N)"
$response = read-host
if ( $response -match "[Y/y]" ) { RemoveWidgeticon }

write-host -nonewline "Disable VBS?(Y/N)"
$response = read-host
if ( $response -match "[Y/y]" ) { DisableVBS }
