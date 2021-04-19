function Assert-ElevatedPermission {
    <#
    .SYNOPSIS
        Check the elevation level
    
    .DESCRIPTION
        Checks to see if we are running PowerShell with Administrator credentials
    .
    .EXAMPLE
        None

        None

    .NOTES
        Internal function
        Exists out if the interactive PowerShell session is not being run with administrative credentials
    #>
    
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param ()
    
    begin {
        Write-PSFMessage -Level Host -String 'Assert-ElevatedPermission.Message1'
    }
    process{
        if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
            Write-PSFMessage -Level Host -String 'Assert-ElevatedPermission.Message2'
            return $False
        }
        else {
            Write-PSFMessage -Level Host -String 'Assert-ElevatedPermission.Message3'
            return $True
        }
    }
}