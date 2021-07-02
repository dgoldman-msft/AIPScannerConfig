function New-LocalAIPSystemAccount {
    <#
    .SYNOPSIS
        Create local AIP Scanner Accounts

    .DESCRIPTION
        This method will create the necessary AIP scanner accounts.

    .PARAMETER AccountName
        This is the account name for the AIP Scanner account. The default is "AIPScanner"

    .PARAMETER Confirm
        Parameter used to prompt for user confirmation

    .PARAMETER WhatIf
        Parameter used to validate a run without making changes

    .PARAMETER EnableException
        Depending on whether $EnableException is true or false it will do the following:
            1. ($True) - Throw a bloody terminating error. Game over.
            2. ($False) - Write a nice warning about how Foo failed bar, then terminate the function. The return on the next line will then end the calling function.

    .EXAMPLE
        C:>\ New-AIPSystemAccount -AccountName AIPScanner

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

        [switch]
        $EnableException
    )

    begin {
        Write-PSFMessage -Level Host -String 'New-LocalAIPSystemAccount.Message1'
    }

    process {

        try {
            Write-PSFMessage -Level Verbose -String 'New-LocalAIPSystemAccount.Message2'
            if (New-LocalUser $AccountName -Password (New-Password -AsSecureString) -FullName "AIP Scanner Account"`
                    -Description "System account for the AIP Scanner." -PasswordNeverExpires -AccountNeverExpires -ErrorAction Stop ) {
                Write-PSFMessage -Level Verbose -String 'New-LocalAIPSystemAccount.Message3' -StringValues $AccountName
            }
        }
        catch {
            Stop-PSFFunction -String 'New-LocalAIPSystemAccount.Message4' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
        }

        try {
            Add-LocalGroupMember -Group “Administrators” -Member $AccountName -ErrorAction Stop
            Write-PSFMessage -Level Verbose -String 'New-LocalAIPSystemAccount.Message5'
        }
        catch {
            Stop-PSFFunction -String 'New-LocalAIPSystemAccount.Message6' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
        }

        try {
            Get-LocalGroupMember -Group “Administrators” -Member $AccountName -ErrorAction Stop
            Write-PSFMessage -Level Verbose -String 'New-LocalAIPSystemAccount.Message7' -StringValues $AccountName
        }
        catch {
            Write-PSFMessage -Level Verbose -String 'New-LocalAIPSystemAccount.Message8' -StringValues $AccountName
        }

        try {
            $ntPrincipal = New-Object System.Security.Principal.NTAccount "$AccountName"
            $sid = $ntPrincipal.Translate([System.Security.Principal.SecurityIdentifier])
            $sidString = $sid.Value.ToString()
            Write-PSFMessage -Level Verbose -String 'New-LocalAIPSystemAccount.Message9' -StringValues $AccountName

            # Query server to check User rights and export them to a temp file
            Write-PSFMessage -Level Verbose -String 'New-LocalAIPSystemAccount.Message10' -StringValues "$env:TEMP\UserRights.txt"
            $cmdArguments = "/export /cfg $env:TEMP\UserRights.txt"
            Start-Process secedit -ArgumentList $cmdArguments -ErrorAction Stop -Wait

            # Get the policy
            Write-PSFMessage -Level Verbose -String 'New-LocalAIPSystemAccount.Message11' -StringValues "$env:TEMP\UserRights.txt"
            $policy = Get-Content "$env:TEMP\UserRights.txt"

            # Remove all entries until we find SeInteractiveLogonRight
            foreach ($scRight in $policy) {
                if ( $scRight -like "SeInteractiveLogonRight*") {
                    $x = $scRight.split("=", [System.StringSplitOptions]::RemoveEmptyEntries)
                    $currentSetting = $x[1].Trim()
                }
            }

            # Get the SID for the AIPScanner account
            if ( $currentSetting -notlike "*$($sidString)*" ) {
                if ( [string]::IsNullOrEmpty($currentSetting) ) { $currentSetting = "*$($sidString)" }
                else { $currentSetting = "*$($sidString),$($currentSetting)" }

                Write-PSFMessage -Level Verbose -String 'New-LocalAIPSystemAccount.Message12' -StringValues $currentSetting
                $newPolicyFile = @"
[Unicode]
Unicode=yes
[Version]
signature="`$CHICAGO`$"
Revision=1
[Privilege Rights]
SeInteractiveLogonRight = $($currentSetting)
"@
                Write-PSFMessage -Level Verbose -String 'New-LocalAIPSystemAccount.Message13'
                $newPolicyFile | Set-Content -Path "$ENV:TEMP\NewPolicyFile.inf" -Encoding Unicode -Force
                try {
                    $CmdArguments = "/configure /db secedit.sdb /cfg ""$ENV:TEMP\NewPolicyFile.txt"" /areas USER_RIGHTS"
                    Start-Process secedit -ArgumentList $cmdArguments -ErrorAction Stop -Wait
                    Write-PSFMessage -Level Verbose -String 'New-LocalAIPSystemAccount.Message14' -StringValues $AccountName
                }
                catch {
                    Stop-PSFFunction -String 'New-AIPSystemAccount.Message15' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
                }
            }
            else {
                Write-PSFMessage -Level Verbose -String 'New-LocalAIPSystemAccount.Message16' -StringValues $AccountName
            }
        }
        catch {
            Stop-PSFFunction -String 'New-LocalAIPSystemAccount.Message17' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
        }
    }
    end {
        Write-PSFMessage -Level Host -String 'New-LocalAIPSystemAccount.Message18'
    }
}