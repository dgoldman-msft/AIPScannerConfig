---
external help file: AIPScannerConfig-help.xml
Module Name: AIPScannerConfig
online version:
schema: 2.0.0
---

# New-RemoteAIPFileShare

## SYNOPSIS
Create a file share

## SYNTAX

```
New-RemoteAIPFileShare [[-AccountName] <String>] [[-FileServer] <String>] [[-RootFolder] <String>]
 [[-ShareName] <String>] [[-AIPScannerSharedFolderName] <String>] [-EnableException] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Create a file share for the AIP scanner

## EXAMPLES

### EXAMPLE 1
```
New-AIPFileShare -ComputerName Server01 -FolderName c:\temp -ShareName YourShareName
```

Will create a new file folder and file share called YourShareName at c:\temp on Server01

## PARAMETERS

### -AccountName
Account name that will be added to the AIP file share and folder

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: (Get-PSFConfigValue -Fullname AIPScannerConfig.ScannerAccountName)
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileServer
Server to create the AIP file share

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: (Get-PSFConfigValue -Fullname AIPScannerConfig.FileServer)
Accept pipeline input: False
Accept wildcard characters: False
```

### -RootFolder
Drive letter to create folder on (Example: C:\\)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: (Get-PSFConfigValue -Fullname AIPScannerConfig.RootFolder)
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShareName
{{ Fill ShareName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: (Get-PSFConfigValue -Fullname AIPScannerConfig.AIPShare)
Accept pipeline input: False
Accept wildcard characters: False
```

### -AIPScannerSharedFolderName
Name for the SMB shared folder

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: (Get-PSFConfigValue -Fullname AIPScannerConfig.AIPScannerSharedFolderName)
Accept pipeline input: False
Accept wildcard characters: False
```

### -EnableException
Depending on whether $EnableException is true or false it will do the following:
    1.
($True) - Throw a bloody terminating error.
Game over.
    2.
($False) - Write a nice warning about how Foo failed bar, then terminate the function.
The return on the next line will then end the calling function.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Parameter used to validate a run without making changes

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Parameter used to prompt for user confirmation

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean
## NOTES
Create has two rules:
    1.
You must be an administrator on the machine.
    2.
You must Run as administrator the Windows PowerShell console.

## RELATED LINKS
