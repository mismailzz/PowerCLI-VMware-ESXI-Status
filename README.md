# PowerCLI-VMware-ESXI-Status
This script will allow you to login into the multiple VMware ESXI Hypervisors and extract out the information of License, installed RAM and Server Version etc. But you can change the script as you want to extract out other information. The extracted information will be saved in the .CSV file which make its easy to view and share the report. For this you will have to provide the file containing the list of IP addresses (one IP in each line). But you have to make sure that you are attempting the correct credentials because it may lock the account on the VMware ESXI Hypervisor which may cause a serious trouble. 

Example Commands

PowerCLI C:\Users\user\Desktop> .\vmware_status.ps1 -help

PowerCLI C:\Users\user\Desktop> .\vmware_status.ps1 -user username -pass password -hostip 192.168.xxx.xxx

PowerCLI C:\Users\user\Desktop> .\vmware_status.ps1 -user username -pass password -ifile C:\path\to\file.txt -ofile C:\path\to\file.csv
