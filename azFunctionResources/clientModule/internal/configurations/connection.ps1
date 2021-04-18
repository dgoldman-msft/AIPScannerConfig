﻿Set-PSFConfig -Module 'AIPScannerConfig' -Name 'Client.Uri' -Value $null -Initialize -Validation 'string' -Description "Url to connect to the AIPScannerConfig Azure function"
Set-PSFConfig -Module 'AIPScannerConfig' -Name 'Client.UnprotectedToken' -Value '' -Initialize -Validation 'string' -Description "The unencrypted access token to the AIPScannerConfig Azure function. ONLY use this from secure locations or non-sensitive functions!"
Set-PSFConfig -Module 'AIPScannerConfig' -Name 'Client.ProtectedToken' -Value $null -Initialize -Validation 'credential' -Description "An encrypted access token to the AIPScannerConfig Azure function. Use this to persist an access token in a way only the current user on the current system can access."