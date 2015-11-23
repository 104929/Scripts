#This Script uses the .StartMode method, this method grabs the startuptype of the certain WMI object,
#so make sure before adding any services to the list
#make sure you know how to use this method properly in order to correctly script this for everyone to use during the competition.
#Also, some servives im not really sure whether they should be running or not, so make sure that the services are correct as well.

#Checks for Admin Rights
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
    {
        Write-Warning "You do not have Admin rights to run the script!`nPlease re-run this script as an Administrator!"
        Break
    }

#Variables that will be used.
#Variables for service names
$RAACM = Get-Service -Name RasAuto
$RACM = Get-Service -Name RasMan
$RDC = Get-Service -Name SessionEnv
$RDS = Get-Service -Name TermService #needs to be added
$RDSUPRD = Get-Service -Name UmRdpService #needs to be added
$RPC = Get-Service -Name RpcSs
$RPCL = Get-Service -Name RpcLocator #needs to be added
$RR = Get-Service -Name RemoteRegistry #needs to be added
$RAR = Get-Service -Name RemoteAccess #needs to be added
$SL = Get-Service -Name seclogon #needs to be added
$WF = Get-Service -Name MpsSvc
$WU = Get-Service -Name wuauserv
$T = Get-Service -Name TapiSrv
$WD = Get-Service -Name WinDefend
$CB = Get-Service -Name Browser
$DHCPC = Get-Service -Name Dhcp
$DNSC = Get-Service -Name Dnscache
$GPC = Get-Service -Name gpsvc
$NC = Get-Service -Name Netman
$BSS = Get-Service -Name bthserv
$HGP = Get-Service -Name HomeGroupProvider
$HGL = Get-Service -Name HomeGroupListener

#Variables for Status type
$RAACMST = (Get-WmiObject Win32_service -Filter 'name = "RasAuto"').StartMode
$RACMST = (Get-WmiObject Win32_service -Filter 'name = "RasMan"').StartMode
$RDCST = (Get-WmiObject Win32_service -Filter 'name = "SessionEnv"').StartMode
$RDSST = (Get-WmiObject Win32_service -Filter 'name = "TermService"').StartMode #needs to be added; only disabled if readme says to
$RDSUPRDST = (Get-WmiObject Win32_service -Filter 'name = "UmRdpService"').StartMode #needs to be added; Needs To Be off
$RPCST = (Get-WmiObject Win32_service -Filter 'name = "RpcSs"').StartMode
$RPCLST = (Get-WmiObject Win32_service -Filter 'name = "RpcLocator"').StartMode #needs to be added; Needs To Be off
$RRST = (Get-WmiObject Win32_service -Filter 'name = "RemoteRegistry"').StartMode #needs to be added; Needs To Be off
$RARST = (Get-WmiObject Win32_service -Filter 'name = "RemoteAccess"').StartMode #needs to be added; only disabled if readme says to
$SLST = (Get-WmiObject Win32_service -Filter 'name = "seclogon"').StartMode #needs to be added; Needs To Be off
$WFST = (Get-WmiObject Win32_service -Filter 'name = "MpsSvc"').StartMode
$WUST = (Get-WmiObject Win32_Service -Filter 'name = "wuauserv"').StartMode
$TST = (Get-WmiObject Win32_Service -Filter 'name = "TapiSrv"').StartMode
$WDST = (Get-WmiObject Win32_Service -Filter 'name = "WinDefend"').StartMode
$CBST = (Get-WmiObject Win32_Service -Filter 'name = "Browser"').StartMode
$DHCPCST = (Get-WmiObject Win32_Service -Filter 'name = "Dhcp"').StartMode
$DNSCST = (Get-WmiObject Win32_Service -Filter 'name = "Dnscache"').StartMode
$GPCST = (Get-WmiObject Win32_Service -Filter 'name = "gpsvc"').StartMode
$NCST = (Get-WmiObject Win32_Service -Filter 'name = "Netman"').StartMode
$BSSST = (Get-WmiObject Win32_Service -Filter 'name = "bthserv"').StartMode
$HGPST = (Get-WmiObject Win32_Service -Filter 'name = "HomeGroupProvider"').StartMode
$HGLST = (Get-WmiObject Win32_Service -Filter 'name = "HomeGroupListener"').StartMode

#First Checking if Services that need to be on are on

#Computer Browser

