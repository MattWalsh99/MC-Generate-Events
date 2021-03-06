#  Generate-Events

#  No Proxy Dlls are required

#  Define Module Path and Server Name
$amcServer = 'mw-amc-12.mw.support.local'

#  Define WebService variables
$groupsWebService = New-WebServiceProxy -Uri http://$amcServer/ManagementServer/DataAccess/Groups.asmx -UseDefaultCredential
$machinesWebService = New-WebServiceProxy -Uri http://$amcServer/ManagementServer/DataAccess/Machines.asmx -UseDefaultCredential
$eventWebService = New-WebServiceProxy -Uri http://$amcServer/ManagementServer/DataAccess/Events.asmx -UseDefaultCredential

$groupKey = $groupsWebService.GetDeploymentGroupsLight().Groups | where-object {$_.Name -eq '(Default)'}| select GroupKey

$machines = $machinesWebService.GetMachines($false)
$machineKey = $machines.Machines | where-object {$_.NetBiosName -eq 'MW-W7-EVT'} | select MachineKey

$dateTime = Get-Date

$i=0
do 
{
    $eventWebService.CreateEvent(9653, $machineKey.MachineKey, $groupKey.GroupKey, 'TestEvent', $dateTime)
    $i++
} 
until ($i -eq 1)

