# Changelog

## 1.0.0 (2021-04-08)

- New: Initial code release

## 1.0.12 (2021-04-08)

- New: Removed Check-Dependencies.ps1 - No longer needed
- New: Created New-AIPFileShare - Creates AIP Scanner local file share
- New: Added return value output for Create method of the Win32_Share class
- New: Added SupportsShouldProcess support
- New: Added support for EnabledExceptions
- Fix: Fixed end statement in Start-PrerequisiteCheck
- Fix: Changed check while looking for server version
- Chg: Modification for checking for server versions
- Chg: Stop-PSFunction callout for each function
- Chg: New additons to the readme.me file
- Chg: Corrected all paramter casings with capitalization
- Chg: Added information about logging subsystem for PSFramework

## 1.0.19 (2021-04-10)

- New: Error handling in New-AIPScannerInstall
- Upd: Updated about_AIPScannerConfig.help.txt
- Upd: Change manifest file version
- Upd: Change return logic to cause failures to exit faster
- Upd: Added Tags, LicenseUri and ProjectUri
- Fix: Fixed Write-PSFMessage cut and paste error (all files)
- Fix: Removed continue statements

## 1.0.34 (2021-04-12)

- New: Added code to create new AIP accounts. File New-AIPSystemAccounts.ps1
- New: Added code to apply access rights to the new AIP scanner accounts.
- New: Moved paramters to configuration system for central changing
- New: Adding support for TLS 1.2
- New: Added verifcation for AIP scanner so we dont download every time
- New: Added config value for root folder for AIPScannerShare
- New: Added code for putting together user account and cluster name for Set-AIPScanner
- Chg: Force all PowerShell modules to be installed to the CurrentUserScopr
- Chg: Modified documentation on all methods
- Chg: Swapped New-AzureTenantItems, New-AIPScannerInstall and New-AIPFileShare to change installation order
- Chg: Wired up EnabledExpcetion for all functions
- Chg: Moved New-AIPSystemAccount from an internal account to public
- Chg: Updated the readme.me with new instuctions
- Chg: Updated manifest version
- Chg: Change begin and end logging so user can see what is going on at a minimum for start and finish

## 1.0.41 (2021-04-13)

- New: Added code for adding folder permissions for the AIP Scanner account on the Folder and AIP Scanner Share
- New: Add check for Windows Feature "NFS-Client" and install if not found
- New: Added information on how to change the configuration file in the help
- Chg: Added checks to test for azure objects before failing out or creating them
- Chg: Manifest version update
- Chg: Changed logic so we run everything instead of failing. We will only now fail and exit on a hard exception as some are expected
- Chg: Upated the readme.me

## 1.0.49 (2021-04-14)

- New: Changed output when not finding SQLInstances
- New: Updated all functions to now pull from the strings.psd1
- New: Updated strings.psd1 file
- Chg: Changed PowerShell module install location from CurrentUsers to AllUsers Scope
- Chg: Added failout for not connecting to the azure teannt so we don't continue as we need the cloud items to finish the component configuration
- Chg: Fixed Stop-PSFMessage in New-AzureTenantItems.ps1 so we could extract strings for strings.psd1
- Chg: Fixed Stop-PSFMessage in New-AIPScannerAccount.ps1 so we could extract strings for strings.psd1
- Fix: Versions in changelog.md (they were off by 1)

## 1.0.65 (2021-04-15)

- New: Added throw statements for module import
- New: Added new string value - 'New-AIPSystemAccount.Message3' = "Created local system account: {0}"
- New: Added -InformationLevel Quiet to Test-NetConnection to surpress progress bar
- Chg: Changed module install/import from Verbose to Warning to always throw
- Chg: Added GB" to 'Start-PrerequisiteCheck.Message10'
- Chg: Changed 'Start-PrerequisiteCheck.Message12' - "Network connection good" to "Network connection: Good"
- Chg: Changed 'Start-PrerequisiteCheck.Message14' - "Checking SQL Server instances" to "Checking for SQL Server instances"
- Chg: Changed 'Start-PrerequisiteCheck.Message22' - "Finished. Your system needs to be rebooted to finish component setup" to "Finished. If you installed SQL Server please reboot your system to finish component setup"
- Chg: Add-LocalGroupMember does not return anything. Added check for calling Get-LocalGroupMember and based success or failure from this return object
- Chg: Added error handling in New-AIPSystemAccount for -ErrorAction SilentlyContinue
- Chg: Added varibale check for User and Member
- Chg: Moved New-AIPScannerInstall to public functions so user can rerun it in the event of a failure
- Chg: Moved New-AzureTenantItems to public functions so user can rerun it in the event of a failure
- Chg: Removed -Credentials $Credentials from Set-AIPScanner as it is not a valid paramter
- Chg: Updated manifest version
- Chg: Upated the readme.me

