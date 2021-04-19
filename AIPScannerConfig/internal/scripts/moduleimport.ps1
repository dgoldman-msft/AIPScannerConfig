$Moduledependencies = @("PSFramework", "SqlServer", "AzureADPreview")

foreach ($Module in $Moduledependencies) {
	if (Get-Module -ListAvailable -Name $module) {
			Import-Module -Name $Module -Force -ErrorAction SilentlyContinue
	}
	else {
			if (-NOT (Install-Module -Name $Module -Scope AllUsers -Force -AllowClobber -ErrorAction SilentlyContinue)) { throw }
			if (-NOT (Import-Module -Name $Module -Scope AllUsers -Force -ErrorAction SilentlyContinue )) { throw }
	}
}