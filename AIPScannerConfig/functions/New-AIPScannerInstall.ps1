function New-AIPScannerInstall {
    <#
        .SYNOPSIS
            Install the AIP scanner
        
        .DESCRIPTION
            This will download the latest version of the AIP scanner and install it on the local machine
        
        .PARAMETER Cluster
            Name of the AIP Cluster we are targeting for data collection

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

    [CmdletBinding()]
    param (
        [string]
        $Cluster = "None",

        [switch]
        $EnableException
    )
    
    begin {
        Write-PSFMessage -Level Host -String 'New-AIPScannerInstall.Message1'
    }
    
    process {
        try {
            $InstalledProduct = Get-WMIObject -Query "SELECT * FROM Win32_Product" | Where-Object Name -eq 'Microsoft Azure Information Protection'

            if (-NOT ($InstalledProduct)) {
                # Download the scanner
                Write-PSFMessage -Level Host -String 'New-AIPScannerInstall.Message2'
                $url = "https://download.microsoft.com/download/4/9/1/491251F7-46BA-46EC-B2B5-099155DD3C27/AzInfoProtection_UL_2.11.57_PublicPreview.exe"
                $outpath = "$env:TEMP\AzInfoProtection_UL_2.11.57_PublicPreview.exe"
                Invoke-WebRequest -Uri $url -OutFile $outpath
                Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message3'

                # Install the scanner
                Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message4'
                $cmdArguements = '/install /passive /norestart /log AipScannerInstallLog.txt'
                Start-Process -Filepath "$env:TEMP\AzInfoProtection_UL_2.11.57_PublicPreview.exe" -ArgumentList $cmdArguements
            }
            else {
                Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message5'
                $AIPScannerModule = (Get-PSFConfigValue -FullName AIPScannerConfig.ScannerModule)
                $Imported = Import-Module -Name $AIPScannerModule -PassThru -ErrorAction Stop
            
                if ($Imported) {
                    Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message6' -StringValues $AIPScannerModule.Name
                }
                else {
                    Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message7' -StringValues $AIPScannerModule.Name
                    throw "Module import failed!"
                }

                Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message8'
                Install-AIPScanner -SqlServerInstance "$env:ComputerName\SQLExpress" -ErrorAction Stop
                
                if ($Cluster -eq "None") {
                    $Cluster = Read-Host "Please enter your Azure AIP Cluster Name"
                }

                Write-PSFMessage -Level Verbose -String 'New-AIPScannerInstall.Message9'
                Set-AIPScanner -SqlServerInstance "$env:COMPUTERNAME\SQLEXPRESS" -Cluster $Cluster -ErrorAction Stop
            }
        }
        catch {
            Stop-PSFFunction -String 'New-AIPScannerInstall.Message10' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
        }
    }

    end {
        Write-PSFMessage -Level Host -String 'New-AIPScannerInstall.Message11'
    }
}