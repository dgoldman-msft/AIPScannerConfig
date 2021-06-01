function Add-AccountToSQLRole {
    <#
    .SYNOPSIS
        Add APIScanner to SQL Role

    .DESCRIPTION
        This method will add the AIP Scanner account to the SQL dbcreator role

    .PARAMETER UserDefinedSqlInstance
        User specified SQL Instance

    .PARAMETER EnableException
        Depending on whether $EnableException is true or false it will do the following:
            1. ($True) - Throw a bloody terminating error. Game over.
            2. ($False) - Write a nice warning about how Foo failed bar, then terminate the function. The return on the next line will then end the calling function.

    .EXAMPLE
        PS C:\> Add-AccountToSQLRole -UserDefinedSqlInstance "Server01\DatabaseName"

        User specified Sql instance

    .EXAMPLE
        PS C:\> Add-AccountToSQLRole -EnableException

        Enable full debugging error logging

    .NOTES
        None
    #>

    [CmdletBinding(PSUseShouldProcessForStateChangingFunctions = $true)]
    param (
        [string]
        $UserDefinedSqlInstance,

        [switch]
        $EnableException
    )

    begin {
        Write-PSFMessage -Level Host -String 'Add-AccountToSQLRole.Message1'
    }

    process {
        try {
            Write-PSFMessage -Level Verbose -String 'Add-AccountToSQLRole.Message2'
            $null = [System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO')
            if ($UserDefinedSqlInstance) {
                $sqlServer = New-Object 'Microsoft.SqlServer.Management.Smo.Server' $UserDefinedSqlInstance -ErrorAction Stop
            }
            else {
                $sqlServer = New-Object 'Microsoft.SqlServer.Management.Smo.Server' "$env:COMPUTERNAME\SQLEXPRESS" -ErrorAction Stop
            }
            Write-PSFMessage -Level Host -String 'Add-AccountToSQLRole.Message3'
            $login = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Login -ArgumentList $sqlServer, "$env:COMPUTERNAME\AIPScanner" -ErrorAction Stop
            $login.LoginType = "WindowsUser"
            $login.Create()
            $login.AddToRole("dbcreator")
            $login.Alter()
            Write-PSFMessage -Level Host -String 'Add-AccountToSQLRole.Message4'
        }
        catch {
            Stop-PSFFunction -String 'Add-AccountToSQLRole.Message5' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
        }
    }

    end {
        Write-PSFMessage -Level Host -String 'Add-AccountToSQLRole.Message6'
    }
}