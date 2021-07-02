---
external help file: AIPScannerConfig-help.xml
Module Name: AIPScannerConfig
online version:
schema: 2.0.0
---

# Start-PrerequisiteCheck

## SYNOPSIS
Check system prerequisites

## SYNTAX

```
Start-PrerequisiteCheck [[-ComputerName] <Object>] [-SqlRemote] [-AllInOneInstall]
 [[-UserDefinedSqlInstance] <String>] [-SkipNetworkTest] [-EnableException] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
This method will ensure that all prerequisites are in place before the automated configuration

## EXAMPLES

### EXAMPLE 1
```
Start-PrerequisiteCheck -ComputerName Machine01 -Verbose
```

This will start the prerequisite checks

### EXAMPLE 2
```
Start-PrerequisiteCheck -ComputerName Machine01 -SqlRemote -Verbose
```

This will start the prerequisite checks and check for a remote Sql instance

### EXAMPLE 3
```
Start-PrerequisiteCheck -ComputerName Machine01 -EnableException
```

This will change the termination when we encounter an error

## PARAMETERS

### -ComputerName
Computer name we are running against

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: (Get-PSFConfigValue -Fullname AIPScannerConfig.ComputerName)
Accept pipeline input: False
Accept wildcard characters: False
```

### -SqlRemote
Switch to check for remote SQL instnaces

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

### -UserDefinedSqlInstance
User specified SQL Instance

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

### -SkipNetworkTest
Skips the network test - used for lab testing

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

## NOTES

The prerequisites below are still required for successful AIP scanner installation.

1. A Windows Server 2012 R2 or 2016 Server to run the service with a minimum 4 CPU and 4GB RAM physical or virtual

>NOTE:  The scanner will allocate RAM 2.5-3 times of size of all files being scanned in parallel. Thus, if you scan 40 files that are 20MB each at the same time, it should take about 202.540=2GB RAM. However, if you have one big 1GB file it can take 3GB of RAM just for that file.

Connectivity

NOTE: A SQL Server 2012+ local or remote instance (Any version from Express or better is supported)
Sysadmin role needed to install scanner service (user running Install-AIPScanner, not the service account)

NOTE: If using SQL Server Express, the SQL Instance name is ServerName\SQLExpress.

NOTE: At this time, a different SQL instance is needed for each AIP Scanner node.

Service account created in On Premises AD (I will call this account AIPScanner in this document).
Service requires Log on locally right and Log on as a service right (the second will be given during scanner service install).
Service account requires Read permissions to each repository for discovery and Read/Write permissions for classification/protection.
AzInfoProtection.exe available on the Microsoft Download Center (The scanner bits are included with the AIP Client)

For more information on the logging system and PSFramework: https://psframework.org/documentation/documents/psframework/logging/loggingto/debuglog.html

## RELATED LINKS
