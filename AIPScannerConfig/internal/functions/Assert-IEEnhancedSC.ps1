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

        Invoke-PSFProtectedCommand -Action Get-LocalGroupMember -Target $env:COMPUTERNAME -ScriptBlock {
            if ( ( Get-ItemProperty -Path $adminKey -Name "IsInstalled" -ErrorAction SilentlyContinue).IsInstalled ) {
                Write-PSFMessage -Level Host -String 'Assert-IEEnhancedSC.Message2'
            }
            else {
                Write-PSFMessage -Level Host -String 'Assert-IEEnhancedSC.Message3'
            }
        }

        if (Test-PSFFunctionInterrupt) { return }

        Invoke-PSFProtectedCommand -Action Get-LocalGroupMember -Target $env:COMPUTERNAME -ScriptBlock {
            if ( ( Get-ItemProperty -Path $userKey -Name "IsInstalled" -ErrorAction SilentlyContinue).IsInstalled ) {
                Write-PSFMessage -Level Host -String 'Assert-IEEnhancedSC.Message4'
            }
            else {
                Write-PSFMessage -Level Host -String 'Assert-IEEnhancedSC.Message5'
            }
        }

        if (Test-PSFFunctionInterrupt) { return }
    }

    end {
        Write-PSFMessage -Level Host -String 'Assert-IEEnhancedSC.Message6'
    }
}