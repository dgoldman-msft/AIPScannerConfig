$Moduledependencies = @("PSFramework", "SqlServer", "AzureADPreview")

foreach ($Module in $Moduledependencies) {
	if (Get-Module -ListAvailable -Name $module) {
			Import-Module -Name $Module -Force -ErrorAction SilentlyContinue
	}
	else {
			Install-Module -Name $Module -Force -AllowClobber -ErrorAction SilentlyContinue
			Import-Module -Name $Module -Force -ErrorAction SilentlyContinue
	}
}