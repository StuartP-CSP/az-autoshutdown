param (
    [Parameter(Mandatory = $false)]
    [string] $ResourceGroup = (Read-Host -Prompt 'Resource Group name'),
    [Parameter(Mandatory = $false)]
    [string] $ShutDownTime = (Read-Host -Prompt "The Autoshutdown time, 24 hour clock, no :'s (i.e. 7 PM = 1900)"),
    [Parameter(Mandatory = $false)]
    [string] $TimeZone = (Read-Host -Prompt "Your time zone"), # "GMT Standard Time" 
    [Parameter(Mandatory = $false)]
    [string] $Subscription="Citrix-CSP-SEs"
)


##############################
#     Allowed TZ values
##############################
#         AUS Central Standard Time,AUS Eastern Standard Time,Afghanistan
#         Standard Time,Alaskan Standard Time,Aleutian Standard Time,Altai Standard Time,Arab Standard Time,Arabian Standard Time,Arabic Standard Time,Argentina
#         Standard Time,Astrakhan Standard Time,Atlantic Standard Time,Aus Central W. Standard Time,Azerbaijan Standard Time,Azores Standard Time,Bahia Standard
#         Time,Bangladesh Standard Time,Belarus Standard Time,Bougainville Standard Time,Canada Central Standard Time,Cape Verde Standard Time,Caucasus Standard
#         Time,Cen. Australia Standard Time,Central America Standard Time,Central Asia Standard Time,Central Brazilian Standard Time,Central Europe Standard
#         Time,Central European Standard Time,Central Pacific Standard Time,Central Standard Time (Mexico),Central Standard Time,Chatham Islands Standard
#         Time,China Standard Time,Cuba Standard Time,Dateline Standard Time,E. Africa Standard Time,E. Australia Standard Time,E. Europe Standard Time,E. South
#         America Standard Time,Easter Island Standard Time,Eastern Standard Time (Mexico),Eastern Standard Time,Egypt Standard Time,Ekaterinburg Standard
#         Time,FLE Standard Time,Fiji Standard Time,GMT Standard Time,GTB Standard Time,Georgian Standard Time,Greenland Standard Time,Greenwich Standard
#         Time,Haiti Standard Time,Hawaiian Standard Time,India Standard Time,Iran Standard Time,Israel Standard Time,Jordan Standard Time,Kaliningrad Standard
#         Time,Korea Standard Time,Libya Standard Time,Line Islands Standard Time,Lord Howe Standard Time,Magadan Standard Time,Magallanes Standard Time,Marquesas
#         Standard Time,Mauritius Standard Time,Middle East Standard Time,Montevideo Standard Time,Morocco Standard Time,Mountain Standard Time (Mexico),Mountain
#         Standard Time,Myanmar Standard Time,N. Central Asia Standard Time,Namibia Standard Time,Nepal Standard Time,New Zealand Standard Time,Newfoundland
#         Standard Time,Norfolk Standard Time,North Asia East Standard Time,North Asia Standard Time,North Korea Standard Time,Omsk Standard Time,Pacific SA
#         Standard Time,Pacific Standard Time (Mexico),Pacific Standard Time,Pakistan Standard Time,Paraguay Standard Time,Qyzylorda Standard Time,Romance
#         Standard Time,Russia Time Zone 10,Russia Time Zone 11,Russia Time Zone 3,Russian Standard Time,SA Eastern Standard Time,SA Pacific Standard Time,SA
#         Western Standard Time,SE Asia Standard Time,Saint Pierre Standard Time,Sakhalin Standard Time,Samoa Standard Time,Sao Tome Standard Time,Saratov
#         Standard Time,Singapore Standard Time,South Africa Standard Time,Sri Lanka Standard Time,Sudan Standard Time,Syria Standard Time,Taipei Standard
#         Time,Tasmania Standard Time,Tocantins Standard Time,Tokyo Standard Time,Tomsk Standard Time,Tonga Standard Time,Transbaikal Standard Time,Turkey
#         Standard Time,Turks And Caicos Standard Time,US Eastern Standard Time,US Mountain Standard
#         Time,UTC+12,UTC+13,UTC,UTC-02,UTC-08,UTC-09,UTC-11,Ulaanbaatar Standard Time,Venezuela Standard Time,Vladivostok Standard Time,Volgograd Standard
#         Time,W. Australia Standard Time,W. Central Africa Standard Time,W. Europe Standard Time,W. Mongolia Standard Time,West Asia Standard Time,West Bank
#         Standard Time,West Pacific Standard Time,Yakutsk Standard Time,Yukon Standard Time,Kamchatka Standard Time,Mid-Atlantic Standard Time Correlation

# You shouldn't need to change the variables below.
$Subscription="Citrix-CSP-SEs"

