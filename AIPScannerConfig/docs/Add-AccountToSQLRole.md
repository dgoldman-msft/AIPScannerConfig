---
external help file:
Module Name:
online version:
schema: 2.0.0
---

# Add-AccountToSQLRole

## SYNOPSIS
Add APIScanner to SQL Role

## SYNTAX

```
Add-AccountToSQLRole [[-SqlServer] <String>] [[-AccountName] <String>] [-AllInOneInstall] [-EnableException]
 [<CommonParameters>]
```

## DESCRIPTION
This method will add the AIP Scanner account to the SQL dbcreator role

## EXAMPLES

### EXAMPLE 1
```
Add-AccountToSQLRole -UserDefinedSqlInstance "Server01\DatabaseName"
```

User specified Sql instance

### EXAMPLE 2
```
Add-AccountToSQLRole -EnableException
```

Enable full debugging error logging

## PARAMETERS

### -SqlServer
User specified SQL Instance

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: (Get-PSFConfigValue -Fullname AIPScannerConfig.SQLServer)
Accept pipeline input: False
Accept wildcard characters: False
```

### -AccountName
Name of account to add to SQL instance

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: (Get-PSFConfigValue -Fullname AIPScannerConfig.ScannerAccountName)
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllInOneInstall
Switch used to indicate we are working on an non-domain joined machine

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

## NOTES
None

## RELATED LINKS
