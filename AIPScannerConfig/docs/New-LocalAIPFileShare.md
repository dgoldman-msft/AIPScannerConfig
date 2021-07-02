---
external help file: AIPScannerConfig-help.xml
Module Name: AIPScannerConfig
online version:
schema: 2.0.0
---

# New-LocalAIPFileShare

## SYNOPSIS
Create a file share

## SYNTAX

```
New-LocalAIPFileShare [[-folderName] <String>] [[-ShareName] <String>] [-EnableException] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Create a file share for the AIP scanner

## EXAMPLES

### EXAMPLE 1
```
New-LocalAIPFileShare -ComputerName Server01 -FolderName c:\temp -ShareName YourShareName
```

Will create a new file folder and file share called YourShareName at c:\temp on Server01

## PARAMETERS

### -folderName
Folder name of the AIP file share

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: (Get-PSFConfigValue -Fullname AIPScannerConfig.RootFolder)
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShareName
Name of the shared folder

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: (Get-PSFConfigValue -Fullname AIPScannerConfig.AIPShare)
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
https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/create-method-in-class-win32-share?redirectedfrom=MSDN

Create has two rules:
    1.
You must be an administrator on the machine.
    2.
You must Run as administrator the Windows PowerShell console.

## RELATED LINKS
