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

## 1.1.46 (2021-04-18)

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
- Chg: Replaced Get-WmiObject with Get-SMBShare in New-AIPFileShare
- Fix: [en-us\about_AIPScannerConfig.help.txt] Should have no trailing space - Line 84
- Fix: [functions\New-AIPFileShare.ps1] Should have no trailing space - Line 33
- Fix: [functions\New-AIPFileShare.ps1] Should not use Get-WmiObject - Line 78
- Fix: New-AIPFileShare changed  Write-PSFMessage -Level Host -Message 'New-AIPFileShare.Message14' to Write-PSFMessage -Level Host -String 'New-AIPFileShare.Message14'
- Fix: Fixed typo in configuration.ps1 - Renamed manidest to manifest
- Fix: [functions\New-AIPSystemAccount.ps1] Should have no trailing space - Line 15 and 64
- Fix: [functions\New-AzureTenantItems.ps1] Should have no trailing space - Line 17
- Fix: [functions\Start-PrerequisiteCheck.ps1] Should have no trailing space - Line 122 and 123
- Fix: [internal\functions\Assert-ElevatedPermissions.ps1] Should have no trailing space - Line 26
- Fix: [internal\scripts\moduleimport.ps1] Should not use Write-Verbose
- Fix: [internal\scripts\moduleimport.ps1] Should not use Write-Verbose - Removed
- Fix: Removed .Example from Assert-ElevatedPermissions
- Fix: New-AIPSystemAccount changed .Example New-AIPSystemAccounts to .Example New-AIPSystemAccount
- Fix: Added Confirm and WhatIf parameters to documentation in New-AIPSystemAccount
- Fix: Removed SharedFolderPath from New-AIPFileShare
- Fix: Added PSUseShouldProcessForStateChangingFunctions to Add-AIPRepository
- Fix: Renamed New-AzureTenantItems.ps1 to New-AzureTenantAccountAndApplication.ps1
- Fix: Renamed New-AzureTenantItems to New-AzureTenantAccountAndApplication in manifest file
- Fix: Renamed Assert-ElevatedPermissions.ps1 to Assert-ElevatedPermission.ps1
- Fix: Renamed Assert-ElevatedPermissions to Assert-ElevatedPermission in manifest file
- Fix: Renamed Assert-ElevatedPermissions to Assert-ElevatedPermission in strings.ps1 - all occurrences
- Fix: Renamed Tag 'AIP Scanner' to 'AIPScanner' as no spaces are allowed
- Fix: Add-AIPRepository - The parameter 'CreateOnFileShare' has been declared but not used - removed
- Fix: Add-AIPRepository - The parameter 'EnableException' has been declared but not used - removed
- Fix: Add-AIPRepository - Function 'New-AIPRepository' has verb that could change system state. Therefore, the function has to support 'ShouldProcess'.
- Fix: New-AIPFileShare - removed ComputerName parameter and documentation as no longer needed
- Fix: New-AIPSystemAccount - changed [OutputType([String])] to [OutputType([System.Boolean])]
- Fix: Assert-ElevatedPermission - changed [OutputType([String])] to [OutputType([System.Boolean])]
- Fix: moduleimport.ps1 - Empty catch block is used. Please use Write-Error or throw statements in catch blocks. added catch { Write-Error $_.Exception.Message }
- Fix: [internal\scripts\moduleimport.ps1] Should have no trailing space - line 6
- Fix: Added .Example - None to Assert-ElevatedPermission
- Fix: Added @{ ModuleName='PSFramework'; ModuleVersion='1.1.59' } to the required modules in the manifest
- Fix: It Exports all functions in the public folder - fixed @('Add-AIPRerpository', 'AzureTenantAccountAndApplication').
- Fix: Added example note in New-AIPSystemAccount
- Fix: Added $PSCmdlet.ShouldProcess($PathCheck to New-AIPFolderShare)
- Fix: Removed CreateOnFileShare from New-AIPRepository
- Fix: Removed Confirm and WhatIf parameters from New-AIPFileShare
- Fix: Changed Add-AIPRerpository.ps1 to Add-AIPRepository.ps1
- Fix: [functions\New-AIPFileShare.ps1] Should have no trailing space - Line 59
- Fix: [internal\scripts\moduleimport.ps1] Should not use Write-Error - Removed try/catch
- Fix: Added documentation Confirm and WhatIf back to New-AIPFileShare
- Fix: Removed PSUseShouldProcessForStateChangingFunctions from Add-AIPRepository
- Fix: Added parameters for FileShare and VerifyRepository in New-AIPRepository
- Fix: Re-added PSUseShouldProcessForStateChangingFunctions in New-AIPRepository

