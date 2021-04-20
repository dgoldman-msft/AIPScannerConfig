function Assert-IEEnhancedSC {
    <#
    .SYNOPSIS
        Check the state of IE Enhanced Security Configuration

    .DESCRIPTION
        Checks to see if IE Enhanced Security Configuration is enabled or disabled
    .
    .EXAMPLE
        None

        None

    .NOTES
        Internal function
        If IE Enhanced Security Configuration is enabled connecting to an Azure tenant will cause failures until it is disabled.
    #>

    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param ()

    begin {
        Write-PSFMessage -Level Host -String 'Assert-IEEnhancedSC.Message1'
        $adminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
        $userKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    }

    process {
        try {
            $adminRegKey = Get-ItemProperty -Path $adminKey -Name "IsInstalled" -ErrorAction SilentlyContinue

            if ($adminRegKey.IsInstalled) { Write-PSFMessage -Level Host -String 'Assert-IEEnhancedSC.Message2' -StringValues $adminRegKey.IsInstalled }
            else { Write-PSFMessage -Level Host -String 'Assert-IEEnhancedSC.Message3' }

            $userRegKey = Get-ItemProperty -Path $userKey -Name "IsInstalled" -ErrorAction SilentlyContinue

            if ($userRegKey.IsInstalled ) { Write-PSFMessage -Level Host -String 'Assert-IEEnhancedSC.Message4' -StringValues $userRegKey.IsInstalled }
            else { Write-PSFMessage -Level Host -String 'Assert-IEEnhancedSC.Message5' }
        }
        catch {
            Stop-PSFFunction -String 'Assert-IEEnhancedSC.Message6' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
        }
    }

    end {
        Write-PSFMessage -Level Host -String 'Assert-IEEnhancedSC.Message7'
    }
}