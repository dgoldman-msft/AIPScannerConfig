# AIP Scanner Configuration Module (AIPScannerConfig)

## Before you start

> 1. You will have to install a version of SQL on the machine first before you can proceed.
> 2. This module is fully customizeable. If you need to make any changes navigate to the following location and file "C:\GitHub Repository\AIPScannerConfig\internal\configurations\configuration.ps1"
> 3. All configuration changes are made cenertally here. If you make any changes, save them and re-run: `Import-Module AIPScannerConfig -Force`

## To get started with this module

> 1. Open PowerShell as an Administrator
> 2. Run Install-Module -Name AIPScannerConfig - NOTE: If you have any SQL errors run Install-Module -Name AIPScannerConfig -AllowClobber
> 3. Run Import-Module -Name AIPScannerConfig
> 4. Run `Start-PrerequisitesCheck -Verbose`
> 5. Once it finished running verify that the AIPScanner account has been created and added to the local Administrators group.
> 6. Before you switch from the Administrator account you will need to change the randomly gererated password on the AIPScanner account.
> 7. Log out of Windows as the Administrator account and log back in as the AIPScanner account.
> 8. Run `Start-PrerequisitesCheck -Verbose`. This will verify that everything is working under the AIPScanner account and check for missing items that might need to be created due to previous errors.

<b><span style="color:red"> NOTE:</b></span> `Start-PrerequisitesCheck` is designed to check for all of the prerequisites needed to install the AIP Scanner on server. If any items are not found this module will install everything necessary.

The prerequisite checks for the following:

> 1. Running PowerShell as an Administrator
> 2. Checks to see if IE Enhanced Security Configuration is enabled or disabled
> 3. Checks operating system level
> 4. Check for Windows Feature NFS-Client
> 5. Checks system memory
> 6. Checks for an active network connection
> 7. Checks for a local SQL instance (default) or a remote SQL instance
> 8. Check to see if the AIPScanner account exists
> 9. Checks for existing AIP Folder and Folder Share

## Error logging

For more information on the logging subsystem please refer to: 'https://psframework.org/documentation/documents/psframework/logging/loggingto/debuglog.html'

> To get verbose output logging information run: `Get-PSFMessage`

## Support Help

For any module issues that might involve deeper troubleshooting you can create a diagnostic debug package.
> Run `New-PSFSupportPackage`

<b><span style="color:red">NOTE:</b></span> Be aware that this package contains a lot of information including your input history in the console.
<b><i><span style="color:orange">Please make sure NO sensitive data (such as passwords) can be caught this way.</b></i></span>