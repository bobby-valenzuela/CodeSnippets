### Restart WSL
```powershell
Restart-Service LxssManager
Restart-Service wslService
```

### Restart Windows Explorer

<br />

__Using Command Prompt_
```cmd 
taskkill /F /IM explorer.exe & start explorer
```

__Restart Using Powershell (v5.1)__
```powershell
Stop-Process explorer
Start-Process explorer
```
  <br />
   
__Restart Using Powershell (v7)__
```powershell
Stop-Process explorer && Start-Process explorer
```

  <br />
  
__Find Process and stop - Powershell (v5.1)__
```powershell
Get-Process | ? { $_.ProcessName -Like "*lorer" } | Stop-Process
```
