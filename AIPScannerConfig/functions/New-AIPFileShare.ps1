function New-AIPFileShare {
    <#
    .SYNOPSIS
        Create a file share

    .DESCRIPTION
        Create a file share for the AIP scanner

    .PARAMETER FolderName
        Folder name of the AIP file share

    .PARAMETER ShareName
        Name of the shared folder

    .PARAMETER Confirm
        Parameter used to prompt for user confirmation

    .PARAMETER WhatIf
        Parameter used to validate a run without making changes

    .PARAMETER EnableException
        Depending on whether $EnableException is true or false it will do the following:
            1. ($True) - Throw a bloody terminating error. Game over.
            2. ($False) - Write a nice warning about how Foo failed bar, then terminate the function. The return on the next line will then end the calling function.

    .EXAMPLE
        PS C:\> New-AIPFileShare -ComputerName Server01 -FolderName c:\temp -ShareName YourShareName

        Will create a new file folder and file share called YourShareName at c:\temp on Server01

    .NOTES
        https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/create-method-in-class-win32-share?redirectedfrom=MSDN

        Create has two rules:
            1. You must be an administrator on the machine.
            2. You must Run as administrator the Windows PowerShell console.
    #>

    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([System.Boolean])]
    param (
        [string]
        $folderName = (Get-PSFConfigValue -Fullname AIPScannerConfig.RootFolder),

        [string]
        $ShareName = (Get-PSFConfigValue -Fullname AIPScannerConfig.AIPShare),

        [switch]
        $EnableException
    )

    begin {
        Write-PSFMessage -Level Host -String 'New-AIPFileShare.Message1'
    }

    process {
        try {
            $pathCheck = Join-Path $folderName -ChildPath $ShareName -ErrorAction Stop
            Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message2' -StringValues $pathCheck
        }
        catch {
            Stop-PSFFunction -String 'New-AIPFileShare.Message3' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
        }

        try {
            If (Test-Path -Path $pathCheck) {
                Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message4' -StringValues $pathCheck
            }
            else {
                if (New-Item -Path $pathCheck -ItemType Directory -ErrorAction Stop ) {
                    Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message5' -StringValues $pathCheck
                }
            }
        }
        catch {
            Stop-PSFFunction -String 'New-AIPFileShare.Message6' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
        }

        try {
            Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message7' -StringValues $pathCheck
            if (Get-SmbShare -Name $ShareName -ErrorAction SilentlyContinue) {
                Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message8' -StringValues $pathCheck
                return
            }
            else {
                if (New-SMBShare –Name (Get-PSFConfigValue -FullName AIPScannerConfig.AIPShare) –Path $pathCheck -Description "AIP Shared Folder" -FullAccess "$env:COMPUTERNAME\AIPScanner") {
                    Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message9' -StringValues (Get-PSFConfigValue -FullName AIPScannerConfig.AIPShare)
                    $account = (Get-PSFConfigValue -FullName 'AIPScannerConfig.ScannerAccountName')
                    $acl = (Get-Item $pathCheck).GetAccessControl('Access')

                    Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message10' -StringValues (Get-PSFConfigValue -FullName AIPScannerConfig.AIPShare)
                    if (($acl.Access | Where-Object { ($_.IdentityReference.Value.Contains($account.ToUpperInvariant()) -or $_.IdentityReference.Value.Contains($account)) -and $_.FileSystemRights -eq [System.Security.AccessControl.FileSystemRights]::FullControl }).Count -eq 1) {
                        Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message11' -StringValues $pathCheck
                        return
                    }
                }
                else {
                    Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message12' -StringValues $pathCheck
                    return
                }
            }
        }
        catch {
            Stop-PSFFunction -String 'New-AIPFileShare.Message13' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
        }

        try {
            Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message14' -StringValues $pathCheck
            $accessControlRule = New-Object System.Security.AccessControl.FileSystemAccessRule((Get-PSFConfigValue -FullName AIPScannerConfig.ScannerAccountName), "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
            $acl.SetAccessRule($accessControlRule)
            if ( Set-Acl $pathCheck $acl -Passthru ) { Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message15' -StringValues $pathCheck }
            else { Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message16' -StringValues $pathCheck }

        }
        catch {
            Stop-PSFFunction -String 'New-AIPFileShare.Message17' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
        }
    }

    end {
        Write-PSFMessage -Level Host -String 'New-AIPFileShare.Message18' -StringValues $pathCheck
    }
}