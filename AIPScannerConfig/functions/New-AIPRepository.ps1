function New-AIPRepository {
    <#
    .SYNOPSIS
        Add an AIP repository

    .DESCRIPTION
        This method will add an AIP repository

    .PARAMETER Path
        Path to local file sahre

    .PARAMETER CreateShareOnSharePoint
        Switch to indicate we are creating on a SharePoint share

    .PARAMETER FileShare
        File share used for the AIP Repository

    .PARAMETER VerifyRepository
        Switched use to force a search for repositories instead of creating one

    .PARAMETER EnableException
        Depending on whether $EnableException is true or false it will do the following:
            1. ($True) - Throw a bloody terminating error. Game over.
            2. ($False) - Write a nice warning about how Foo failed bar, then terminate the function. The return on the next line will then end the calling function.

    .EXAMPLE
        PS C:\> New-AIPRepository -Path \\fileserver\documents

        This will create a repository on a local fileshare or server

    .EXAMPLE
        PS C:\> New-AIPRepository -CreateShareOnSharePoint

        This will create a repository on a SharePoint server

    .EXAMPLE
        PS C:\> New-AIPRepository -VerifyRepository

        This will verify the AIP repositories

    .NOTES
        None
    #>

    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
    [OutputType([System.Object])]
    param (
        [Parameter(Position = 0, ParameterSetName = 'FileShare', HelpMessage = 'Path to file share')]
        [string]
        $Path,

        [Parameter(Position = 0, ParameterSetName = 'Create', HelpMessage = 'Create repository on SharePoint')]
        [switch]
        $CreateShareOnSharePoint,

        [Parameter(Position = 1, ParameterSetName = 'FileShare', HelpMessage = 'Create repository on a file share')]
        [switch]
        $FileShare,

        [switch]
        $VerifyRepository
    )

    begin {
        Write-PSFMessage -Level Host -String 'Add-AIPRepository.Message1'
        Send-THEvent -EventName FunctionExecution -Message "Add-AIPRepository started" -ModuleName AIPScannerConfig -Verbose
    }

    process {
        if ($VerifyRepository) {
            Get-AIPScannerRepository
        }
        else {
            Write-PSFMessage -Level Verbose -String 'Add-AIPRepository.Message2'
        }

        if ($CreateShareOnSharePoint) {
            try {
                Connect-MsolService
                \$spLocation = (Get-MsolDomain | Where-Object { $_.isInitial }).Name
                Write-PSFMessage -Level Verbose -String 'Add-AIPRepository.Message3' -StringValues "http://\$spLocation/documents/"
                Add-AIPScannerRepository -Path "http://\$spLocation/documents/"
            }
            catch {
                Send-THEvent -EventName FunctionException -Message "Add-AIPRepository exception: $_" -ModuleName AIPScannerConfig -Verbose
                Write-PSFMessage -Level Verbose -String 'Add-AIPRepository.Message4'
                return
            }
        }
        elseif ($Path -and $FileShare) {
            try {
                Write-PSFMessage -Level Verbose -String 'Add-AIPRepository.Message5' -StringValues "\\$Path\$FileShare"
                Add-AIPScannerRepository -Path "\\$Path\$FileShare"
            }
            catch {
                Send-THEvent -EventName FunctionException -Message "Add-AIPRepository exception: $_" -ModuleName AIPScannerConfig -Verbose
                Write-PSFMessage -Level Verbose -String 'Add-AIPRepository.Message6'
                return
            }
        }
        else {
            Write-PSFMessage -Level Verbose -String 'Add-AIPRepository.Message7'
            return
        }
    }

    end {
        Write-PSFMessage -Level Host -String 'Add-AIPRepository.Message8'
    }
}