function Assert-ElevatedPermissions {
    <#
    .SYNOPSIS
        Check the elevation level
    
    .DESCRIPTION
        Checks to see if we are running PowerShell with Administrator credentials
    
    .EXAMPLE
        PS C:\> Assert-ElevatedPermissions    

    .NOTES
        Internal function
        Exists out if the interactive PowerShell session is not being run with administrative credentials
    #>
    
    [CmdletBinding()]
    param ()
    
    begin {
        Write-PSFMessage -Level Host -String 'Assert-ElevatedPermissions.Message1'
    }
    process{
        if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
            Write-PSFMessage -Level Host -String 'Assert-ElevatedPermissions.Message2' 
            return $False
        }
        else {
            Write-PSFMessage -Level Host -String 'Assert-ElevatedPermissions.Message3'
            return $True
        }
    }
}