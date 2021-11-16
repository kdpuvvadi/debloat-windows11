
# Windows 11 Debloater

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue."
    Start-Sleep 1
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit
}


function SetLeftStart {
    Write-Host "Setting Start Menu to Left"
    $StartKeyPath = "HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $StartKey = "TaskbarAl"

    if(Test-Path $StartKeyPath) {
        Set-ItemProperty -Path $StartKeyPath -Name $StartKey -Value 0
    }
}

write-host -nonewline "Set Start Menu to Left?(Y/N)"
$response = read-host
if ( $response -match "[Y/y]" ) { SetLeftStart }