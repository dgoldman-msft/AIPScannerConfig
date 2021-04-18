function New-AIPRepository {
    <#
    .SYNOPSIS
        Add an AIP repository
    
    .DESCRIPTION
        This method will add an AIP repository
    
    .PARAMETER Path
        Path to local file sahre

    .PARAMETER CreateOnFileShare
        Switch to indicate we are creating on a file share
    
    .PARAMETER CreateShareOnSharePoint
        Switch to indicate we are creating on a SharePoint share

    .PARAMETER EnableException
        Depending on whether $EnableException is true or false it will do the following:
            1. ($True) - Throw a bloody terminating error. Game over.
            2. ($False) - Write a nice warning about how Foo failed bar, then terminate the function. The return on the next line will then end the calling function.
    
    .EXAMPLE
        PS C:\> Add-AIPRepository -Path \\fileserver\documents

        This will create a repository on a local fileshare or server

    .EXAMPLE
        PS C:\> Add-AIPRepository -CreateShareOnSharePoint
        
        This will create a repository on a SharePoint server

    .EXAMPLE
        PS C:\> Add-AIPRepository -VerifyRepository

        This will verify the AIP repositories
    
    .NOTES
        None
    #>

    [CmdletBinding(PSUseShouldProcessForStateChangingFunctions = $true)]
    [OutputType([System.Boolean])]
    param (
        [Parameter(Position = 0, ParameterSetName = 'FileShare', HelpMessage = 'Path to file share')]
        [string]
        $Path,

        [Parameter(Position = 1, ParameterSetName = 'FileShare', HelpMessage = 'Create repository on a file share')]
        [switch]
        $CreateOnFileShare,

        [Parameter(Position = 0, ParameterSetName = 'Create', HelpMessage = 'Create repository on SharePoint')]
        [switch]
        $CreateShareOnSharePoint,

        [Parameter(Position = 2, ParameterSetName = 'FileShare', HelpMessage = 'Create repository on a file share')]
        [switch]
        $FileShare,

        [switch]
        $VerifyRepository,

        [switch]
        $EnableException
    )
    
    begin {
        Write-PSFMessage -Level Verbose -String 'Add-AIPRerpository.Message1'
    }
    
    process {
        if ($VerifyRepository) {
            Get-AIPScannerRepository
        }
        else {
            Write-PSFMessage -Level Host -String 'Add-AIPRerpository.Message2'
        }

        if ($CreateShareOnSharePoint) {
            try {
                #$Cred = Get-Credential
                #$Credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($Cred.Username, $Cred.Password)
                Connect-MsolService
                $SpLocation = (Get-MsolDomain | Where-Object { $_.isInitial }).Name
                Write-PSFMessage -Level Verbose -String 'Add-AIPRerpository.Message3' -StringValues "http://$SpLocation/documents/"
                Add-AIPScannerRepository -Path "http://$SpLocation/documents/"
            }
            catch {
                Write-PSFMessage -Level Verbose -String 'Add-AIPRerpository.Message4'
                return
            }
        }
        elseif ($Path -and $FileShare) {
            try {
                Write-PSFMessage -Level Verbose -String 'Add-AIPRerpository.Message5' -StringValues "\\$Path\$FileShare"
                Add-AIPScannerRepository -Path "\\$Path\$FileShare"
            }
            catch {
                Write-PSFMessage -Level Verbose -String 'Add-AIPRerpository.Message6'
                return
            }
        }
        else {
            Write-PSFMessage -Level Verbose -String 'Add-AIPRerpository.Message7'
            return
        }
    }
    
    end {
        Write-PSFMessage -Level Host -String 'Add-AIPRerpository.Message8'
    }
}