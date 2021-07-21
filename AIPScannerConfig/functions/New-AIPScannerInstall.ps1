function New-AIPScannerInstall {
    <#
        .SYNOPSIS
            Install the AIP scanner

        .DESCRIPTION
            This will download the latest version of the AIP scanner and install it on the local machine

        .PARAMETER Cluster
            Name of the AIP Cluster we are targeting for data collection

        .PARAMETER Confirm
            Parameter used to prompt for user confirmation

        .PARAMETER WhatIf
            Parameter used to validate a run without making changes

        .PARAMETER EnableException
            Depending on whether $EnableException is true or false it will do the following:
                1. ($True) - Throw a bloody terminating error. Game over.
                2. ($False) - Write a nice warning about how Foo failed bar, then terminate the function. The return on the next line will then end the calling function.

        .EXAMPLE
            PS C:\> New-AIPScannerInstall

            This will download the AIP scanner and install it on the local system

        .NOTES
            Internal function
    #>

    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([System.String])]
    param (
        [string]
        $Cluster = "None",

        [switch]
        $EnableException
    )

    begin {
        Write-PSFMessage -Level Host -String 'New-AIPScannerInstall.Message1'
        Send-THEvent -EventName FunctionExecution -Message "New-AIPScannerInstall started" -ModuleName AIPScannerConfig -Verbose
    }

    process {
        try {
            $installedProduct = Get-CimInstance win32_product | Where-Object Name -eq 'Microsoft Azure Information Protection'

            if (-NOT ($installedProduct)) {
                # Download the scanner
                Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message2'
                $url = "https://download.microsoft.com/download/4/9/1/491251F7-46BA-46EC-B2B5-099155DD3C27/AzInfoProtection_UL.exe"
                $outpath = "$env:TEMP\AzInfoProtection_UL.exe"
                Invoke-WebRequest -Uri $url -OutFile $outpath
                Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message3'

                # Install the scanner
                Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message4'
                $cmdArguements = '/install /passive /norestart /log AipScannerInstallLog.txt'
                Start-Process -Filepath "$env:TEMP\AzInfoProtection_UL.exe" -ArgumentList $cmdArguements -Wait
            }
            else {
                Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message5'
            }

            try {
                $aipScannerModule = (Get-PSFConfigValue -FullName AIPScannerConfig.ScannerModule)
                $imported = Import-Module -Name $aipScannerModule -PassThru -ErrorAction Stop

                if ($imported) {
                    Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message6' -StringValues $aipScannerModule.Name
                }
                else {
                    Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message7' -StringValues $aipScannerModule.Name
                    throw "Module import failed!"
                }

                Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message8'
                Install-AIPScanner -SqlServerInstance "$env:ComputerName\SQLExpress" -ErrorAction Stop

                if ($Cluster -eq "None") {
                    $Cluster = Read-Host "Please enter your Azure AIP Cluster Name"
                }
            }
            catch {
                Send-THEvent -EventName FunctionException -Message "New-AIPScannerInstall exception: $_" -ModuleName AIPScannerConfig -Verbose
                Stop-PSFFunction -String 'New-AIPScannerInstall.Message9' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
            }

            try {
                Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message10'
                # Get-localsql instance
                
                if (Set-AIPScanner -SqlServerInstance "$env:COMPUTERNAME\SQLEXPRESS" -Cluster $Cluster -ErrorAction Stop) {
                    Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message11'
                }
                else {
                    Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message12'
                }
            }
            catch {
                Send-THEvent -EventName FunctionException -Message "New-AIPScannerInstall exception: $_" -ModuleName AIPScannerConfig -Verbose
                Stop-PSFFunction -String 'New-AIPScannerInstall.Message13' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
            }

            try {
                Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message14'
                $service = Get-Service | Where-Object Name -eq 'AIPScanner'
                if ($service.Status -eq 'Stopped') {
                    Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message15'
                    Start-Service -Name AIPScanner -ErrorAction Stop
                }
                else {
                    Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message16'
                }
            }
            catch {
                Send-THEvent -EventName FunctionException -Message "New-AIPScannerInstall exception: $_" -ModuleName AIPScannerConfig -Verbose
                Stop-PSFFunction -String 'New-AIPScannerInstall.Message17' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
            }

        }
        catch {
            Stop-PSFFunction -String 'New-AIPScannerInstall.Message18' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
        }
    }

    end {
        Write-PSFMessage -Level Host -String 'New-AIPScannerInstall.Message19'
    }
}