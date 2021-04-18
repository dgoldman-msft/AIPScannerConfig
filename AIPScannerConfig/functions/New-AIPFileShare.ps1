function New-AIPFileShare {
    <#
    .SYNOPSIS
        Create a file share
    
    .DESCRIPTION
        Create a file share for the AIP scanner
    
    .PARAMETER ComputerName
        Computer name where we will create the AIP file share
    
    .PARAMETER FolderName
        Folder name of the AIP file share
    
    .PARAMETER SharePath
        Path to where the AIP folder share will be created

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
        $ComputerName = (Get-PSFConfigValue -Fullname AIPScannerConfig.ComputerName),

        [string]
        $Foldername = (Get-PSFConfigValue -Fullname AIPScannerConfig.RootFolder),

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
            $PathCheck = Join-Path $Foldername -ChildPath $ShareName
            Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message2' -StringValues $PathCheck
            
            If (-NOT (Test-Path -Path $PathCheck)) {
                
                $Folder = New-Item -Path $PathCheck -ItemType Directory -ErrorAction Stop
                Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message3' -StringValues $PathCheck
                
                if ($Folder) {
                    Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message4' -StringValues $PathCheck
                    
                    if (-NOT (Get-WmiObject -List -ComputerName $env:COMPUTERNAME | Where-Object -FilterScript { $_.Name -eq $ShareName })) {
                        $NewShare = New-SMBShare –Name (Get-PSFConfigValue -FullName AIPScannerConfig.AIPShare) –Path $PathCheck -Description "AIP Shared Folder" -FullAccess "$env:COMPUTERNAME\AIPScanner"

                        # Apply folder permissions
                        if ($NewShare) {
                            Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message5' -StringValues (Get-PSFConfigValue -FullName AIPScannerConfig.AIPShare)
                            $Account = (Get-PSFConfigValue -FullName 'AIPScannerConfig.ScannerAccountName')
                            $Acl = (Get-Item $PathCheck).GetAccessControl('Access')
                            
                            if (($Acl.Access | Where-Object { ($_.IdentityReference.Value.Contains($Account.ToUpperInvariant()) -or $_.IdentityReference.Value.Contains($Account)) -and $_.FileSystemRights -eq [System.Security.AccessControl.FileSystemRights]::FullControl }).Count -eq 1) {
                                Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message6' -StringValues $PathCheck
                                return
                            }
                            else {
                                Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message7'ringValues $PathCheck, (Get-PSFConfigValue -FullName AIPScannerConfig.ScannerAccount)
                                $AccessControlRule = New-Object System.Security.AccessControl.FileSystemAccessRule((Get-PSFConfigValue -FullName AIPScannerConfig.ScannerAccountName), "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
                                $Acl.SetAccessRule($AccessControlRule)
                                Set-Acl $PathCheck $Acl
                                Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message8' -StringValues $PathCheck
                            }
                        }
                        else {
                            Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message9' -StringValues $PathCheck
                            return
                        }
                    }
                    else {
                        Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message10' -StringValues $PathCheck
                        return
                    }
                }
                else {
                    Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message11' -StringValues $PathCheck
                    return
                }
            }
            else {
                Write-PSFMessage -Level Verbose -String 'New-AIPFileShare.Message12' -StringValues $PathCheck
                return
            }
        }
        catch {
            Stop-PSFFunction -String 'New-AIPFileShare.Message13' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
            return
        }
    }

    end {
        Write-PSFMessage -Level Host -Message 'New-AIPFileShare.Message14'
    }
}