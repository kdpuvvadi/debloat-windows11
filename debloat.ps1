
# Windows 11 Debloater

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue."
    Start-Sleep 1
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}
Clear-Host
$explorerPath = "HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

function SetLeftStart {
    Write-Host "Setting Start Menu to Left"
    
    if(Test-Path $explorerPath) {
        Set-ItemProperty -Path $explorerPath -Name TaskbarAl -Value 0
    }
    $checkStart = Get-ItemProperty -Path $explorerPath -Name TaskbarAl
    if( $checkStart.TaskbarAl -eq 0 ) {
        Write-Host "Setting Start Menu to Left Completed." -ForegroundColor Green -BackgroundColor white
    }

}

function RemoveChat {
    Write-Host "Setting Start Menu to Left"

    if(Test-Path $explorerPath) {
        Set-ItemProperty -Path $explorerPath -Name TaskbarMn -Value 0
    }
    $checkChat = Get-ItemProperty -Path $explorerPath -Name TaskbarMn
    if( $checkChat.TaskbarMn -eq 0 ) {
        Write-Host "Removing chat from Start Menu Completed." -ForegroundColor Green -BackgroundColor white
    }

}

function RemoveTaskView {
    Write-Host "Removing Taskview Button"

    if(Test-Path $explorerPath) {
        Set-ItemProperty -Path $explorerPath -Name ShowTaskViewButton -Value 0
    }
    $checkChat = Get-ItemProperty -Path $explorerPath -Name ShowTaskViewButton
    if( $checkChat.ShowTaskViewButton -eq 0 ) {
        Write-Host "Removing Taskview Button Completed." -ForegroundColor Green -BackgroundColor white
    }

}

function RemoveWidgeticon {
    Write-Host "Removing Widget Button"

    if(Test-Path $explorerPath) {
        Set-ItemProperty -Path $explorerPath -Name TaskbarDa -Value 0
    }
    $checkChat = Get-ItemProperty -Path $explorerPath -Name TaskbarDa
    if( $checkChat.TaskbarDa -eq 0 ) {
        Write-Host "Removing Widget Button Completed." -ForegroundColor Green -BackgroundColor white
    }

}

function RemoveSearchIcon {
    Write-Host "Removing search on Taskbar"
    $SearchKeyPath = "HKCU:Software\Microsoft\Windows\CurrentVersion\Search"

    if(Test-Path $explorerPath) {
        Set-ItemProperty -Path $SearchKeyPath -Name SearchboxTaskbarMode -Value 0
    }
    $checkSearch = Get-ItemProperty -Path $SearchKeyPath -Name SearchboxTaskbarMode
    if( $checkSearch.SearchboxTaskbarMode -eq 0 ) {
        Write-Host "Remove search on Taskbar Completed." -ForegroundColor Green -BackgroundColor white
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
