

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
## Initiate polling
#
if ($portExists -eq 'true' -AND $ipExists -eq 'true') {
    Write-Host "[+] Initiating polling for $ipAddress : $port"

    $socketIsOpen = 'false'

    while($socketIsOpen -eq 'false') {
        try {
            $socket = New-Object System.Net.Sockets.TcpClient($ipAddress, $port)
            $socketIsOpen = 'true'
            Write-Host "[+] Socket is open"
            break
        } catch {
            Write-Host "[!] Port $port is closed on $ipAddress..."
            Start-Sleep -Seconds 1
        }
    }
}