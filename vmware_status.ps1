param ([switch]$help, $hostip, $user, $pass, $ifile, $ofile)
if ($help) {
write-host ""
write-host "-----------HELP------------------------------------"
write-host ""
write-host "-hostip 	[Menation the IP Address of the host]"
write-host ""
write-host "-user		[Mention the user]"
write-host ""
write-host "-pass		[Mention the password for the host]"
write-host ""
write-host "-ifile		[Mention the full path of IP addresses file]"
write-host "		[For Example: C:\path\to\file.txt]"
write-host ""
write-host "-ofile		[Mention the CSV output file]"
write-host "		[For Example: C:\path\to\file.csv]"
write-host ""
write-host "-help		[For Help]"
write-host ""
write-host ""
write-host "***"
write-host "Example Commands"
write-host "PowerCLI C:\Users\user\Desktop> .\vmware_status.ps1 -help"
write-host "PowerCLI C:\Users\user\Desktop> .\vmware_status.ps1 -user username -pass password -hostip 192.168.xxx.xxx"
write-host "PowerCLI C:\Users\user\Desktop> .\vmware_status.ps1 -user username -pass password -ifile C:\path\to\file.txt -ofile C:\path\to\file.csv"
write-host "***"
write-host ""
write-host ""
write-host "<!> WARNING <!>"
write-host "<!> Please ensure to specify the correct password, if the password is not correct then"
write-host "<!> after running this script continously with incorrect password may cause locking of your"
write-host "<!> account on hypervisor"
write-host ""
write-host ""
}elseif(![string]::IsNullOrEmpty($hostip) -and ![string]::IsNullOrEmpty($user) -and ![string]::IsNullOrEmpty($pass)){
#write-host "$hostip"
#write-host "$user"
#write-host "$pass"
Connect-VIServer $hostip -user $user -password $pass
#Get-VMHost
#--------------------------------------------------------
#========================================================
get-vmhost -name $hostip | select-object -property Name, Version, Model, NumCpu, MemoryUsageGB, MemoryTotalGB, LicenseKey
#========================================================
#--------------------------------------------------------
}elseif(![string]::IsNullOrEmpty($ifile) -and ![string]::IsNullOrEmpty($ofile)){

$ADDLINE = "{0},{1},{2},{3},{4},{5},{6}" -f "Name", "Version", "Model", "NumCpu", "MemoryUsageGB", "MemoryTotalGB", "LicenseKey"
$ADDLINE | add-content -path $ofile

foreach($line in [System.IO.File]::ReadLines($ifile))
{
	Connect-VIServer $line -user $user -password $pass
	$HOSTNAME = (get-vmhost -name $line | select-object -property Name).Name
	$VERSION = (get-vmhost -name $line | select-object -property Version).Version
	$MODEL = (get-vmhost -name $line | select-object -property Model).Model
	$NUMCPU = (get-vmhost -name $line | select-object -property NumCpu).NumCpu
	$MEMORYUSAGE = (get-vmhost -name $line | select-object -property MemoryUsageGB).MemoryUsageGB
	$MEMORYALLOCATED = (get-vmhost -name $line | select-object -property MemoryTotalGB).MemoryTotalGB
	$LISENSEKEY = (get-vmhost -name $line | select-object -property LicenseKey).LicenseKey
	
	
	$ADDLINE = "{0},{1},{2},{3},{4},{5},{6}" -f $HOSTNAME, $VERSION, $MODEL, $NUMCPU, $MEMORYUSAGE, $MEMORYALLOCATED, $LISENSEKEY
	$ADDLINE | add-content -path $ofile
	#get-vmhost -name $line | select-object -property Name, Version, NumCpu, MemoryUsageGB, MemoryTotalGB, LicenseKey | Export-Csv report_vms.csv -NoTypeInformation
	write-host "$HOSTNAME"
	#write-host "testing"
	
}

}else{
write-host "Please pass the correct arguments"
}
write-host "END"