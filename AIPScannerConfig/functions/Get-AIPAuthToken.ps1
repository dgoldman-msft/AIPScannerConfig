function Get-AIPAuthToken {
    <#
        .SYNOPSIS
            Obtain an authentication token

        .DESCRIPTION
            This method obtain an authentication token for the local session or cloud account for unattened access to the Azure Log workspace for the AIP scanner

        .PARAMETER AppId
            AIP Scanner tenant application id
        
        .PARAMETER AppSecret
            AIP Scanner tenant application secret key
        
        .PARAMETER TenantID
            Azure tenant ID

        .PARAMETER UnifiedLabelingClient
            Switch for generating an unattended authentication token for the Unified Labeling Client

        .PARAMETER EnableException
            Depending on whether $EnableException is true or false it will do the following:
                1. ($True) - Throw a bloody terminating error. Game over.
                2. ($False) - Write a nice warning about how Foo failed bar, then terminate the function. The return on the next line will then end the calling function.

        .EXAMPLE
            PS C:\> Get-AIPAuthToken

            Generate a local authentication token

        .EXAMPLE
            PS C:\> Get-AIPAuthToken -UnifiedLabelingClient

            Generate an unatended authentication token

        .NOTES
            None
    #>
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param (
        [string]
        $AppId,

        [string]
        $AppSecret,

        [string]
        $TenantId,

        [switch]
        $UnifiedLabelingClient,

        [switch]
        $EnableException
    )

    begin {
        Write-PSFMessage -Level Host -String 'Get-AIPAuthToken.Message1'
        $adminAccount = (Get-PSFConfigValue -FullName AIPScannerConfig.CloudAdminAccount)
    }

    process {
        try {
            if ( $adminAccount -eq "admin@yourtenant.onmicrosoft.com" ) {
                $tenantInfo = Connect-AzureAD -ErrorAction Stop
            }
            else {
                $tenantInfo = Connect-AzureAD -AccountId $adminAccount -ErrorAction Stop
            }

            $domain = $tenantInfo.TenantDomain
            Write-PSFMessage -Level Verbose -String 'Get-AIPAuthToken.Message2' -StringValues $domain
        }
        catch {
            Stop-PSFFunction -String 'Get-AIPAuthToken.Message3' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
            return
        }

        try {
            if ($UnifiedLabelingClient) {
                # Check to see if we passed in an AppId and Secret key
                if ($AppId -and $AppSecret -and $TenantId) {
                    Write-PSFMessage -Level Host -String 'Get-AIPAuthToken.Message4'
                    $creds = Get-Credential "AIPScannerCloud@$domain" -Message "Please enter credentials for your AIPScannerCloud account"
                    Set-AIPAuthentication -AppId $AppId -AppSecret $AppSecret -DelegatedUser "AIPScannerCloud@$domain" -TenantId $TenantId -OnBehalfOf $creds
                }
                else {
                    # We did not pass in tenant info, check the local module configuration file
                    if (((Get-PSFConfigValue -FullName AIPScannerConfig.AppId) -eq 'Empty') -and ((Get-PSFConfigValue -FullName AIPScannerConfig.AppSecret) -eq 'Empty') -and ((Get-PSFConfigValue -FullName AIPScannerConfig.TenantID) -eq 'Empty')) {
                        Write-PSFMessage -Level Host -String 'Get-AIPAuthToken.Message5'
                        return
                    }
                    else {
                        Write-PSFMessage -Level Host -String 'Get-AIPAuthToken.Message6'
                        $creds = Get-Credential "AIPScannerCloud@$domain" -Message "Please enter credentials for your AIPScannerCloud account"
                        Set-AIPAuthentication -AppId (Get-PSFConfigValue -FullName AIPScannerConfig.AppId) -AppSecret (Get-PSFConfigValue -FullName AIPScannerConfig.AppSecret) -DelegatedUser "AIPScannerCloud@$domain" -TenantId (Get-PSFConfigValue -FullName AIPScannerConfig.TenanID) -OnBehalfOf $creds
                    }
                }
            }
            else {
                # Nothing was passed in from the command line or found in the configuration file so we will just grab a local interactive token
                Write-PSFMessage -Level Host -String 'Get-AIPAuthToken.Message7'
                Set-AIPAuthentication
            }
        }
        catch {
            Stop-PSFFunction -String 'Get-AIPAuthToken.Message8' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
            return $false
        }
    }
    
    end {
        Write-PSFMessage -Level Host -String 'Get-AIPAuthToken.Message9'
    }
}