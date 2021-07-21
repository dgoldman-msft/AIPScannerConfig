function Start-PrerequisiteCheck {
    <#
    .SYNOPSIS
        Check system prerequisites

    .DESCRIPTION
        This method will ensure that all prerequisites are in place before the automated configuration

    .PARAMETER ComputerName
        Computer name we are running against

    .PARAMETER SqlRemote
        Switch to check for remote SQL instnaces

    .PARAMETER UserDefinedSqlInstance
        User specified SQL Instance

    .PARAMETER AllInOneInstall
        Switch used to indicate we are working on an non-domain joined machine

    .PARAMETER SkipNetworktest
        Skips the network test - used for lab testing

    .PARAMETER Confirm
        Parameter used to prompt for user confirmation

    .PARAMETER WhatIf
        Parameter used to validate a run without making changes

    .PARAMETER EnableException
        Depending on whether $EnableException is true or false it will do the following:
            1. ($True) - Throw a bloody terminating error. Game over.
            2. ($False) - Write a nice warning about how Foo failed bar, then terminate the function. The return on the next line will then end the calling function.

    .EXAMPLE
        PS C:\> Start-PrerequisiteCheck -ComputerName Machine01 -Verbose

        This will start the prerequisite checks

    .EXAMPLE
        PS C:\> Start-PrerequisiteCheck -ComputerName Machine01 -SqlRemote -Verbose

        This will start the prerequisite checks and check for a remote Sql instance

    .EXAMPLE
        PS C:\> Start-PrerequisiteCheck -ComputerName Machine01 -EnableException

        This will change the termination when we encounter an error

    .NOTES
        The prerequisites below are still required for successful AIP scanner installation.

        1. A Windows Server 2012 R2 or 2016 Server to run the service with a minimum 4 CPU and 4GB RAM physical or virtual
        NOTE:  The scanner will allocate RAM 2.5-3 times of size of all files being scanned in parallel. Thus, if you scan 40 files that are 20MB each at the same time, it should take about 202.540=2GB RAM. However, if you have one big 1GB file it can take 3GB of RAM just for that file.

        Internet connectivity necessary for Azure Information Protection
        ----------------------------------------------------------------
        NOTE: A SQL Server 2012+ local or remote instance (Any version from Express or better is supported)
        Sysadmin role needed to install scanner service (user running Install-AIPScanner, not the service account)

        NOTE: If using SQL Server Express, the SQL Instance name is ServerName\SQLExpress.

        NOTE: At this time, a different SQL instance is needed for each AIP Scanner node.

        Service account created in On Premises AD (I will call this account AIPScanner in this document).
        Service requires Log on locally right and Log on as a service right (the second will be given during scanner service install).
        Service account requires Read permissions to each repository for discovery and Read/Write permissions for classification/protection.
        AzInfoProtection.exe available on the Microsoft Download Center (The scanner bits are included with the AIP Client)

        For more information on the logging system and PSFramework: https://psframework.org/documentation/documents/psframework/logging/loggingto/debuglog.html
    #>

    [CmdletBinding(SupportsShouldProcess)]
    param (
        [object]
        $ComputerName = (Get-PSFConfigValue -Fullname AIPScannerConfig.ComputerName),

        [switch]
        $SqlRemote,

        [switch]
        $AllInOneInstall,

        [string]
        $UserDefinedSqlInstance,

        [switch]
        $SkipNetworkTest,

        [switch]
        $EnableException
    )

    begin {
        Write-PSFMessage -Level Host -String 'Start-PrerequisiteCheck.Message1'
        # Sending the first metric will create an instance of a TelemetryClient and subsequent calls will simply reuse the client
        Send-THEvent -EventName FunctionExecution -Message "Start-PrerequisiteCheck started" -ModuleName AIPScannerConfig -Verbose
    }

    process {
        if (-NOT (Assert-ElevatedPermission)) { return }
        Assert-IEEnhancedSC
        Write-PSFMessage -Level Verbose -String 'Start-PrerequisiteCheck.Message2'
        $ServerVersion = Get-CimInstance Win32_OperatingSystem | Select-Object -ExpandProperty Caption

        if (($ServerVersion -match "Microsoft Windows Server 2012 R2")`
                -or ($ServerVersion -like "Microsoft Windows Server 2016*")`
                -or ($ServerVersion -like "Microsoft Windows Server 2019*")`
                -or ($ServerVersion -like "Microsoft Windows Server 2022*")) {
            Write-PSFMessage -Level Verbose -String 'Start-PrerequisiteCheck.Message3' -StringValues $ServerVersion
        }
        else {
            Write-PSFMessage -Level Host -String 'Start-PrerequisiteCheck.Message4'
            return
        }

        Write-PSFMessage -Level Verbose -String 'Start-PrerequisiteCheck.Message5'
        $WindowsFeature = Get-WindowsFeature | Where-Object Name -eq "NFS-Client"

        if (-NOT ($WindowsFeature.Installed)) {
            Write-PSFMessage -Level Verbose -String 'Start-PrerequisiteCheck.Message6'
            Install-WindowsFeature -Name "NFS-Client" -verbose
        }
        else {
            Write-PSFMessage -Level Verbose -String 'Start-PrerequisiteCheck.Message7'
        }

        Write-PSFMessage -Level Verbose -String 'Start-PrerequisiteCheck.Message8'
        $ComputerSystem = Get-CimInstance -Class "Win32_ComputerSystem"
        $Memory = [math]::Ceiling($ComputerSystem.TotalPhysicalMemory / 1024 / 1024 / 1024)
        if ( $Memory -lt 4 ) {
            Write-PSFMessage -Level Host -String 'Start-PrerequisiteCheck.Message9'
            return
        }
        else {
            Write-PSFMessage -Level Verbose -String 'Start-PrerequisiteCheck.Message10' -StringValues $Memory
        }

        try {
            if ($SkipNetworkTest) { continue } else {
                Write-PSFMessage -Level Verbose -String 'Start-PrerequisiteCheck.Message11'
                $OriginalPreference = $ProgressPreference
                $ProgressPreference = "SilentlyContinue"
            
                if (Test-NetConnection -ComputerName (Get-PSFConfigValue -Fullname AIPScannerConfig.NetConnection) -InformationLevel Quiet) {
                    Write-PSFMessage -Level Verbose -String 'Start-PrerequisiteCheck.Message12'
                }
                else {
                    Write-PSFMessage -Level Host -String 'Start-PrerequisiteCheck.Message13'
                    return
                }
                # Restore original preferences
                $ProgressPreference = $OriginalPreference
            }
            
            Write-PSFMessage -Level Verbose -String 'Start-PrerequisiteCheck.Message14'

            if ($SqlRemote) {
                foreach ($ServerInstance in $ComputerName) {
                    if (Get-SqlInstance -ServerInstance $ServerInstance -ErrorAction SilentlyContinue) {
                        Write-PSFMessage -Level Verbose -String 'Start-PrerequisiteCheck.Message15' -StringValues $ServerInstance
                        $Instancefound = $true
                    }
                    else {
                        $Instancefound = $false
                    }
                }

                if (-NOT ($Instancefound)) {
                    Write-PSFMessage -Level Host -String 'Start-PrerequisiteCheck.Message16'
                    return
                }
            }
            else {
                # Check if a user defined instance is provided
                if ($UserDefinedSqlInstance) {
                    if (Get-SqlInstance -ServerInstance $UserDefinedSqlInstance -ErrorAction SilentlyContinue) {
                        Write-PSFMessage -Level Verbose -String 'Start-PrerequisiteCheck.Message17' -StringValues $UserDefinedSqlInstance
                    }
                    else {
                        Write-PSFMessage -Level Verbose -String 'Start-PrerequisiteCheck.Message17A'
                    }
                }

                # Check local default defined instance
                if (Get-SqlInstance -ServerInstance "$env:COMPUTERNAME\SQLEXPRESS" -ErrorAction SilentlyContinue) {
                    Write-PSFMessage -Level Verbose -String 'Start-PrerequisiteCheck.Message17' -StringValues "$env:COMPUTERNAME\SQLEXPRESS"
                }
                else {
                    Write-PSFMessage -Level Host -String 'Start-PrerequisiteCheck.Message18'
                    return
                }
            }

            if ($AllInOneInstall) {
                if (Get-LocalUser -Name (Get-PSFConfigValue -Fullname AIPScannerConfig.ScannerAccountName) -ErrorAction SilentlyContinue) {
                    Write-PSFMessage -Level Verbose -String 'Start-PrerequisiteCheck.Message19'
                }
                else {
                    Write-PSFMessage -Level Verbose -String 'Start-PrerequisiteCheck.Message20'
                    New-LocalAIPSystemAccount
                    Add-AccountToSQLRole -AllInOneInstall
                }
    
                New-AIPFileShare -AllInOneInstall
                if (New-AzureTenantAccountAndApplication) {
                    New-AIPScannerInstall
                }
                else {
                    return
                }
            }
        }
        catch {
            Send-THEvent -EventName FunctionException -Message "Start-PrerequisiteCheck exception: $_" -ModuleName AIPScannerConfig -Verbose
            Stop-PSFFunction -String 'Start-PrerequisiteCheck.Message21' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_

        }
    }

    end {
        Write-PSFMessage -Level Host -String 'Start-PrerequisiteCheck.Message22'
    }
}