Write-Host
Write-Host -ForegroundColor Green "Set an Auto-Shutdown schedule for VMs in Resource Group: " -NoNewline
Write-Host -ForegroundColor Yellow $ResourceGroup
Write-Host
Write-Host -ForegroundColor Green "Parameters to set:"
Write-Host -ForegroundColor White "   Auto-Shutdown at " -NoNewline
Write-host -ForegroundColor Yellow $ShutDownTime $TimeZone
# Write-Host -ForegroundColor Yellow $tz
Write-Host -ForegroundColor White "   for all VMS in Resource Group " -NoNewline
Write-host -ForegroundColor Yellow $ResourceGroup
Write-Host -ForegroundColor White "   in the " -NoNewline
Write-host -ForegroundColor Yellow $Subscription -NoNewline
Write-Host -ForegroundColor White " subscription."
Write-Host
Write-Host -ForegroundColor White  "If this is correct,"
pause

if ( Get-Module -ListAvailable -Name Az ) {
    Write-Host "Az Module found, starting..."
    Write-Host "Checking Azure Context..."
    if ( (get-azcontext).Subscription.Name -ne $Subscription ) {
        Write-Host -ForegroundColor Green "Log on to Azure"
        Connect-AzAccount
        Set-AzContext -Subscription $Subscription | Out-Null
    } else {
         Get-AzContext | Out-Null
    }
    $rg = Get-AzResourceGroup -ResourceGroupName $ResourceGroup
    $vms = Get-AzVM -ResourceGroupName $rg.ResourceGroupName
    # $resources = Get-AzResource | Where-Object {($_.ResourceType -eq "Microsoft.DevTestLab/schedules") -and ($_.Location -eq $rg.Location) }
    foreach ( $vm in $vms ) {
        Write-Host -ForegroundColor White "Setting Auto-Shutdown for " -NoNewline
        Write-Host -ForegroundColor Yellow $Vm.name "..." -NoNewline
        Enable-AzVMAutoShutdown -ResourceGroupName $rg.ResourceGroupName -VirtualMachineName $vm.name -ShutdownTime $shutdowntime -TimeZone $TimeZone | Out-Null
    }
} else {
    Write-Host "Az Module NOT found. Exiting."
    Write-Host "To install Azure PoSH run the following command"
    Write-Host -ForegroundColor Yellow "Install-Module -Name Az -AllowClobber -Scope CurrentUser"
}



<#
    .SYNOPSIS
        Enable-AzVMAutoShutdown

    .DESCRIPTION
        Enable Azure RM Virtual Machine Auto-Shutdown.

    .PARAMETER  ResourceGroupName  
        Resource group name. 

    .PARAMETER  VirtualMachineName
        Virtual Machine name.

    .PARAMETER  ShutdownTime 
        Set Auto-Shutdown time 24 format (ex : 2000 = 20:00).

    .PARAMETER  TimeZone
        Set Time Zone.

    .EXAMPLE
        PS C:\> Enable-AzureRmVMAutoShutdown -ResourceGroupName 'MyRGName' -VirtualMachineName 'MyVMName'

    .EXAMPLE
        PS C:\> Enable-AzureRmVMAutoShutdown -ResourceGroupName 'MyRGName' -VirtualMachineName 'MyVMName' -ShutdownTime 2000 -TimeZone 'Romance Standard Time'

    .INPUTS
        System.String,System.Int32

    .OUTPUTS
        Microsoft.DevTestLab/Schedules

    .NOTES
        Author: MsCloudOps (Twitter/GitHub @MSCloudOps)
        Date: 09/03/2017
        https://mscloudops.wordpress.com/2017/03/12/enable-azure-arm-virtual-machine-auto-shutdown-with-powershell/
#>
Function Enable-AzVMAutoShutdown
{
    [CmdletBinding()]
    Param 
    (
        [Parameter(Mandatory = $true)] 
        [string] $ResourceGroupName,
        [Parameter(Mandatory = $true)]
        [string] $VirtualMachineName,
        [int] $ShutdownTime = 1900,
        [string] $TimeZone = 'Romance Standard Time'
    )
    
    Try    
    {
        $Location = (Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VirtualMachineName).Location
        $SubscriptionId = (Get-AzContext).Subscription.SubscriptionId
        $VMResourceId = (Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VirtualMachineName).Id
        $ScheduledShutdownResourceId = "/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroupName/providers/microsoft.devtestlab/schedules/shutdown-computevm-$VirtualMachineName"

        $Properties = @{}
        $Properties.Add('status', 'Enabled')
        $Properties.Add('taskType', 'ComputeVmShutdownTask')
        $Properties.Add('dailyRecurrence', @{'time'= $ShutdownTime})
        $Properties.Add('timeZoneId', $TimeZone)
        $Properties.Add('notificationSettings', @{status='Disabled'; timeInMinutes=15})
        $Properties.Add('targetResourceId', $VMResourceId)

        New-AzResource -Location $Location -ResourceId $ScheduledShutdownResourceId -Properties $Properties -Force
    }
    Catch {Write-Error $_}
}