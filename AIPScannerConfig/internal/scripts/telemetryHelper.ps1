# build the properties and metrics
$eventProperties = @{
    PSVersion = $PSVersionTable.PSVersion.ToString()
    PSEdition = $PSVersionTable.PSEdition
    ModuleVersion = '1.2.79'
}

# Sending the first metric will create an instance of a TelemetryClient
# subsequent calls will simply reuse the client
Send-THEvent -EventName ModuleImportEvent -PropertiesHash $eventProperties -ModuleName AIPScannerConfig -Verbose