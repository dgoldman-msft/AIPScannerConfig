$Moduledependencies = @("PSFramework", "SqlServer", "AzureADPreview", "TelemetryHelper")

foreach ($Module in $Moduledependencies) {
	if (Get-Module -ListAvailable -Name $module) {
			Import-Module -Name $Module -Force -ErrorAction SilentlyContinue
	}
	else {
			Install-Module -Name $Module -AllowClobber -Force -ErrorAction SilentlyContinue
			Import-Module -Name $Module -Force -ErrorAction SilentlyContinue
	}
}