@{
	# Script module or binary module file associated with this manifest
	RootModule        = 'AIPScannerConfig.psm1'

	# Version number of this module.
	ModuleVersion     = '1.2.29'

	# ID used to uniquely identify this module
	GUID              = '3ddb8805-2f0c-4fe5-81ea-db8dc77e0452'

	# Author of this module
	Author            = 'Dave Goldman'

	# Company or vendor of this module
	CompanyName       = 'Microsoft'

	# Copyright statement for this module
	Copyright         = 'Copyright (c) 2021 - Dave Goldman'

	# Description of the functionality provided by this module
	Description       = 'Automated AIP Scanner Configuration Module'

	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion = '5.0'

	# Modules that must be imported into the global environment prior to importing
	# this module
	RequiredModules   = @(
		@{ ModuleName = 'AzureADPreview'; ModuleVersion = '2.0.2.134' }
		@{ ModuleName = 'PSFramework'; ModuleVersion = '1.6.197' }
		@{ ModuleName = 'SqlServer'; ModuleVersion = '21.1.18245' }
	)

	# Assemblies that must be loaded prior to importing this module
	# RequiredAssemblies = @('bin\AIPScannerConfig.dll')

	# Type files (.ps1xml) to be loaded when importing this module
	# TypesToProcess = @('xml\AIPScannerConfig.Types.ps1xml')

	# Format files (.ps1xml) to be loaded when importing this module
	# FormatsToProcess = @('xml\AIPScannerConfig.Format.ps1xml')

	# Functions to export from this module
	FunctionsToExport = @(
		'Add-AccountToSQLRole'
		'Get-AIPAuthToken'
		'New-AIPRepository'
		'New-AIPFileShare'
		'New-AIPScannerInstall'
		'New-AIPSystemAccount'
		'New-AzureTenantAccountAndApplication'
		'Start-PrerequisiteCheck'
	)

	# Cmdlets to export from this module
	CmdletsToExport   = ''

	# Variables to export from this module
	VariablesToExport = ''

	# Aliases to export from this module
	AliasesToExport   = ''

	# List of all modules packaged with this module
	ModuleList        = @()

	# List of all files packaged with this module
	FileList          = @()

	# Private data to pass to the module specified in ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData       = @{

		#Support for PowerShellGet galleries.
		PSData = @{

			# Tags applied to this module. These help with module discovery in online galleries.
			Tags       = @("SCC", "Security", "AIP", "AIPScanner")

			# A URL to the license for this module.
			LicenseUri = 'https://github.com/dgoldman-msft/AIPScannerConfig/blob/main/LICENSE'

			# A URL to the main website for this project.
			ProjectUri = 'https://github.com/dgoldman-msft/AIPScannerConfig'

			# A URL to an icon representing this module.
			# IconUri = ''

			# ReleaseNotes of this module
			# ReleaseNotes = ''

		} # End of PSData hashtable

	} # End of PrivateData hashtable
}