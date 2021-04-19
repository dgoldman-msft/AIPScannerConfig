function New-AzureTenantAccountAndApplication {
    <#
        .SYNOPSIS
            Create Azure AIP items

        .DESCRIPTION
            This method will create all of the necessary Azure components needed for the AIP scanner to function

        .PARAMETER EnableException
            Depending on whether $EnableException is true or false it will do the following:
                1. ($True) - Throw a bloody terminating error. Game over.
                2. ($False) - Write a nice warning about how Foo failed bar, then terminate the function. The return on the next line will then end the calling function.

        .PARAMETER Confirm
            Parameter used to prompt for user confirmation

        .PARAMETER WhatIf
            Parameter used to validate a run without making changes

        .EXAMPLE
            PS C:\> New-AzureTenantAccountAndApplication

            Start the process for creating the cloud applications and accounts

        .EXAMPLE
            PS C:\> New-AzureTenantAccountAndApplication -EnabledException

            Start the process for creating the cloud applications and accounts with EnabledException turned on

        .NOTES
            Internal function
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([System.Boolean])]
    param (
        [switch]
        $EnableException
    )

    begin {
        Write-PSFMessage -Level Host -String 'New-AzureTenantItems.Message1'
    }

    process {
        try {
            try {
                if ($TenantInfo = Connect-AzureAD -AccountId (Get-PSFConfigValue -FullName AIPScannerConfig.CloudAdminAccount) -ErrorAction Stop) {
                    $Domain = $TenantInfo.TenantDomain
                }
                else {
                    Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message2'
                    return $false
                }
            }
            catch {
                Stop-PSFFunction -String 'New-AzureTenantItems.Message3' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
                return $false
            }

            Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message4'
            if (-NOT (Get-AzureADUser | Where-Object UserPrincipalName -eq "AIPScannerCloud@$Domain")) {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message5'
                $PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
                $PasswordProfile.ForceChangePasswordNextLogin = $false
                $Password = Read-Host -assecurestring "Please enter password for cloud service account"
                $Password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password))
                $PasswordProfile.Password = $Password
                New-AzureADUser -AccountEnabled $True -DisplayName "AIP Scanner Cloud Service" -PasswordProfile $PasswordProfile -MailNickName "AIPScannerCloud" -UserPrincipalName "AIPScannerCloud@$Domain"
            }
            else {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message6'
            }
            
            if (-NOT(Get-AzureADApplication -Filter "DisplayName eq 'AIPOnBehalfOf'")) {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message7'
                New-AzureADApplication -DisplayName AIPOnBehalfOf -ReplyUrls http://localhost -ErrorAction Stop
                $WebApp = Get-AzureADApplication -Filter "DisplayName eq 'AIPOnBehalfOf'"
            }
            else {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message8'
                $WebApp = Get-AzureADApplication -Filter "DisplayName eq 'AIPOnBehalfOf'"
            }

            if (-NOT (Get-AzureADServicePrincipal -All $true | Where-object DisplayName -eq "AIPOnBehalfOf")) {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message9'
                New-AzureADServicePrincipal -DisplayName AIPOnBehalfOf -AppId $WebApp.AppId
                $WebAppKey = New-Guid
                $Date = Get-Date
                New-AzureADApplicationPasswordCredential -ObjectId $WebApp.ObjectID -startDate $Date -endDate $Date.AddYears(1) -Value $WebAppKey.Guid -CustomKeyIdentifier "AIPClient"

                $AIPServicePrincipal = Get-AzureADServicePrincipal -All $true | Where-Object { $_.DisplayName -eq 'AIPOnBehalfOf' }
                $AIPPermissions = $AIPServicePrincipal | Select-Object -Expand Oauth2Permissions
                $Scope = New-Object -TypeName "Microsoft.Open.AzureAD.Model.ResourceAccess" -ArgumentList $AIPPermissions.Id, "Scope"
                $Access = New-Object -TypeName "Microsoft.Open.AzureAD.Model.RequiredResourceAccess"
                $Access.ResourceAppId = $WebApp.AppId
                $Access.ResourceAccess = $Scope
            }
            else {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message10'
            }

            if (-NOT(Get-AzureADApplication -Filter "DisplayName eq 'AIPClient'")) {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message11'
                New-AzureADApplication -DisplayName AIPClient -ReplyURLs http://localhost -RequiredResourceAccess $Access -PublicClient $true
                $NativeApp = Get-AzureADApplication -Filter "DisplayName eq 'AIPClient'"
                New-AzureADServicePrincipal -AppId $NativeApp.AppId
            }
            else {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message12'
            }
        }
        catch {
            Stop-PSFFunction -String 'New-AzureTenantItems.Message13' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
            return $false
        }
    }

    end {
        Write-PSFMessage -Level Host -String 'New-AzureTenantItems.Message14' -StringValues $completed
    }
}