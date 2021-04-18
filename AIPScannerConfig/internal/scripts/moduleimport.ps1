$Moduledependencies = @("PSFramework", "SqlServer", "AzureADPreview")

foreach ($Module in $Moduledependencies) {
	if (Get-Module -ListAvailable -Name $module) {
		Write-Verbose "Module: $Module found! Importing module"
		try {
			Import-Module -Name $Module -Force -ErrorAction SilentlyContinue
		}
		catch {
			Write-Verbose -Message "Import module error: $Module"
		}
	}
	else {
		Write-Verbose "Module not found locally! Installing module: $Module"
		try {
			if (-NOT (Install-Module -Name $Module -Scope AllUsers -Force -AllowClobber -ErrorAction Stop -PassThru)) { throw }
			if (-NOT (Import-Module -Name $Module -Force -ErrorAction SilentlyContinue -PassThru)) { throw }
		}
		catch {
			Write-Warning -Message "Module error: $Module | $_.Exception.Message"
		}
	}
}