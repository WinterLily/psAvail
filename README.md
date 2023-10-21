# psAvail
Lightweight PowerShell Utility for Testing Port Availability

## Description
This script was written as a little utility for assisting in managing infrastructure upgrades, to ensure that I would always be able to react immediately once a box had returned to function, to save time in such processes. 

## Usage 
Simply download the script and execute with:
```
./psAvail.ps1
```
Then follow the prompts to setup your availability test. 

## Output
If the host/part is accessible, then the script will immediately terminate and report that the socket is open: 
```
> .\psAvail.ps1
[?] Enter IP address: 192.168.2.111
[+] IP address is 192.168.2.111
[?] Enter port: 3389
[+] Initiating polling for 192.168.2.111 : 3389
[+] Socket is open
```
If the host/port is not accessible, then the script will continue polling until such time as the host becomes accessible or the probe is manually cancelled: 
```
> .\psAvail.ps1
[?] Enter IP address: 192.168.2.111
[+] IP address is 192.168.2.111
[?] Enter port: 3388
[+] Initiating polling for 192.168.2.111 : 3388
[!] Port 3388 is closed on 192.168.2.111...
[!] Port 3388 is closed on 192.168.2.111...
[!] Port 3388 is closed on 192.168.2.111...
[!] Port 3388 is closed on 192.168.2.111...
[!] Port 3388 is closed on 192.168.2.111...
[!] Port 3388 is closed on 192.168.2.111...
[!] Port 3388 is closed on 192.168.2.111...
[!] Port 3388 is closed on 192.168.2.111...
[!] Port 3388 is closed on 192.168.2.111...
```
