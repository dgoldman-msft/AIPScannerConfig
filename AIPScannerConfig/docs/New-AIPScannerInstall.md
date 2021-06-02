---
external help file: AIPScannerConfig-help.xml
Module Name: AIPScannerConfig
online version:
schema: 2.0.0
---

# New-AIPScannerInstall

## SYNOPSIS
Install the AIP scanner

## SYNTAX

```
New-AIPScannerInstall [[-Cluster] <String>] [-EnableException] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This will download the latest version of the AIP scanner and install it on the local machine

## EXAMPLES

### EXAMPLE 1
```
New-AIPScannerInstall
```

This will download the AIP scanner and install it on the local system

## PARAMETERS

### -Cluster
Name of the AIP Cluster we are targeting for data collection

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
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

### System.String
## NOTES
Internal function

## RELATED LINKS
