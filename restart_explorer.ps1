 (Get-Process | ? { $_.ProcessName -eq "explorer" } | Stop-Process ) 
 Start-Process explorer