---
external help file: AIPScannerConfig-help.xml
Module Name: AIPScannerConfig
online version:
schema: 2.0.0
---

# Get-AIPAuthToken

## SYNOPSIS
Obtain an authentication token

## SYNTAX

```
Get-AIPAuthToken [[-AppId] <String>] [[-AppSecret] <String>] [[-TenantId] <String>] [-UnifiedLabelingClient]
 [-EnableException] [<CommonParameters>]
```

## DESCRIPTION
This method obtain an authentication token for the local session or cloud account for unattened access to the Azure Log workspace for the AIP scanner

## EXAMPLES

### EXAMPLE 1
```
Get-AIPAuthToken
```

Generate a local authentication token

### EXAMPLE 2
```
Get-AIPAuthToken -UnifiedLabelingClient
```

Generate an unatended authentication token

## PARAMETERS

### -AppId
AIP Scanner tenant application id

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

### -AppSecret
AIP Scanner tenant application secret key

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TenantId
Azure tenant ID

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UnifiedLabelingClient
Switch for generating an unattended authentication token for the Unified Labeling Client

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean
## NOTES
None

## RELATED LINKS
