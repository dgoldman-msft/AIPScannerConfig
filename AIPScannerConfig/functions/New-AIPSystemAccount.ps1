function New-AIPSystemAccount {
    <#
    .SYNOPSIS
        Create local AIP Scanner Accounts
    
    .DESCRIPTION
        This method will create the necessary AIP scanner accounts.
    
    .PARAMETER AccountName
        This is the account name for the AIP Scanner account. The default is "AIPScanner"
    
    .PARAMETER EnableException
        Depending on whether $EnableException is true or false it will do the following:
            1. ($True) - Throw a bloody terminating error. Game over.
            2. ($False) - Write a nice warning about how Foo failed bar, then terminate the function. The return on the next line will then end the calling function.

    .EXAMPLE
        C:>\ New-AIPSystemAccounts
    
    .NOTES
        1. Service requires Log on locally right and Log on as a service right (the second will be given during scanner service install).
        2. Service account requires Read permissions to each repository for discovery and Read/Write permissions for classification/protection.
        3. The default password is a secure 16 character password. You will need to change the password if you need to logon to this account
    #>

    [CmdletBinding(SupportsShouldProcess)]
    param (
        [string]
        $AccountName = (Get-PSFConfigValue -Fullname AIPScannerConfig.ScannerAccountName),

        [switch]
        $EnableException
    )
    
    begin {
        Write-PSFMessage -Level Host -String 'New-AIPSystemAccount.Message1'
    }
    
    process {
        try {
            Write-PSFMessage -Level Verbose -String 'New-AIPSystemAccount.Message2'
            Add-Type -AssemblyName System.Web
            $Password = [System.Web.Security.Membership]::GeneratePassword(16, 2)
            $User = New-LocalUser $AccountName -Password (ConvertTo-SecureString $Password -AsPlainText -Force) -FullName "AIP Scanner Account"`
                    -Description "System account for the AIP Scanner." -PasswordNeverExpires -AccountNeverExpires -ErrorAction SilentlyContinue
            if($User){
                Write-PSFMessage -Level Verbose -String 'New-AIPSystemAccount.Message3' -StringValues $AccountName
            }
            else {
                Write-PSFMessage -Level Verbose -String 'New-AIPSystemAccount.Message4'
            }

            Add-LocalGroupMember -Group “Administrators” -Member $AccountName -ErrorAction Stop
            if (Get-LocalGroupMember -Group “Administrators” -Member $AccountName -ErrorAction SilentlyContinue) {
                Write-PSFMessage -Level Verbose -String 'New-AIPSystemAccount.Message5'          
            }
            else {
                Write-PSFMessage -Level Verbose -String 'New-AIPSystemAccount.Message6'          
            }

            $NTPrincipal = New-Object System.Security.Principal.NTAccount "$AccountName"
            $Sid = $NTPrincipal.Translate([System.Security.Principal.SecurityIdentifier])
            $SidString = $Sid.Value.ToString()

            if ( [string]::IsNullOrEmpty($SidString) ) {
                Write-PSFMessage -Level Verbose -String 'New-AIPSystemAccount.Message7' -StringValues $AccountName
                return $false
            }

            # Query server to check User rights and export them to a temp file
            Write-PSFMessage -Level Verbose -String 'New-AIPSystemAccount.Message8'
            $CmdArguments = "/export /cfg $env:TEMP\UserRights.txt"
            Start-Process secedit -ArgumentList $CmdArguments

            # Get the policy
            $Policy = Get-Content "$env:TEMP\UserRights.txt"

            # Remove all entries until we find SeInteractiveLogonRight
            foreach ($ScRight in $Policy) {
                if ( $ScRight -like "SeInteractiveLogonRight*") {
                    $x = $ScRight.split("=", [System.StringSplitOptions]::RemoveEmptyEntries)
                    $currentSetting = $x[1].Trim()
                }
            }

            # Get the SID for the AIPScanner account
            if ( $currentSetting -notlike "*$($SidString)*" ) {
                Write-PSFMessage -Level Verbose -String 'New-AIPSystemAccount.Message9' -StringValues $AccountName

                if ( [string]::IsNullOrEmpty($currentSetting) ) {
                    $currentSetting = "*$($SidString)"
                }
                else {
                    $currentSetting = "*$($SidString),$($currentSetting)"
                }

                Write-PSFMessage -Level Verbose -String 'New-AIPSystemAccount.Message10' -StringValues $currentSetting
                $NewPolicyFile = @"
[Unicode]
Unicode=yes
[Version]
signature="`$CHICAGO`$"
Revision=1
[Privilege Rights]
SeInteractiveLogonRight = $($currentSetting)
"@  
                Write-PSFMessage -Level Verbose -String 'New-AIPSystemAccount.Message11'              
                $NewPolicyFile | Set-Content -Path "$ENV:TEMP\NewPolicyFile.inf" -Encoding Unicode -Force
                try {
                    $CmdArguments = "/configure /db secedit.sdb /cfg ""$ENV:TEMP\NewPolicyFile.txt"" /areas USER_RIGHTS"
                    Start-Process secedit -ArgumentList $CmdArguments
                }
                catch {
                    Stop-PSFFunction -String 'New-AIPSystemAccount.Message12' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_ 

                }
            }
            else {
                Write-PSFMessage -Level Verbose -String 'New-AIPSystemAccount.Message13' -StringValues $AccountName
            }
        }
        catch {
            Stop-PSFFunction -String 'New-AIPSystemAccount.Message14' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
        }
    }
    end {
        Write-PSFMessage -Level Host -String 'New-AIPSystemAccount.Message15'  
    }
}