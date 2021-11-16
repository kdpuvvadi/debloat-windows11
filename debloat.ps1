
# Windows 11 Debloater

function SetLeftStart {
    Write-Host "Setting Start Menu to Left"
    $StartKeyPath = "HKCU:Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $StartKey = "TaskbarAl"

    if(Test-Path $StartKeyPath) {
        Set-ItemProperty -Path $StartKeyPath -Name $StartKey -Value 0
    }
}

