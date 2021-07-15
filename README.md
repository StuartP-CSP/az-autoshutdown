# Az-AutoShutdown.ps1 

## Overview
A simple script to create an Auto-Shutdown schedule for each VM in a specified Resource Group,  of a specified subscription. Default subscription set in script.
No warranty; use at your own risk.  

## Requirement
Required the Azure 'az' PowerShell module be installed.

Install with:
```
Install-Module -Name Az -AllowClobber -Scope CurrentUser
```

## Usage
Either specify the parameters on the command line or you will be prompted to enter them.

```
Az-AutoShutdown -ResourceGroup xxxxx -ShutDownTime 1900 -TimeZone ""GMT Standard Time" <-Subscription My-Azure-Subscription>
```

Valid timezones:

'''
AUS Central Standard Time,  AUS Eastern Standard Time,  Afghanistan Standard Time,  Alaskan Standard Time,  Aleutian Standard Time,  Altai Standard Time, 
Arab Standard Time,  Arabian Standard Time, Arabic Standard Time, Argentina Standard Time, Astrakhan Standard Time, Atlantic Standard Time,
Aus Central W. Standard Time, Azerbaijan Standard Time, Azores Standard Time, Bahia Standard Time, Bangladesh Standard Time, Belarus Standard Time,
Bougainville Standard Time, Canada Central Standard Time, Cape Verde Standard Time, Caucasus Standard Time, Cen. Australia Standard Time,
Central America Standard Time, Central Asia Standard Time, Central Brazilian Standard Time, Central Europe Standard Time, Central European Standard Time,
Central Pacific Standard Time, Central Standard Time (Mexico), Central Standard Time, Chatham Islands Standard Time, China Standard Time, Cuba Standard Time,
Dateline Standard Time, E. Africa Standard Time, E. Australia Standard Time, E. Europe Standard Time, E. South America Standard Time, Easter Island Standard Time,
Eastern Standard Time (Mexico), Eastern Standard Time, Egypt Standard Time, Ekaterinburg Standard Time, FLE Standard Time, Fiji Standard Time, GMT Standard Time,
GTB Standard Time, Georgian Standard Time, Greenland Standard Time, Greenwich Standard Time, Haiti Standard Time, Hawaiian Standard Time, India Standard Time,
Iran Standard Time, Israel Standard Time, Jordan Standard Time, Kaliningrad Standard Time, Korea Standard Time, Libya Standard Time, Line Islands Standard Time,
Lord Howe Standard Time, Magadan Standard Time, Magallanes Standard Time, Marquesas Standard Time, Mauritius Standard Time, Middle East Standard Time,
Montevideo Standard Time, Morocco Standard Time, Mountain Standard Time (Mexico), Mountain Standard Time, Myanmar Standard Time, N. Central Asia Standard Time,
Namibia Standard Time, Nepal Standard Time, New Zealand Standard Time, Newfoundland Standard Time, Norfolk Standard Time, North Asia East Standard Time,
North Asia Standard Time, North Korea Standard Time, Omsk Standard Time, Pacific SA Standard Time, Pacific Standard Time (Mexico), Pacific Standard Time,
Pakistan Standard Time, Paraguay Standard Time, Qyzylorda Standard Time, Romance Standard Time, Russia Time Zone 10, Russia Time Zone 11,
Russia Time Zone 3, Russian Standard Time, SA Eastern Standard Time, SA Pacific Standard Time, SA Western Standard Time, SE Asia Standard Time,
Saint Pierre Standard Time, Sakhalin Standard Time, Samoa Standard Time, Sao Tome Standard Time, Saratov Standard Time, Singapore Standard Time,
South Africa Standard Time, Sri Lanka Standard Time, Sudan Standard Time, Syria Standard Time, Taipei Standard Time, Tasmania Standard Time, Tocantins Standard Time,
Tokyo Standard Time, Tomsk Standard Time, Tonga Standard Time, Transbaikal Standard Time, Turkey Standard Time, Turks And Caicos Standard Time, US Eastern Standard Time,
US Mountain Standard Time, UTC+12, UTC+13, UTC, UTC-02, UTC-08, UTC-09, UTC-11, Ulaanbaatar Standard Time, Venezuela Standard Time, Vladivostok Standard Time,
Volgograd Standard Time, W. Australia Standard Time, W. Central Africa Standard Time, W. Europe Standard Time, W. Mongolia Standard Time, West Asia Standard Time,
West Bank Standard Time, West Pacific Standard Time, Yakutsk Standard Time, Yukon Standard Time, Kamchatka Standard Time, Mid-Atlantic Standard Time Correlation
'''
## Author
Stuart Parkington and Darren Harding

## Licence
None.
