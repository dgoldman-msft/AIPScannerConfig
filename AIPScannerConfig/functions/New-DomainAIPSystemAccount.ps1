function New-DomainAIPSystemAccount {
    <#
    .SYNOPSIS
        Create local AIP Scanner Accounts

    .DESCRIPTION
        This method will create the necessary AIP scanner accounts.

    .PARAMETER AccountName
        This is the account name for the AIP Scanner account. The default is "AIPScanner"

    .PARAMETER DomainController
        Active directory domain controller where users get created

    .PARAMETER Confirm
        Parameter used to prompt for user confirmation

    .PARAMETER WhatIf
        Parameter used to validate a run without making changes

    .PARAMETER EnableException
        Depending on whether $EnableException is true or false it will do the following:
            1. ($True) - Throw a bloody terminating error. Game over.
            2. ($False) - Write a nice warning about how Foo failed bar, then terminate the function. The return on the next line will then end the calling function.

    .EXAMPLE
        C:>\ New-DomainAIPSystemAccount -AccountName AIPScanner

        Executes the creation of the AIPSystem account

    .NOTES
        1. Service requires Log on locally right and Log on as a service right (the second will be given during scanner service install).
        2. Service account requires Read permissions to each repository for discovery and Read/Write permissions for classification/protection.
        3. The default password is a secure 16 character password. You will need to change the password if you need to logon to this account
    #>

    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([System.String])]
    param (
        [string]
        $AccountName = (Get-PSFConfigValue -Fullname AIPScannerConfig.ScannerAccountName),

        [string]
        $DomainController = (Get-PSFConfigValue -Fullname AIPScannerConfig.DomainController),
        
        [switch]
        $EnableException
    )

    begin {
        Write-PSFMessage -Level Host -String 'New-DomainAIPSystemAccount.Message1'
    }

    process {
        try {
            $dcSession = New-PSSession -Name ADAccountCreation -ComputerName $DomainController -Credential (Get-Credential) 
            Write-PSFMessage -Level Verbose -String 'New-DomainAIPSystemAccount.Message2'
            $securePw = (New-Password -AsSecureString)
           
            Invoke-Command -Session $dcSession -ScriptBlock { param ( $using:AccountName, $using:securePw )
                if (New-ADUser -Name $AccountName -AccountPassword $securePw -DisplayName "AIP Scanner Account" -Description "System account for the AIP Scanner."`
                        -PasswordNeverExpires $false -PassThru ) {
                    Write-PSFMessage -Level Verbose -String 'New-DomainAIPSystemAccount.Message3'
                } 
            } -ArgumentList $AccountName, $securePw -ErrorAction SilentlyContinue -ErrorVariable UserFailed
                
            if ($userFailed) { $UserFailed.Exception.Message }
        }
        catch {
            Stop-PSFFunction -String 'New-DomainAIPSystemAccount.Message4' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
        }

        try {
            Write-PSFMessage -Level Verbose -String 'New-DomainAIPSystemAccount.Message5'

            $groupMember = Invoke-Command -Session $dcSession -ScriptBlock { param( $using:AccountName )
                Add-ADGroupMember -Identity Administrators -Members $AccountName -PassThru 
            } -ArgumentList $AccountName -ErrorAction SilentlyContinue 

            if ($groupMember) {  
                Write-PSFMessage -Level Host -String 'New-DomainAIPSystemAccount.Message6'
            }
        }
        catch {
            Stop-PSFFunction -String 'New-DomainAIPSystemAccount.Message7' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
        }

        Remove-PSSession -Name ADAccountCreation
    }

    end {
        Write-PSFMessage -Level Host -String 'New-DomainAIPSystemAccount.Message8'
    }
}