if($CBST -eq 'Disabled'){
    Write-Host -ForegroundColor Red 'Computer Browser Service is not correctly configured script will configure it'
    Set-Service -Name Browser -StartupType Manual
    
        }else{if($CBST -eq 'Automatic'){
            Write-Host -ForegroundColor Yellow 'Computer Browser was set to Automatic, for security reasons, it will be set to Manual'
            Set-Service -Name Browser -StartupType Manual}else{Write-Host -ForegroundColor Green 'Computer Browser startup type is correct'}
        }
if($CB.Status -ne 'Running'){
    Write-Host -ForegroundColor Red 'Computer Browser service is not running, script will now turn it on'
    Start-Service $CB}else{Write-Host -ForegroundColor Green 'Browser service is up and running'}
    
#DHCP Client Service

if($DHCPCST -eq 'Disabled'){
    Write-Host -ForegroundColor Red 'DHCP Client Service is not correctly configured script will configure it'
    Set-Service -Name Dnscache -StartupType Automatic
    
        }else{if($DHCPCST -eq 'Manual'){
            Write-Host -ForegroundColor Yellow 'DHCP Client was set to Manual, for security reasons, it will be set to automatic'
            Set-Service -Name Dnscache -StartupType Automatic}else{Write-Host -ForegroundColor Green 'DHCP Client startup type is correct'}
        }
if($DHCPC.Status -ne 'Running'){
    Write-Host -ForegroundColor Red 'DHCP Client service is not running, script will now turn it on'
    Start-Service $DHCPC}else{Write-Host -ForegroundColor Green 'DHCP Client service is up and running'}
    
#DNS Client Service

if($DNSCST -eq 'Disabled'){
    Write-Host -ForegroundColor Red 'DNS Client Service is not correctly configured script will configure it'
    Set-Service -Name Dhcp -StartupType Automatic
    
        }else{if($DNSCST -eq 'Manual'){
            Write-Host -ForegroundColor Yellow 'DNS Client was set to Manual, for security reasons, it will be set to automatic'
            Set-Service -Name Dhcp -StartupType Automatic}else{Write-Host -ForegroundColor Green 'DNS Client startup type is correct'}
        }
if($DNSC.Status -ne 'Running'){
    Write-Host -ForegroundColor Red 'DNS Client service is not running, script will now turn it on'
    Start-Service $DNSC}else{Write-Host -ForegroundColor Green 'DNS Client service is up and running'}
    
#Group Policy Client

if($GPCST -eq 'Disabled'){
    Write-Host -ForegroundColor Red 'Group Policy Client Service is not correctly configured script will configure it'
    Set-Service -Name gpsvc -StartupType Automatic
    
        }else{if($GPCST -eq 'Manual'){
            Write-Host -ForegroundColor Yellow 'Group Policy Client was set to Manual, for security reasons, it will be set to automatic'
            Set-Service -Name gpsvc -StartupType Automatic}else{Write-Host -ForegroundColor Green 'Group Policy Client startup type is correct'}
        }
if($GPC.Status -ne 'Running'){
    Write-Host -ForegroundColor Red 'Group Policy Client service is not running, script will now turn it on'
    Start-Service $GPC}else{Write-Host -ForegroundColor Green 'Group Policy Client service is up and running'}
    
#Network Connections

if($NCST -eq 'Disabled'){
    Write-Host -ForegroundColor Red 'Network Connections Service is not correctly configured script will configure it'
    Set-Service -Name Netman -StartupType Manual
    
        }else{if($NCST -eq 'Automatic'){
            Write-Host -ForegroundColor Yellow 'Networks Connection was set to Automatic, for security reasons, it will be set to Manual'
            Set-Service -Name Netman -StartupType Manual}else{Write-Host -ForegroundColor Green 'Network Connections startup type is correct'}
        }
if($NC.Status -ne 'Running'){
    Write-Host -ForegroundColor Red 'Network Connections service is not running, script will now turn it on'
    Start-Service $NC}else{Write-Host -ForegroundColor Green 'Network Connections service is up and running'}
    
    
#Windows Firewall Service

if($WFST -eq 'Disabled'){
    Write-Host -ForegroundColor Red 'Windows Firewall Service is not correctly configured script will configure it'
    Set-Service -Name MpsSvc -StartupType Automatic
    
        }else{if($WFST -eq 'Manual'){
            Write-Host -ForegroundColor Yellow 'Windows Firewall was set to Manual, for security reasons, it will be set to automatic'
            Set-Service -Name MpsSvc -StartupType Automatic}else{Write-Host -ForegroundColor Green 'Windows firewall startup type is correct'}
        }
