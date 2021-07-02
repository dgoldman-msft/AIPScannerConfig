﻿function New-RemoteAIPFileShare {
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
        Create has two rules:
            1. You must be an administrator on the machine.
            2. You must Run as administrator the Windows PowerShell console.
    #>

    [CmdletBinding(SupportsShouldProcess)]
    [OutputType([System.Boolean])]
    param (
        [string]
        $AccountName = (Get-PSFConfigValue -Fullname AIPScannerConfig.ScannerAccountName),

        [string]
        $FileServer = (Get-PSFConfigValue -Fullname AIPScannerConfig.FileServer),

        [string]
        $RootFolder = (Get-PSFConfigValue -Fullname AIPScannerConfig.RootFolder),

        [string]
        $ShareName = (Get-PSFConfigValue -Fullname AIPScannerConfig.AIPShare),

        [string]
        $AIPScannerSharedFolderName = (Get-PSFConfigValue -Fullname AIPScannerConfig.AIPScannerSharedFolderName),
        
        [switch]
        $EnableException
    )

    begin {
        Write-PSFMessage -Level Host -String 'New-RemoteAIPFileShare.Message1'
    }

    process {
        try {
            Write-PSFMessage -Level Host -String 'New-RemoteAIPFileShare.Message2' -StringValues $FileServer
            Invoke-Command -ComputerName $FileServer -ScriptBlock { param ($RootFolder, $ShareName, $AIPScannerSharedFolderName, $AccountName)
                if ( New-Item -Path ([string]::Format("{0}{1}", $RootFolder, $ShareName)) -ItemType Directory -ErrorAction SilentlyContinue -ErrorVariable Failed ) {
                    Write-PSFMessage -Level Host -String 'New-RemoteAIPFileShare.Message3' -StringValues $ShareName, $FileServer
                
                    Write-PSFMessage -Level Host -String 'New-RemoteAIPFileShare.Message4' -StringValues $ShareName, $FileServer
                    $NewAcl = Get-Acl -Path ([string]::Format("{0}{1}", $RootFolder, $ShareName))
                    
                    # Set properties
                    $identity = ([string]::Format("{0}\{1}", $env:USERDOMAIN, $AccountName))
                    $fileSystemRights = "FullControl"
                    $type = "Allow"
                    
                    # Create new rule
                    $fileSystemAccessRuleArgumentList = $identity, $fileSystemRights, $type
                    $fileSystemAccessRule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $fileSystemAccessRuleArgumentList
                    
                    # Apply new rule
                    $NewAcl.SetAccessRule($fileSystemAccessRule)
                    Set-Acl -Path ([string]::Format("{0}{1}", $RootFolder, $ShareName)) -AclObject $NewAcl
                    Write-PSFMessage -Level Host -String 'New-RemoteAIPFileShare.Message5' -StringValues $ShareName, $FileServer
                }
                else { if ($Failed) { Write-PSFMessage -Level Host -String 'New-RemoteAIPFileShare.Message6' -StringValues $Failed } }
                
                Write-PSFMessage -Level Host -String 'New-RemoteAIPFileShare.Message7' -StringValues $ShareName, $FileServer
                if ( New-SMBShare -Name $AIPScannerSharedFolderName -Path ([string]::Format("{0}{1}", $RootFolder, $ShareName)) -FullAccess ([string]::Format("{0}\{1}", $env:USERDOMAIN, $AccountName)) -Description "AIP Folder Share" -FolderEnumerationMode AccessBased -ErrorAction SilentlyContinue -ErrorVariable Failed ) {
                    Write-PSFMessage -Level Host -String 'New-RemoteAIPFileShare.Message8' -StringValues $ShareName, $FileServer
                }
                else { if ($Failed) { Write-PSFMessage -Level Host -String 'New-RemoteAIPFileShare.Message9' -StringValues $Failed } }

                Write-PSFMessage -Level Host -String 'New-RemoteAIPFileShare.Message10' -StringValues $ShareName, $FileServer
                $null = Grant-SmbShareAccess -Name AIPScannerShareFolder -AccountName ([string]::Format("{0}\{1}", $env:USERDOMAIN, $AccountName)) -AccessRight Full -Force
            } -ArgumentList $RootFolder, $ShareName, $AIPScannerSharedFolderName, $AccountName
        }
        catch {
            Stop-PSFFunction -String 'AIP scanner file share creation completed' -EnableException $EnableException -Cmdlet $PSCmdlet -ErrorRecord $_
        }
    }

    end {
        Write-PSFMessage -Level Host -String 'New-RemoteAIPFileShare.Message18' -StringValues $pathCheck
    }
}