## 1.0.73 (2021-04-16)

- New: Added parameter for cluster in New-AIPScannerInstall to give an option
- New: Added new TAG "AIP Scanner"
- New: Created \Scripts\moduleimport,ps1 and moved dependencies module load out of the manifest file
- Chg: Added enabled exception to display exception error upon module import failure
- Chg: Changed Get-WindowsFeature redirection from pipeline to redirection - 400ms reduction in time
- Chg: Updated manifest version
- Chg: Update on New-PSFLicense -Manufacturer changed to 'Dave Goldman'
- Chg: Upated the readme.me

## 1.0.77 (2021-04-17)

- Fix: Made change to add += TLS1.2 to the array and not overwrite it with
- New: Added code to display warning if TLS12 isn't added to the [Net.ServicePointManager]::SecurityProtocol object
- New: Added new dubgging information to the readm.me on dumping out a PSFSupportPackage in the event of module issues
- Chg: Updated manifest version

## 1.1.01 (2021-04-18)

- Upd: Updated readme.me
- Chg: Created new AzureDevOp's Pipeline package and renamed Test to AIPScannerConfig so pipeline will work correctly
- Chg: Updated manifest version
- Chg: Added [OutputType([String])] to all files per PSScriptAnalyzer
- Chg: Add-AIPRepository.ps1 - Added $EnabledException and Added parameters to documentation
- Chg: New-AIPFileShare.ps1 - Added parameters to documentation
- Chg: New-AIPScannerInstall - Replaced Get-WMIObject with Get-CimInstance
- Chg: Start-PrerequisitesCheck.ps1 - Replaced all instances of Get-WMIObject with Get-CimInstance
- Chg: Added .PARAMETER WhatIf and Confirm to all files that ShouldSupportProcessing
- Chg: Removed Write-Warning from Manifest file
- Chg: [internal\scripts\moduleimport.ps1] Should have UTF8 encoding with Byte Order Mark
- Chg: [internal\scripts\moduleimport.ps1] Should have no trailing space
- Chg: [functions\Start-PrerequisiteCheck.ps1] Should have no trailing space - Expected $null or empty, but got @(42, 112, 117, 118).
- Chg: [internal\functions\Assert-ElevatedPermissions.ps1] Should have no trailing space - Expected $null or empty, but got @(42, 112, 117, 118).
- Chg: [functions\New-AzureTenantItems.ps1] Should have no trailing space - Expected $null or empty, but got @(50, 51, 52, 53, 54, 55, 64, 73, 75, 76, ...).
- Chg: [functions\New-AIPSystemAccount.ps1] Should have no trailing space - Expected $null or empty, but got @(55, 58, 106, 107, 114, 127).
- Chg: [functions\New-AIPFileShare.ps1] Should have no trailing space - Expected $null or empty, but got @(24, 56, 88, 93, 98, 102, 103, 109, 114).
- Chg: [functions\Add-AIPRerpository.ps1] Should have no trailing space - Expected $null or empty, but got 56.
- Chg: [en-us\about_AIPScannerConfig.help.txt] Should have no trailing space - Expected 0, but got 2.
- Chg: Function 'New-AIPScannerInstall' has verb that could change system state. Therefore, the function has to support 'ShouldProcess'.
- Chg: File 'New-AIPSystemAccount.ps1' uses ConvertTo-SecureString with plaintext. This will expose secure information. Encrypted standard strings should be used instead.
- Chg: Removed Password and put it inline
- Chg: New-AzureTenantItems renamed changed Output type from string to System.Boolean
- Chg: Tested removing TLS12 check for windows system - can be set by user when setting up powershell