if($WF.Status -ne 'Running'){
    Write-Host -ForegroundColor Red 'Windows Firewall service is not running, script will now turn it on'
    Start-Service $WF}else{Write-Host -ForegroundColor Green 'Firewall service is up and running'}

#Windows Update Service

if($WUST -eq 'Disabled'){
    Write-Host -ForegroundColor Red 'Windows Update Service is not correctly configured, script will configure it'
    Set-Service -Name wuauserv -StartupType Automatic

        }else{if($WUST -eq 'Manual'){
            Write-Host -ForegroundColor Yellow 'Windows Update service should not be set to Manual, script will set it to automatic instead'
            Set-Service -Name wuauserv -StartupType Automatic}else{Write-Host -ForegroundColor Green 'Windows Update startup type is correct'}
        }
if($WU.Status -ne 'Running'){
    Write-Host -ForegroundColor Red 'Windows Update service is not running, script will now turn it on'
    Start-Service $WU}else{Write-Host -ForegroundColor Green 'Windows Update service is up and running'}
    
#Windows Defender Service

if($WDST -eq 'Disabled'){
    Write-Host -ForegroundColor Red 'Windows Defender Service is not correctly configured, script will configure it'
    Set-Service -Name WinDefend -StartupType Automatic

        }else{if($WDST -eq 'Manual'){
            Write-Host -ForegroundColor Yellow 'Windows Defender service should not be set to Manual, script will set it to automatic instead'
            Set-Service -Name WinDefend -StartupType Automatic}else{Write-Host -ForegroundColor Green 'Windows Defender startup type is correct'}
        }
if($WD.Status -ne 'Running'){
    Write-Host -ForegroundColor Red 'Windows Defender service is not running, script will now turn it on'
    Start-Service $WD}else{Write-Host -ForegroundColor Green 'Windows Defender service is up and running'}

#Remote Procedure Call

if($RPCST -eq 'Disabled'){
    Write-Host -ForegroundColor Red 'Remote Procedure Call Service is not correctly configured, script will configure it'
    Set-Service -Name RpcSs -StartupType Automatic

        }else{if($RPCST -eq 'Manual'){
            Write-Host -ForegroundColor Yellow 'Remote Procedure Call service should not be set to Manual, script will set it to automatic instead'
            Set-Service -Name RpcSs -StartupType Automatic}else{Write-Host -ForegroundColor Green 'Remote Procedure Call startup type is correct'}
        }
if($RPC.Status -ne 'Running'){
    Write-Host -ForegroundColor Red 'Remote Procedure Call service is not running, script will now turn it on'
    Start-Service $RPC}else{Write-Host -ForegroundColor Green 'Remote Procedure Call service is up and running'}

#Services that need to be Stopped

#Telephony

if($T.Status -eq 'Running'){
    Write-Host -ForegroundColor Red 'Telephony is running, script will now turn it off.'
    Stop-Service $T}else{Write-Host -ForegroundColor Green 'Telephony is off,thats good.'}

if($TST -eq 'Automatic'){
  Write-Host -ForegroundColor Red 'Telephony is on automatic, thats not good. Script will disable it.'
  Set-Service -Name TapiSrv -StartupType Disabled

    }else{if($TST -eq 'Manual'){
        Write-Host -ForegroundColor Yellow 'Telephony is on manual, thats not good. Script will disable it.'
        Set-Service -Name TapiSrv -StartupType Disabled}else{Write-Host -ForegroundColor Green 'Telephony StatupType is disabled, thats good.'}
    }

#Bluetooth Support Device

if($BSS.Status -eq 'Running'){
    Write-Host -ForegroundColor Red 'Bluetooth Support Service is running, script will now turn it off.'
    Stop-Service $BSS}else{Write-Host -ForegroundColor Green 'Bluetooth support service is off,thats good.'}

if($BSSST -eq 'Automatic'){
  Write-Host -ForegroundColor Red 'Bluetooth support service is on automatic, thats not good. Script will disable it.'
  Set-Service -Name TapiSrv -StartupType Disabled

    }else{if($BSSST -eq 'Manual'){
        Write-Host -ForegroundColor Yellow 'Bluetooth support service is on manual, thats not good. Script will disable it.'
        Set-Service -Name TapiSrv -StartupType Disabled}else{Write-Host -ForegroundColor Green 'Bluetooth support service Startup type is disabled, thats good.'}
    }
    
#Home Group Provider

