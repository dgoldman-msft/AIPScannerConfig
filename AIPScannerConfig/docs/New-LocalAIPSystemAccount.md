---
external help file: AIPScannerConfig-help.xml
Module Name: AIPScannerConfig
online version:
schema: 2.0.0
---

# New-LocalAIPSystemAccount

## SYNOPSIS
Create local AIP Scanner Accounts

## SYNTAX

```
New-LocalAIPSystemAccount [[-AccountName] <String>] [-EnableException] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
This method will create the necessary AIP scanner accounts.

## EXAMPLES

### EXAMPLE 1
```
\ New-AIPSystemAccount -AccountName AIPScanner
```

Executes the creation of the AIPSystem account

## PARAMETERS

### -AccountName
This is the account name for the AIP Scanner account.
The default is "AIPScanner"

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
1.
Service requires Log on locally right and Log on as a service right (the second will be given during scanner service install).
2.
Service account requires Read permissions to each repository for discovery and Read/Write permissions for classification/protection.
3.
The default password is a secure 16 character password.
You will need to change the password if you need to logon to this account

## RELATED LINKS
