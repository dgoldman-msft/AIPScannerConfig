---
external help file: AIPScannerConfig-help.xml
Module Name: AIPScannerConfig
online version:
schema: 2.0.0
---

# New-AzureTenantAccountAndApplication

## SYNOPSIS
Create Azure AIP items

## SYNTAX

```
New-AzureTenantAccountAndApplication [-EnableException] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
This method will create all of the necessary Azure components needed for the AIP scanner to function

## EXAMPLES

### EXAMPLE 1
```
New-AzureTenantAccountAndApplication
```

Start the process for creating the cloud applications and accounts

### EXAMPLE 2
```
New-AzureTenantAccountAndApplication -EnabledException
```

Start the process for creating the cloud applications and accounts with EnabledException turned on

## PARAMETERS

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
Internal function

## RELATED LINKS
