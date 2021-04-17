﻿# This is where the strings go, that are written by
# Write-PSFMessage, Stop-PSFFunction or the PSFramework validation scriptblocks
@{
	# AIPRerpository
	'Add-AIPRerpository.Message1'       = "Creating AIP scanner repository" # 
	'Add-AIPRerpository.Message2'       = "You need to have the AIP Scanner installed before you can run this function." # 
	'Add-AIPRerpository.Message3'       = "Creating repository in SharePoint in the following location: {0}" # 
	'Add-AIPRerpository.Message4'       = "No local SQL server instance found. Exiting" # 
	'Add-AIPRerpository.Message5'       = "Creating repository in the following location: {0}" # 
	'Add-AIPRerpository.Message6'       = "No local SQL server instance found. Exiting" # 
	'Add-AIPRerpository.Message7'       = "Error: Path or file share not provided" # 
	'Add-AIPRerpository.Message8'       = "Creating AIP scanner repository. Completed" # 

	# AIPFileshare
	'New-AIPFileShare.Message1'         = "Creating default AIP scanner folder and file share" # 
	'New-AIPFileShare.Message2'         = "Checking to see if folder {0} exists" # 
	'New-AIPFileShare.Message3'         = "Folder {0} created" # 
	'New-AIPFileShare.Message4'         = "Checking if {0} is already shared" # 
	'New-AIPFileShare.Message5'         = "Applying folder permissions to {0}" # 
	'New-AIPFileShare.Message6'         = "Permissions already exists on {0}" # 
	'New-AIPFileShare.Message7'         = "{0} already has the full permissions to account {1}" # 
	'New-AIPFileShare.Message8'         = "Permissions added to folder {0}" # 
	'New-AIPFileShare.Message9'         = "Share {0} not created" # 
	'New-AIPFileShare.Message10'        = "Shared folder: {0} already exists" # 
	'New-AIPFileShare.Message11'        = "Folder {0} not created" # 
	'New-AIPFileShare.Message12'        = "Folder: {0} already exists" # 
	'New-AIPFileShare.Message13'        = "Failure" # 
	'New-AIPFileShare.Message14'        = "AIP scanner file share creation completed" # 

	# AIPSystemAccount
	'New-AIPSystemAccount.Message1'     = "Creating default AIP scanner system account" # 
	'New-AIPSystemAccount.Message2'     = "Generating random strong password" # 
	'New-AIPSystemAccount.Message3'     = "Created local system account: {0}" # 
	'New-AIPSystemAccount.Message4'     = "Account creation failed!" # 
	'New-AIPSystemAccount.Message5'     = "Group memberships applied" # 
	'New-AIPSystemAccount.Message6'     = "Applying group memberships failed!" # 
	'New-AIPSystemAccount.Message7'     = "Account: {0} not found!" # 
	'New-AIPSystemAccount.Message8'     = "Exporting user right assignments" # 
	'New-AIPSystemAccount.Message9'     = "Modify Setting ""Allow Logon Locally"" on {0}" # 
	'New-AIPSystemAccount.Message10'     = "Current Setting: {0}" # 
	'New-AIPSystemAccount.Message11'    = "Importing new user right assigments" # 
	'New-AIPSystemAccount.Message12'    = "Failure" # 
	'New-AIPSystemAccount.Message13'    = "Unable to setting ""Allow Logon Locally"" on {0}" # 
	'New-AIPSystemAccount.Message14'    = "Failure" # 
	'New-AIPSystemAccount.Message15'    = "Account creation complete. Group memberships modified and access rights applied. You will need to change the default password! Logout and back in with the AIPScanner account and run Start-PrerequisiteCheck" # 

	# PrerequisiteCheck
	'Start-PrerequisiteCheck.Message1'  = "Starting System prerequisite check" # 
	'Start-PrerequisiteCheck.Message2'  = "Checking server version" # 
	'Start-PrerequisiteCheck.Message3'  = "Operation check pass. OS = {0}" # 
	'Start-PrerequisiteCheck.Message4'  = "System must be Microsoft Windows Server 2012 R2 or Microsoft Windows 2016 or higher. Exiting" # 
	'Start-PrerequisiteCheck.Message5'  = "Checking for Windows Feature NFS-Client" # 
	'Start-PrerequisiteCheck.Message6'  = "Windows Feature NFS-Client not installed. Installing it" # 
	'Start-PrerequisiteCheck.Message7'  = "Windows Feature NFS-Client installed" # 
	'Start-PrerequisiteCheck.Message8'  = "Checking server memory" # 
	'Start-PrerequisiteCheck.Message9'  = "You need a minimum of 4gb of ram to run this. Exiting" # 
	'Start-PrerequisiteCheck.Message10' = "Memmory found: {0} GB" # 
	'Start-PrerequisiteCheck.Message11' = "Checking network connection" # 
	'Start-PrerequisiteCheck.Message12' = "Network connection: Good" # 
	'Start-PrerequisiteCheck.Message13' = "No network connection found. Exiting" # 
	'Start-PrerequisiteCheck.Message14' = "Checking for SQL Server instances" # 
	'Start-PrerequisiteCheck.Message15' = "SQL instance found: {0}" # 
	'Start-PrerequisiteCheck.Message16' = "No remote SQL server instance found. Exiting" # 
	'Start-PrerequisiteCheck.Message17' = "SQL instance found: {0}" # 
	'Start-PrerequisiteCheck.Message18' = "No local SQL server instance found. Please make sure that a version of SQL is installed locally 'https://www.microsoft.com/en-us/sql-server/sql-server-downloads'" # 
	'Start-PrerequisiteCheck.Message19' = "AIP Scanner account found!" # 
	'Start-PrerequisiteCheck.Message20' = "AIP Scanner account not found. You must run New-AIPSystemAccount before you can start the AIP scanner component install" # 
	'Start-PrerequisiteCheck.Message21' = "Failure" # 
	'Start-PrerequisiteCheck.Message22' = "Finished. If you installed SQL Server please reboot your system to finish component setup" # 

	# ElevatedPermissions
	'Assert-ElevatedPermissions.Message1' = "Checking if interactive PowerShell session is running with elevated permissions" # 
	'Assert-ElevatedPermissions.Message2' = "Insufficient permissions to run this script. Open the PowerShell console as an administrator and run this script again. Exiting" # 
	'Assert-ElevatedPermissions.Message3' = "Local PowerShell session is running as administrator. Continuning configuration" # 

	# AIPScannerInstall
	'New-AIPScannerInstall.Message1' = "Checking for install of AzInfoProtection_UL.exe" # 
	'New-AIPScannerInstall.Message2' = "Attemping to download AzInfoProtection_UL.exe" # 
	'New-AIPScannerInstall.Message3' = "Download of AzInfoProtection_UL.exe completed." # 
	'New-AIPScannerInstall.Message4' = "Installing AzInfoProtection_UL.exe" # 
	'New-AIPScannerInstall.Message5' = "Software found installed. Locating AzInformationProtection PowerShell Module for import" # 
	'New-AIPScannerInstall.Message6' = "Importing {0} was successful" # 
	'New-AIPScannerInstall.Message7' = "Importing {0} failed" # 
	'New-AIPScannerInstall.Message8' = "Installing the AIP Scanner" # 
	'New-AIPScannerInstall.Message9' = "Setting up the AIP Scanner" # 
	'New-AIPScannerInstall.Message10' = "Failure" # 
	'New-AIPScannerInstall.Message11' = "Download of AzInfoProtection_UL.exe completed." # 

	# AzureTenantItems
	'New-AzureTenantItems.Message1' = "Attemping to connect to Azure tenant" # 
	'New-AzureTenantItems.Message2' = "Unable to connect to Azure tenant" # 
	'New-AzureTenantItems.Message3' = "Failure" # 
	'New-AzureTenantItems.Message4' = "Checking for cloud service account" # 
	'New-AzureTenantItems.Message5' = "Attemping to generate password for cloud service account" # 
	'New-AzureTenantItems.Message6' = "Cloud service account already exists" # 
	'New-AzureTenantItems.Message7' = "Attemping to create Azure Appllication in tenant: AIPOnBehalfOf" # 
	'New-AzureTenantItems.Message8' = "Azure Appllication AIPOnBehalfOf already exists" # 
	'New-AzureTenantItems.Message9' = "Attemping to create Azure Service Principal in tenant" # 
	'New-AzureTenantItems.Message10' = "Azure Service Principal already exists in the tenant" # 
	'New-AzureTenantItems.Message11' = "Attemping to create Azure Appllication in tenant: AIPClient" # 
	'New-AzureTenantItems.Message12' = "AIP Azure AD applications already exists in the tenant" # 
	'New-AzureTenantItems.Message13' = "Failure" # 
	'New-AzureTenantItems.Message14' = "AIP Azure tenant items completed. {0}" # 
}