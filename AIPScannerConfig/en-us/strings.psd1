# This is where the strings go, that are written by
# Write-PSFMessage, Stop-PSFFunction or the PSFramework validation scriptblocks
@{
	# AIPRerpository
	'Add-AIPRerpository.Message1'        = "Creating AIP scanner repository" #
	'Add-AIPRerpository.Message2'        = "You need to have the AIP Scanner installed before you can run this function." #
	'Add-AIPRerpository.Message3'        = "Creating repository in SharePoint in the following location: {0}" #
	'Add-AIPRerpository.Message4'        = "No local SQL server instance found. Exiting" #
	'Add-AIPRerpository.Message5'        = "Creating repository in the following location: {0}" #
	'Add-AIPRerpository.Message6'        = "No local SQL server instance found. Exiting" #
	'Add-AIPRerpository.Message7'        = "Error: Path or file share not provided" #
	'Add-AIPRerpository.Message8'        = "Creating AIP scanner repository. Completed" #

	# AIPFileshare
	'New-AIPFileShare.Message1'          = "Creating default AIP scanner folder and file share" #
	'New-AIPFileShare.Message2'          = "Checking to see if folder: {0} exists" #
	'New-AIPFileShare.Message3'          = "Path failure!" #
	'New-AIPFileShare.Message4'          = "Folder: {0} already exists!" #
	'New-AIPFileShare.Message5'          = "Folder: {0} created" #
	'New-AIPFileShare.Message6'          = "Folder failure: {0} not created" #
	'New-AIPFileShare.Message7'          = "Checking to see if shared folder: {0} already exists" #
	'New-AIPFileShare.Message8'          = "Shared folder: {0} already exists" #
	'New-AIPFileShare.Message9'          = "Folder Share: {0} created" #
	'New-AIPFileShare.Message10'         = "Checking folder permissions on folder: {0}" #
	'New-AIPFileShare.Message11'         = "Permissions already exists on folder: {0}" #
	'New-AIPFileShare.Message12'         = "Shared Folder: {0} not created" #
	'New-AIPFileShare.Message13'         = "SMB Share failure!" #
	'New-AIPFileShare.Message14'         = "Attempting to add permissions to folder: {0}" #
	'New-AIPFileShare.Message15'         = "Permissions added successful to folder: {0}" #
	'New-AIPFileShare.Message16'         = "Adding permissions to folder: {0} failed!" #
	'New-AIPFileShare.Message17'         = "Set-Acl failure!" #
	'New-AIPFileShare.Message18'         = "AIP scanner file share creation completed" #

	# AIPSystemAccount
	'New-AIPSystemAccount.Message1'      = "Creating default AIP scanner system account" #
	'New-AIPSystemAccount.Message2'      = "Generating random strong password" #
	'New-AIPSystemAccount.Message3'      = "Created local system account: {0}" #
	'New-AIPSystemAccount.Message4'      = "Account creation failed!" #
	'New-AIPSystemAccount.Message5'      = "Group memberships applied" #
	'New-AIPSystemAccount.Message6'      = "Applying group memberships failed!" #
	'New-AIPSystemAccount.Message7'      = "Account: {0} found!" #
	'New-AIPSystemAccount.Message8'      = "Account: {0} not found!" #
	'New-AIPSystemAccount.Message9'      = "Obtaining SecurityIdentifier for account: {0}" #
	'New-AIPSystemAccount.Message10'     = "Exporting user right assignments to: {0}" #
	'New-AIPSystemAccount.Message11'     = "Importing new user right assignments from: {0}" #
	'New-AIPSystemAccount.Message12'     = "Current Setting: {0}" #
	'New-AIPSystemAccount.Message13'     = "Importing new user right assignments policy" #
	'New-AIPSystemAccount.Message14'     = "Modified setting ""Allow Logon Locally"" on account: {0}" #
	'New-AIPSystemAccount.Message15'     = "Permission failure on account: {0} failed!" #
	'New-AIPSystemAccount.Message16'     = "Account Sid failure!" #
	'New-AIPSystemAccount.Message17'     = "SecurityIdentifier failure!" #
	'New-AIPSystemAccount.Message18'     = "Account creation complete. Group memberships modified and access rights applied. You will need to change the default password! Logout and back in with the AIPScanner account and run Start-PrerequisiteCheck" #

	# PrerequisiteCheck
	'Start-PrerequisiteCheck.Message1'   = "Starting System prerequisite check" #
	'Start-PrerequisiteCheck.Message2'   = "Checking server version" #
	'Start-PrerequisiteCheck.Message3'   = "Operation check pass. OS = {0}" #
	'Start-PrerequisiteCheck.Message4'   = "System must be Microsoft Windows Server 2012 R2 or Microsoft Windows 2016 or higher. Exiting" #
	'Start-PrerequisiteCheck.Message5'   = "Checking for Windows Feature NFS-Client" #
	'Start-PrerequisiteCheck.Message6'   = "Windows Feature NFS-Client not installed. Installing it" #
	'Start-PrerequisiteCheck.Message7'   = "Windows Feature NFS-Client installed" #
	'Start-PrerequisiteCheck.Message8'   = "Checking server memory" #
	'Start-PrerequisiteCheck.Message9'   = "You need a minimum of 4gb of ram to run this. Exiting" #
	'Start-PrerequisiteCheck.Message10'  = "Memory found: {0} GB" #
	'Start-PrerequisiteCheck.Message11'  = "Checking network connection" #
	'Start-PrerequisiteCheck.Message12'  = "Network connection: Good" #
	'Start-PrerequisiteCheck.Message13'  = "No network connection found. Exiting" #
	'Start-PrerequisiteCheck.Message14'  = "Checking for SQL Server instances" #
	'Start-PrerequisiteCheck.Message15'  = "SQL instance found: {0}" #
	'Start-PrerequisiteCheck.Message16'  = "No remote SQL server instance found. Exiting" #
	'Start-PrerequisiteCheck.Message17'  = "SQL instance found: {0}" #
	'Start-PrerequisiteCheck.Message17A' = "No user defined SQL server instance found." #
	'Start-PrerequisiteCheck.Message18'  = "Please make sure that a version of SQL is installed locally 'https://www.microsoft.com/en-us/sql-server/sql-server-downloads'" #
	'Start-PrerequisiteCheck.Message19'  = "AIP Scanner account found!" #
	'Start-PrerequisiteCheck.Message20'  = "AIP Scanner account not found. Creating new local AIPScanner account" #
	'Start-PrerequisiteCheck.Message21'  = "Failure" #
	'Start-PrerequisiteCheck.Message22'  = "Finished. If you installed SQL Server please reboot your system to finish component setup" #

	# ElevatedPermissions
	'Assert-ElevatedPermission.Message1' = "Checking if interactive PowerShell session is running with elevated permissions" #
	'Assert-ElevatedPermission.Message2' = "Insufficient permissions to run this script. Open the PowerShell console as an administrator and run this script again. Exiting" #
	'Assert-ElevatedPermission.Message3' = "Local PowerShell session is running as administrator. Continuing configuration" #

	# IESEC
	'Assert-IEEnhancedSC.Message1'       = "Starting IE Enhanced Security Configuration check" #
	'Assert-IEEnhancedSC.Message2'       = "Checking IE Enhanced Security for Administrators: Enabled {0}. This will cause issues when trying to connect to O365 portals." #
	'Assert-IEEnhancedSC.Message3'       = "Checking IE Enhanced Security for Administrators: Disabled" #
	'Assert-IEEnhancedSC.Message4'       = "Checking IE Enhanced Security for Users: Enabled {0}. This will cause issues when trying to connect to O365 portals." #
	'Assert-IEEnhancedSC.Message5'       = "Checking IE Enhanced Security for Users: Disabled" #
	'Assert-IEEnhancedSC.Message6'       = "Failure" #
	'Assert-IEEnhancedSC.Message7'       = "Finished IE Enhanced Security Configuration check" #

	# AIPScannerInstall
	'New-AIPScannerInstall.Message1'     = "Checking for install of AzInfoProtection_UL.exe" #
	'New-AIPScannerInstall.Message2'     = "Attempting to download AzInfoProtection_UL.exe" #
	'New-AIPScannerInstall.Message3'     = "Download of AzInfoProtection_UL.exe completed." #
	'New-AIPScannerInstall.Message4'     = "Installing AzInfoProtection_UL.exe" #
	'New-AIPScannerInstall.Message5'     = "Software found installed. Locating AzInformationProtection PowerShell Module for import" #
	'New-AIPScannerInstall.Message6'     = "Importing: {0} was successful" #
	'New-AIPScannerInstall.Message7'     = "Importing: {0} failed" #
	'New-AIPScannerInstall.Message8'     = "Installing the AIP Scanner" #
	'New-AIPScannerInstall.Message9'     = "Install-AIPScanner failure!" #
	'New-AIPScannerInstall.Message10'    = "Setting up the AIP Scanner" #
	'New-AIPScannerInstall.Message11'    = "AIP Scanner installation successful" #
	'New-AIPScannerInstall.Message12'    = "AIP Scanner installation failed!" #
	'New-AIPScannerInstall.Message13'    = "Set-AIPScanner failure!" #
	'New-AIPScannerInstall.Message14'    = "Checking service state of the AIPScanner service" #
	'New-AIPScannerInstall.Message15'    = "Service state is stopped! Starting service" #
	'New-AIPScannerInstall.Message16'    = "Service state is started!" #
	'New-AIPScannerInstall.Message17'    = "Start-Service / Get-Service failure!" #
	'New-AIPScannerInstall.Message18'    = "Get-CimInstance failure!" #
	'New-AIPScannerInstall.Message19'    = "Installation of AzInfoProtection_UL.exe completed. Please make sure you run Set-AIPAuthentication to generate an Azure AD token for cloud scanner access" #

	# AzureTenantItems
	'New-AzureTenantItems.Message1'      = "Attempting to connect to Azure tenant" #
	'New-AzureTenantItems.Message2'      = "Connected to Azure tenant: {0}" #
	'New-AzureTenantItems.Message3'      = "Connect-AzureAD Failure" #
	'New-AzureTenantItems.Message4'      = "Checking for cloud service account" #
	'New-AzureTenantItems.Message5'      = "Attempting to generate password for cloud service account" #
	'New-AzureTenantItems.Message6'      = "Cloud service account already exists" #
	'New-AzureTenantItems.Message7'      = "Get-AzureADUser Failure" #
	'New-AzureTenantItems.Message8'      = "Attempting to create Azure Application in tenant: AIPOnBehalfOf" #
	'New-AzureTenantItems.Message9'      = "Azure Application AIPOnBehalfOf already exists" #
	'New-AzureTenantItems.Message10'     = "Check to see if Azure Service Principal {0} already exists" #
	'New-AzureTenantItems.Message11'     = "Service Principal not found! Attempting to create Azure Service Principal in tenant" #
	'New-AzureTenantItems.Message12'     = "Attempting to create a password credential for Azure Application"
	'New-AzureTenantItems.Message13'     = "New-AzureADApplicationPasswordCredential Failure" #
	'New-AzureTenantItems.Message14'     = "AIP Azure AD Service Principal exists in the tenant" #
	'New-AzureTenantItems.Message15'     = "AzureADServicePrincipal Failure" #
	'New-AzureTenantItems.Message16'     = "Looking for Azure AD Application: {0}" #
	'New-AzureTenantItems.Message17'     = "Azure AD Application: {0} not found! Creating Azure AD Application" #
	'New-AzureTenantItems.Message18'     = "Azure AD Application: {0} created!" #
	'New-AzureTenantItems.Message19'     = "Azure AD Application: {0} already exists in the tenant" #
	'New-AzureTenantItems.Message20'     = "New-AzureADApplication Failure" #
	'New-AzureTenantItems.Message21'     = "AIP Azure tenant item creation process completed. At this point you will need to manuall start your AIP scans. For more information see this article: 'https://docs.microsoft.com/en-us/powershell/module/azureinformationprotection/set-aipscannerconfiguration?view=azureipps' " #

	# SQL Rights
	'Add-AccountToSQLRole.Message1'      = "Attempting to add AIP Scanner account to SQL dbcreator role" #
	'Add-AccountToSQLRole.Message2'      = "Reflecting Microsoft.SqlServer.SMO." #
	'Add-AccountToSQLRole.Message3'      = "Creating new SQL Login for the AIPScanner account" #
	'Add-AccountToSQLRole.Message4'      = "AIPScanner account added to dbcreator role" #
	'Add-AccountToSQLRole.Message5'      = "Failure" #
	'Add-AccountToSQLRole.Message6'      = "SQL role modification completed." #

	# AIP Authentication
	'Get-AIPAuthToken.Message1'          = "Starting token authentication process" #
	'Get-AIPAuthToken.Message2'          = "Connected to Azure tenant: {0}" #
	'Get-AIPAuthToken.Message3'          = "Connect-AzureAD Failure" #
	'Get-AIPAuthToken.Message4'          = "Generating authentication token with user supplied information" #
	'Get-AIPAuthToken.Message5'          = "No user supplied or configuration information found. No authentication token generated" #
	'Get-AIPAuthToken.Message6'          = "Generating authentication token with configuration supplied information" #
	'Get-AIPAuthToken.Message7'          = "Generating local authentication token" #
	'Get-AIPAuthToken.Message8'          = "Failure" #
	'Get-AIPAuthToken.Message9'          = 'Finishing token authentication process' #
}