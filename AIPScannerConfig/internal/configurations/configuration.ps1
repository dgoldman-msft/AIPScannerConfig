<#
This is an example configuration file

By default, it is enough to have a single one of them,
however if you have enough configuration settings to justify having multiple copies of it,
feel totally free to split them into multiple files.
#>

<#
# Example Configuration
Set-PSFConfig -Module 'AIPScannerConfig' -Name 'Example.Setting' -Value 10 -Initialize -Validation 'integer' -Handler { } -Description "Example configuration setting. Your module can then use the setting using 'Get-PSFConfigValue'"
#>

Set-PSFConfig -Module 'AIPScannerConfig' -Name 'Import.DoDotSource' -Value $false -Initialize -Validation 'bool' -Description "Whether the module files should be dotsourced on import. By default, the files of this module are read as string value and invoked, which is faster but worse on debugging."
Set-PSFConfig -Module 'AIPScannerConfig' -Name 'Import.IndividualFiles' -Value $false -Initialize -Validation 'bool' -Description "Whether the module files should be imported individually. During the module build, all module code is compiled into few files, which are imported instead by default. Loading the compiled versions is faster, using the individual files is easier for debugging and testing out adjustments."

# AIP Scanner items
Set-PSFConfig -Module 'AIPScannerConfig' -Name 'AIPShare' -Value "AIPScannerShare" -Initialize -Validation 'string' -Description "AIP Scanner share name."
Set-PSFConfig -Module 'AIPScannerConfig' -Name 'ScannerAccountName' -Value "AIPScanner" -Initialize -Validation 'string' -Description "AIP Scanner account name."

# AIP Folder locations
Set-PSFConfig -Module 'AIPScannerConfig' -Name 'ComputerName' -Value "$env:COMPUTERNAME" -Initialize -Validation 'string' -Description "Local system name."
Set-PSFConfig -Module 'AIPScannerConfig' -Name 'TempFolder' -Value "$env:TEMP" -Initialize -Validation 'string' -Description "Temp Folder path."
Set-PSFConfig -Module 'AIPScannerConfig' -Name 'RootFolder' -Value "c:\" -Initialize -Validation 'string' -Description "C:\"

# Azure Information Protection Module Manifest
Set-PSFConfig -Module 'AIPScannerConfig' -Name 'ScannerModule' -Value "C:\Program Files (x86)\Microsoft Azure Information Protection\Powershell\AzureInformationProtection" -Initialize -Validation 'string' -Description "AIP protection module manifest file."
Set-PSFConfig -Module 'AIPScannerConfig' -Name 'CloudAdminAccount' -Value "admin@M365x119893.onmicrosoft.com" -Initialize -Validation 'string' -Description "Azure AD admin account"