if($HGP.Status -eq 'Running'){
    Write-Host -ForegroundColor Red 'Home Group Provider is running, script will now turn it off.'
    Stop-Service $HGP}else{Write-Host -ForegroundColor Green 'Home Group Provider service is off,thats good.'}

if($HGPST -eq 'Automatic'){
  Write-Host -ForegroundColor Red 'Home Group Provider service is on automatic, thats not good. Script will disable it.'
  Set-Service -Name HomeGroupProvider -StartupType Disabled

    }else{if($HGPST -eq 'Manual'){
        Write-Host -ForegroundColor Yellow 'Home Group Provider service is on manual, thats not good. Script will disable it.'
        Set-Service -Name HomeGroupProvider -StartupType Disabled}else{Write-Host 'Home Group Provider service is disabled, thats good.'}
    }
    
#Home Group Listener

if($HGL.Status -eq 'Running'){
    Write-Host -ForegroundColor Red 'Home Group Listener is running, script will now turn it off.'
    Stop-Service $HGL}else{Write-Host -ForegroundColor Green 'Home Group Listener service is off,thats good.'}

if($HGLST -eq 'Automatic'){
  Write-Host -ForegroundColor Red 'Home Group Listener service is on automatic, thats not good. Script will disable it.'
  Set-Service -Name HomeGroupListener -StartupType Disabled

    }else{if($HGLST -eq 'Manual'){
        Write-Host -ForegroundColor Yellow 'Home Group Listener service is on manual, thats not good. Script will disable it.'
        Set-Service -Name HomeGroupListener -StartupType Disabled}else{Write-Host -ForegroundColor Green 'Home Group Listener service is disabled, thats good.'}
    }

#Remote Access Auto Connection Manager

if($RAACM.Status -eq 'Running'){
    Write-Host -ForegroundColor Red 'Remote Access Auto Connection Manager is running, script will now turn it off.'
    Stop-Service $RAACM}else{Write-Host -ForegroundColor Green 'Remote Access Auto Connection Manager service is off,thats good.'}

if($RAACMST -eq 'Automatic'){
  Write-Host -ForegroundColor Red 'Remote Access Auto Connection Manager service is on automatic, thats not good. Script will disable it.'
  Set-Service -Name RasAuto -StartupType Disabled

    }else{if($RAACMST -eq 'Manual'){
        Write-Host -ForegroundColor Yellow 'Remote Access Auto Connection Manager service is on manual, thats not good. Script will disable it.'
        Set-Service -Name RasAuto -StartupType Disabled}else{Write-Host -ForegroundColor Green 'Remote Access Auto Connection Manager service is disabled, thats good.'}
    }

#Remote Access Connection Manager

if($RACM.Status -eq 'Running'){
    Write-Host -ForegroundColor Red 'Remote Access Connection Manager is running, script will now turn it off.'
    Stop-Service $RACM}else{Write-Host -ForegroundColor Green 'Remote Access Connection Manager service is off,thats good.'}

if($RACMST -eq 'Automatic'){
  Write-Host -ForegroundColor Red 'Remote Access Connection Manager service is on automatic, thats not good. Script will disable it.'
  Set-Service -Name RasMan -StartupType Disabled

    }else{if($RACMST -eq 'Manual'){
        Write-Host -ForegroundColor Yellow 'Remote Access Connection Manager service is on manual, thats not good. Script will disable it.'
        Set-Service -Name RasMan -StartupType Disabled}else{Write-Host -ForegroundColor Green 'Remote Access Connection Manager service is disabled, thats good.'}
    }

#Remote Desktop Configuration

if($RDC.Status -eq 'Running'){
    Write-Host -ForegroundColor Red 'Remote Desktop Configuration is running, script will now turn it off.'
    Stop-Service $RACM}else{Write-Host -ForegroundColor Green 'Remote Desktop Configuration service is off,thats good.'}

if($RDCST -eq 'Automatic'){
  Write-Host -ForegroundColor Red 'Remote Desktop Configuration service is on automatic, thats not good. Script will disable it.'
  Set-Service -Name SessionEnv -StartupType Disabled

    }else{if($RDCST -eq 'Manual'){
        Write-Host -ForegroundColor Yellow 'Remote Desktop Configuration service is on manual, thats not good. Script will disable it.'
        Set-Service -Name SessionEnv -StartupType Disabled}else{Write-Host -ForegroundColor Green 'Remote Desktop Configuration service is disabled, thats good.'}
    }

pause
