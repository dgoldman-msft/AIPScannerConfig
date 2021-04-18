# AIP Scanner Configuration Module (AIPScannerConfig)

## Before you start

> 1. You will have to install a version of SQL on the machine first before you can proceed.
> 2. This module is fully customizeable. If you need to make any changes navigate to the following location and file "C:\GitHub Repository\AIPScannerConfig\internal\configurations\configuration.ps1"
> 3. All configuration changes are made cenertally here. If you make any changes, save them and re-run: `Import-Module AIPScannerConfig -Force`

## To get started with this module

> 1. Open PowerShell as an Administrator
> 2. Run Import-Module -Name AIPScannerConfig
> 3. Run `New-AIPSystemAcount` to create the AIPScanner system account
> 4. Change the randomly gererated password on the AIPScanner account
> 5. Log out of Windows and back in as the AIPScanner account
> 6. Run `Start-PrerequisitesCheck`

`Start-PrerequisitesCheck` is designed to check for all of the prerequisites needed to install the AIP Scanner on server.

 This module will install of the prerequisite modules and import them on import of the AIPScannerConfig module.

<b><span style="color:red">NOTE:</b></span> All functions can be ran independently to install FileShare, SystemAccount, AzureItems (Cloud Accounts, Azure Applications, etc.)

The prerequisite checks for the following:

> 1. Running PowerShell as an Administrator
> 2. Checks operating system level
> 3. Check for Windows Feature NFS-Client
> 4. Checks system memory
> 5. Checks for an active network connection
> 6. Checks for a local SQL instance (default) or a remote SQL instance
> 7. Check to see if the AIPScanner account exists
> 8. Checks for existing AIP Folder and Folder Share

## Error logging

For more information on the logging subsystem please refer to: 'https://psframework.org/documentation/documents/psframework/logging/loggingto/debuglog.html'

> To get verbose output logging information run: `Get-PSFMessage`

## Support Help

For any module issues that might involve deeper troubleshooting you can create a diagnostic debug package.
> Run `New-PSFSupportPackage`

<b><span style="color:red">NOTE:</b></span> Be aware that this package contains a lot of information including your input history in the console.
<b><i><span style="color:orange">Please make sure NO sensitive data (such as passwords) can be caught this way.</b></i></span>
