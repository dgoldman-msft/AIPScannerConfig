function Add-AccountToSQLRole {
    <#
    .SYNOPSIS
        Add APIScanner to SQL Role

    .DESCRIPTION
        This method will add the AIP Scanner account to the SQL dbcreator role

    .EXAMPLE
        PS C:\> Start-PrerequisiteCheck -EnableException

    .NOTES
        None
    #>

    [CmdletBinding(SupportsShouldProcess)]
    param (
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
            $sqlServer = New-Object 'Microsoft.SqlServer.Management.Smo.Server' "$env:COMPUTERNAME\SQLEXPRESS" -ErrorAction Stop
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