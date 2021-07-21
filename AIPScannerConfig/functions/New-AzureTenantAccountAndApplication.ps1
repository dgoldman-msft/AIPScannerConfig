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
        Send-THEvent -EventName FunctionExecution -Message "New-AzureTenantItems started" -ModuleName AIPScannerConfig -Verbose
        $aipClient = (Get-PSFConfigValue -Fullname AIPScannerConfig.ScannerAccountName)
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
            Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message2' -StringValues $domain
        }
        catch {
            Send-THEvent -EventName FunctionException -Message "New-AzureTenantItems exception: $_" -ModuleName AIPScannerConfig -Verbose
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
            Send-THEvent -EventName FunctionException -Message "New-AzureTenantItems exception: $_" -ModuleName AIPScannerConfig -Verbose
            Stop-PSFFunction -String 'New-AzureTenantItems.Message7' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
            return $false
        }

        try {
            if (-NOT(Get-AzureADApplication -Filter "DisplayName eq 'AIPOnBehalfOf'")) {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message8'
                New-AzureADApplication -DisplayName AIPOnBehalfOf -ReplyUrls http://localhost -ErrorAction Stop
                $webApp = Get-AzureADApplication -Filter "DisplayName eq 'AIPOnBehalfOf'"
            }
            else {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message9'
                $webApp = Get-AzureADApplication -Filter "DisplayName eq 'AIPOnBehalfOf'"
            }
        }
        catch {
            Send-THEvent -EventName FunctionException -Message "New-AzureTenantItems exception: $_" -ModuleName AIPScannerConfig -Verbose
            Stop-PSFFunction -String 'New-AzureTenantItems.Message10' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
            return $false
        }

        try {
            Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message10' -StringValues "AIPOnBehalfOf"
            if (-NOT (Get-AzureADServicePrincipal -All $true | Where-object DisplayName -eq "AIPOnBehalfOf")) {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message11'
                New-AzureADServicePrincipal -DisplayName AIPOnBehalfOf -AppId $webApp.AppId
                $webAppKey = New-Guid
                $date = Get-Date

                try {
                    Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message12'
                    New-AzureADApplicationPasswordCredential -ObjectId $webApp.ObjectID -startDate $date -endDate $date.AddYears(1) -Value $webAppKey.Guid -CustomKeyIdentifier "AIPClient"
                    $aipServicePrincipal = Get-AzureADServicePrincipal -All $true | Where-Object { $_.DisplayName -eq 'AIPOnBehalfOf' }
                    $aipPermissions = $aipServicePrincipal | Select-Object -Expand Oauth2Permissions
                    $scope = New-Object -TypeName "Microsoft.Open.AzureAD.Model.ResourceAccess" -ArgumentList $aipPermissions.Id, "Scope"
                    $access = New-Object -TypeName "Microsoft.Open.AzureAD.Model.RequiredResourceAccess"
                    $access.ResourceAppId = $webApp.AppId
                    $access.ResourceAccess = $scope
                }
                catch {
                    Send-THEvent -EventName FunctionException -Message "New-AzureTenantItems exception: $_" -ModuleName AIPScannerConfig -Verbose
                    Stop-PSFFunction -String 'New-AzureTenantItems.Message13' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
                    return $false
                }
            }
            else {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message14'
            }
        }
        catch {
            Send-THEvent -EventName FunctionException -Message "New-AzureTenantItems exception: $_" -ModuleName AIPScannerConfig -Verbose
            Stop-PSFFunction -String 'New-AzureTenantItems.Message15' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
            return $false
        }

        try {
            Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message16' -StringValues $aipClient
            if (-NOT(Get-AzureADApplication -Filter "DisplayName eq 'AIPClient'")) {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message17' -StringValues $aipClient

                try {
                    New-AzureADApplication -DisplayName AIPClient -ReplyURLs http://localhost -RequiredResourceAccess $Access -PublicClient $true
                    $nativeApp = Get-AzureADApplication -Filter "DisplayName eq 'AIPClient'"
                    Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message18' -StringValues $aipClient
                }
                catch {
                    Send-THEvent -EventName FunctionException -Message "New-AzureTenantItems exception: $_" -ModuleName AIPScannerConfig -Verbose
                    Stop-PSFFunction -String 'New-AzureTenantItems.Message19' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
                    return $false
                }

                try {
                    New-AzureADServicePrincipal -AppId $nativeApp.AppId
                }
                catch {
                    Send-THEvent -EventName FunctionException -Message "New-AzureTenantItems exception: $_" -ModuleName AIPScannerConfig -Verbose
                    Stop-PSFFunction -String 'New-AzureTenantItems.Message15' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
                    return $false
                }
            }
            else {
                Write-PSFMessage -Level Verbose -String 'New-AzureTenantItems.Message19' -StringValues $aipClient
            }
        }
        catch {
            Send-THEvent -EventName FunctionException -Message "New-AzureTenantItems exception: $_" -ModuleName AIPScannerConfig -Verbose
            Stop-PSFFunction -String 'New-AzureTenantItems.Message20' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
            return $false
        }
    }
    end {
        Write-PSFMessage -Level Host -String 'New-AzureTenantItems.Message21'
    }
}