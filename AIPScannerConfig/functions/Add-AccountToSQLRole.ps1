function Add-AccountToSQLRole {
    <#
    .SYNOPSIS
        Add APIScanner to SQL Role

    .DESCRIPTION
        This method will add the AIP Scanner account to the SQL dbcreator role

    .PARAMETER SqlServer
        User specified SQL Instance

    .PARAMETER AccountName
        Name of account to add to SQL instance

    .PARAMETER AllInOneInstall
        Switch used to indicate we are working on an non-domain joined machine
    
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

    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
    [cmdletbinding()]
    param (
        [string]
        $SqlServer = (Get-PSFConfigValue -Fullname AIPScannerConfig.SQLServer),

        [string]
        $AccountName = (Get-PSFConfigValue -Fullname AIPScannerConfig.ScannerAccountName),

        [switch]
        $AllInOneInstall,

        [switch]
        $EnableException
    )

    begin {
        Write-PSFMessage -Level Host -String 'Add-AccountToSQLRole.Message1'
    }

    process {
        try {
            Write-PSFMessage -Level Verbose -String 'Add-AccountToSQLRole.Message2'
            Write-PSFMessage -Level Verbose -String 'Add-AccountToSQLRole.Message3'
            if ($AllInOneInstall) { 
                $sqlInstance = New-Object 'Microsoft.SqlServer.Management.Smo.Server' localhost -ErrorAction Stop 
                Add-SqlLogin -ServerInstance $sqlInstance.Name -LoginName ([string]::Format("{0}\{1}", $env:COMPUTERNAME, $AccountName))`
                    -LoginType WindowsUser -Enable -GrantConnectSql -LoginPSCredential (Get-Credential ([string]::Format("{0}\{1}", $env:COMPUTERNAME, $AccountName)))`
                    -ErrorAction SilentlyContinue -ErrorVariable Failed
            } 
            else { 
                $sqlInstance = New-Object 'Microsoft.SqlServer.Management.Smo.Server' $SqlServer -ErrorAction Stop 
            
                Add-SqlLogin -ServerInstance $sqlInstance.Name -LoginName ([string]::Format("{0}\{1}", $env:USERDOMAIN, $AccountName))`
                    -LoginType WindowsUser -Enable -GrantConnectSql -LoginPSCredential (Get-Credential ([string]::Format("{0}\{1}", $env:USERDOMAIN, $AccountName)))`
                    -ErrorAction SilentlyContinue -ErrorVariable Failed
            }
        }
        catch {
            Write-PSFMessage -Level Host -String 'Add-AccountToSQLRole.Message5' -StringValues $Failed        
        }

        Write-PSFMessage -Level Host -String 'Add-AccountToSQLRole.Message4'

        try {
            Write-PSFMessage -Level Host -String 'Add-AccountToSQLRole.Message6'
            $roles = ('dbcreator', 'sysadmin')
            foreach ($role in $roles) {
                $adminRole = $sqlInstance.Roles | Where-Object { $_.Name -eq $role }
                $adminRole.AddMember(([string]::Format("{0}\{1}", $env:USERDOMAIN, $AccountName)))
            }
            $roles = $sqlInstance.Roles | Where-Object { $_.Name -eq 'dbcreator' -and 'sysadmin' }
            $roles.AddMember(([string]::Format("{0}\{1}", $env:USERDOMAIN, $AccountName)))
            Write-PSFMessage -Level Host -String 'Add-AccountToSQLRole.Message7'
        }
        catch {
            Write-PSFMessage -Level Host -Message 'Error'
        }
    }

    end {
        Write-PSFMessage -Level Host -String 'Add-AccountToSQLRole.Message9'
    }
}