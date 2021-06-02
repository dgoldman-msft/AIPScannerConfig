---
external help file: AIPScannerConfig-help.xml
Module Name: AIPScannerConfig
online version:
schema: 2.0.0
---

# New-AIPRepository

## SYNOPSIS
Add an AIP repository

## SYNTAX

### FileShare
```
New-AIPRepository [[-Path] <String>] [-FileShare] [-VerifyRepository] [<CommonParameters>]
```

### Create
```
New-AIPRepository [-CreateShareOnSharePoint] [-VerifyRepository] [<CommonParameters>]
```

## DESCRIPTION
This method will add an AIP repository

## EXAMPLES

### EXAMPLE 1
```
New-AIPRepository -Path \\fileserver\documents
```

This will create a repository on a local fileshare or server

### EXAMPLE 2
```
New-AIPRepository -CreateShareOnSharePoint
```

This will create a repository on a SharePoint server

### EXAMPLE 3
```
New-AIPRepository -VerifyRepository
```

This will verify the AIP repositories

## PARAMETERS

### -Path
Path to local file sahre

```yaml
Type: String
Parameter Sets: FileShare
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -CreateShareOnSharePoint
Switch to indicate we are creating on a SharePoint share

```yaml
Type: SwitchParameter
Parameter Sets: Create
Aliases:

Required: False
Position: 1
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileShare
File share used for the AIP Repository

```yaml
Type: SwitchParameter
Parameter Sets: FileShare
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -VerifyRepository
Switched use to force a search for repositories instead of creating one

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Object
## NOTES
None

## RELATED LINKS
