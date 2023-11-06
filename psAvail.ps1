#                   ___              _ __
#       ____  _____/   |_   ______ _(_) /
#      / __ \/ ___/ /| | | / / __ `/ / / 
#     / /_/ (__  ) ___ | |/ / /_/ / / /  
#    / .___/____/_/  |_|___/\__,_/_/_/   
#   /_/                                  
#________________________________________________   
# Simple PowerShell Availability Testing Script
#           By Winter Hundermark
#   https://github.com/WinterLily/psAvail/
#
#
## Get the required IP address to poll 
#
$ipExists = 'false'

while ($ipExists -eq 'false') {

    $ipAddress = Read-Host "[?] Enter IP address"

    if ($ipAddress -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}') {
        $ipExists = 'true'
        Write-Host "[+] IP address is $ipAddress"
    } else {
        Write-Host "[!] Invalid IP address. Try again."
    }
}
#
## Get the required port to poll 
#
$portExists = 'false'

while ($portExists -eq 'false') {

    $port = Read-Host "[?] Enter port"

    if ($port -match '\d{1,5}') {
        $portExists = 'true'
    } else {
        Write-Host "[!] Invalid port. Try again."
    }
}
#
## Get the requested timeout
#
$defaultTimeOut = 2000
#
$userTimeOutPrompt = Read-Host "[?] Would you like to set a custom timeout? (y/n) [Default = [$($defaultTimeOut)ms]]"
#
if ($userTimeOutPrompt -eq 'y') {
    $userTimeOut = Read-Host '[?] Please enter your desired timeout value:'
} else {
    $userTimeOut = $defaultTimeOut
}
#
## Initiate polling
#
if ($portExists -eq 'true' -AND $ipExists -eq 'true') {
    Write-Host "[+] Initiating polling for $ipAddress : $port"

    $socketIsOpen = 'false'

    while($socketIsOpen -eq 'false') {
        try {
            $socket = New-Object Net.Sockets.TcpClient
            if (!$socket.ConnectAsync($ipAddress, $port).wait($userTimeOut)) {
                Write-Host "[!] Port $port is closed on $ipAddress..."
                Start-Sleep -Seconds 1
            } else {
                $socketIsOpen = 'true'
                Write-Host "[+] Socket is open"
                break
            }

        } catch {
            Write-Host "[!] Port $port is closed on $ipAddress..."
            Start-Sleep -Seconds 1
        }
    }
}
#
## END 
#