## 1.1.70 (2021-04-19)

- New: Borrowed New-Password from ADMF with Fred Weinmann's permissions
- New: Implemented Invoke-PSFProtectedCommand in New-AIPSystemAccount
- New: New function Assert-IEEnhancedSC for checking Enhanced Security Configuration
- New: Added 6 new strings for Assert-IEEnhancedSC.Message1 in strings.psd1
- Fix: Removed -PassThru from moduleimport.ps1
- Fix: Removed Throw statements from moduleimport.ps1
- Fix: Removes scopes from install-module and import-module
- Fix: Fix secure password code to pass PSScriptAnalyzer tests
- Fix: Asset-IEEhancedSC - Fixed Invoke-PSFProtectedCommand -Action Get-ItemProperty
- Fix: Asset-IEEhancedSC - Added $regKey value for if statements
- Fix: strings.psd1 - Fixed Asset-IEEhancedSC.Message2 and Asset-IEEhancedSC.Message4 (removed formatted value)
- Fix: Removed Invoke-PSFProtectedCommand from Assert-IEEnhancedSC to fix formatting for Regkey enabled / disabled
- Fix: Added new Assert-IEEnhancedSC strings in strings.ps1
- Fix: Changed SilentlyContinue to Stop for New-LocalUser
- Upd: Updated module version
- Upd: Fixed paramter and attribute definitions to make them eaiser to follow for debugging purposes in all files
- Upd: Adde SQlserver and AzureADPreview to the required modules list in the manifest
- Upd: Added individual try catches in New-AzureTenantAccountAndApplication for each operation
- Upd: Saved New-Password with UTF8 encoding with Byte Order Mark
- Upd: Updated readme.me with new IE Enhanced Security Configuration check
- Upd: New New-AIPSystemAccount.Message strings added to strings.ps1
- Upd: Updated code with try\catches in New New-AIPSystemAccount to pinpoint exact failures
- Upd: Optimization and re-write of New-AIPFolderShare
- Upd: New strings for New-AIPFolderShare in string.ps1

## 1.1.92 (2021-04-20)

- Fix: Testing localization strings for New-AIPFileShare.Message17
- Fix: Fixed spelling errors in strings.psd1
- Fix: Removed test tenant name from configuration
- Fix: PSScriptAnalyzer error - New-AIPScannerInstall renamed 'New-AIPScannerInstall.Message12 to .Message18'
- New: New-Password - Added begin \ end block with new strings
- New: Adding check for AIPScanner service start \ stop
- New: Created 7 new AIPScannerInstall strings in strings.psd1
- New: Added new try \ catch for Install-AIPScanner
- New: Added new sting for Install-AIPScanner failure in strings.psd1
- New: Added check to test for the default or user supplied
- Chg: New-AIPFileShare - Write-PSFMessage -Level Verbose to -Level Host in begin \ end blocks
- Chg: Add-AIPRerpository - Write-PSFMessage -Level Verbose to -Level Host begin \ end blocks
- Chg: New-AIPFolderShare - removed return so we don't bailout if local folder already exists
- Chg: Fixed typo in 'New-AIPFileShare.Message7' - share fixed to shared
- Chg: Changed 'New-AzureTenantItems.Message3' from = "Failure" to "Connect-AzureAD Failure"
- Chg: Changed 'New-AzureTenantItems.Message13' from = "Failure" to "Get-AzureADUser Failure"
- Chg: Changed 'New-AzureTenantItems.Message13' to 'New-AzureTenantItems.Message7'
- Chg: Created new string structure for New-AzureTenantItems
- Chg: Rearranged New-AIPFileShare to run before New-AzureTenantAccountAndApplication
- Chg: Optimized New-AzureTenantAccountAndApplication.ps1
- Upd: Updated module version
- Upd: Changed 'New-AzureTenantItems.Message2' in string.psd1

## 1.1.98 (2021-5-4)

- Fix: Fixed download url to release now that public preview 2.11.57 has been deprecated
- Fix: Fixed code to now create account and move on to next steps
- Chg: Updated manifest version
- Chg: Updated help file
- Chg: Changed 'Start-PrerequisiteCheck.Message20' to reflect install of account instead of user doing it
- New: Added new string 'Start-PrerequisiteCheck.Message17A'
- New: Added additional check for user defined and local default sql instance
