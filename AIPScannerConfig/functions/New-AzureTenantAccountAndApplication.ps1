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
            if ($tenantInfo = Connect-AzureAD -AccountId (Get-PSFConfigValue -FullName AIPScannerConfig.CloudAdminAccount) -ErrorAction Stop) {
                $domain = $tenantInfo.TenantDomain
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

        try {
            Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message4'
            if (-NOT (Get-AzureADUser | Where-Object UserPrincipalName -eq "AIPScannerCloud@$domain")) {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message5'
                $passwordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
                $passwordProfile.ForceChangePasswordNextLogin = $false
                $password = Read-Host -assecurestring "Please enter password for cloud service account"
                $password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
                $passwordProfile.Password = $password
                New-AzureADUser -AccountEnabled $True -DisplayName "AIP Scanner Cloud Service" -PasswordProfile $passwordProfile -MailNickName "AIPScannerCloud" -UserPrincipalName "AIPScannerCloud@$Domain"
            }
            else {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message6'
            }
        }
        catch {
            Stop-PSFFunction -String 'New-AzureTenantItems.Message13' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
            return $false
        }

        try {
            if (-NOT(Get-AzureADApplication -Filter "DisplayName eq 'AIPOnBehalfOf'")) {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message7'
                New-AzureADApplication -DisplayName AIPOnBehalfOf -ReplyUrls http://localhost -ErrorAction Stop
                $webApp = Get-AzureADApplication -Filter "DisplayName eq 'AIPOnBehalfOf'"
            }
            else {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message8'
                $webApp = Get-AzureADApplication -Filter "DisplayName eq 'AIPOnBehalfOf'"
            }
        }
        catch {
            Stop-PSFFunction -String 'New-AzureTenantItems.Message13' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
            return $false
        }

        try {
            if (-NOT (Get-AzureADServicePrincipal -All $true | Where-object DisplayName -eq "AIPOnBehalfOf")) {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message9'
                New-AzureADServicePrincipal -DisplayName AIPOnBehalfOf -AppId $webApp.AppId
                $webAppKey = New-Guid
                $date = Get-Date
                New-AzureADApplicationPasswordCredential -ObjectId $webApp.ObjectID -startDate $date -endDate $date.AddYears(1) -Value $webAppKey.Guid -CustomKeyIdentifier "AIPClient"

                $aipServicePrincipal = Get-AzureADServicePrincipal -All $true | Where-Object { $_.DisplayName -eq 'AIPOnBehalfOf' }
                $aipPermissions = $aipServicePrincipal | Select-Object -Expand Oauth2Permissions
                $scope = New-Object -TypeName "Microsoft.Open.AzureAD.Model.ResourceAccess" -ArgumentList $aipPermissions.Id, "Scope"
                $access = New-Object -TypeName "Microsoft.Open.AzureAD.Model.RequiredResourceAccess"
                $access.ResourceAppId = $webApp.AppId
                $access.ResourceAccess = $scope
            }
            else {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message10'
            }
        }
        catch {
            Stop-PSFFunction -String 'New-AzureTenantItems.Message13' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
            return $false
        }

        try {
            if (-NOT(Get-AzureADApplication -Filter "DisplayName eq 'AIPClient'")) {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message11'
                New-AzureADApplication -DisplayName AIPClient -ReplyURLs http://localhost -RequiredResourceAccess $Access -PublicClient $true
                $nativeApp = Get-AzureADApplication -Filter "DisplayName eq 'AIPClient'"
                New-AzureADServicePrincipal -AppId $nativeApp.AppId
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