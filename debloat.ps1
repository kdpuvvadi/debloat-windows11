
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

    $checkStart = Get-ItemProperty -Path $StartKeyPath -Name $StartKey

    if( $checkStart.$($tartKey) -eq 0 ) {
        Write-Host "Setting Start Menu to Left Completed."
    }

}

function RemoveChat {
    Write-Host "Setting Start Menu to Left"
    $ChatKeyPath = "HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $ChatKey = "TaskbarMn"

    if(Test-Path $StartKeyPath) {
        Set-ItemProperty -Path $ChatKeyPath -Name $ChatKey -Value 0
    }

    $checkStart = Get-ItemProperty -Path $ChatKeyPath -Name $ChatKey

    if( $checkStart.$($ChatKey) -eq 0 ) {
        Write-Host "Removing chat from Start Menu Completed."
    }

}


write-host -nonewline "Set Start Menu to Left?(Y/N)"
$response = read-host
if ( $response -match "[Y/y]" ) { SetLeftStart }

write-host -nonewline "Remove chat from Start?(Y/N)"
$response = read-host
if ( $response -match "[Y/y]" ) { RemoveChat }