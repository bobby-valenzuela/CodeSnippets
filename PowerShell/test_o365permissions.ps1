# Use this to test connecting to ExchangeOnline and MicrosoftGraph via PowerShell

Function Test-O365Permissions {

    [CmdletBinding()]
    param (
    
        [Parameter(Mandatory=$true,HelpMessage="Organization Name defined in Microsoft (Example: myorganization.onmicrosoft.com)")] 
        [string]$OrganizationName,
    
        [Parameter(Mandatory=$true,HelpMessage="Tenant ID as defined in Azure (not to be confused with application id).")] 
        [string]$TenantId,
    
        [Parameter(Mandatory=$true,HelpMessage="Application ID ('ClientID in Azure')")] 
        [string]$ApplicationId,
    
        [Parameter(Mandatory=$true,HelpMessage="Application Secret saved in your Application Credentials")] 
        [string]$ApplicationSecret
    
    )

    BEGIN { 
        

    }
    PROCESS {  

        Write-Host "`nRunning for " -NoNewline
        Write-Host -BackgroundColor White -ForegroundColor Black "$OrganizationName `n" 

        Write-Host "1) Attempting to connect to Exchange Online...(validates appid and certificate on the app and verified that correct roles and permissions were applied in Azure)" 
        try{
            $ConfirmPreference = 'None'# By pass any 'Y\N' prompts
            Connect-ExchangeOnline -CertificateFilePath "C:\Probax2\probaxsaasmodernapponlycertificate.pfx" -CertificatePassword (ConvertTo-SecureString -String "123" -AsPlainText -Force) -AppID "$ApplicationId" -Organization "$OrganizationName" -ShowBanner:$false > $null 

            Write-Host -ForegroundColor White -BackgroundColor Green -NoNewline "[SUCCESS]"
            Write-Host -ForegroundColor DarkGreen -BackgroundColor White " Connected to Exchange Online! Appid and certificate on the app VALIDATED."
            Disconnect-ExchangeOnline > $null
        }
        catch{
            Write-Host -ForegroundColor White -BackgroundColor DarkRed -NoNewline "`t[ERROR]"
            Write-Host -ForegroundColor DarkRed -BackgroundColor White " Could not connected to Exchange Online. Appid and certificate on the app INVALID."
            Write-Host -NoNewline "`n`t"
            Write-Host $_
        }



        Write-Host "`n`n2) Attempting to connect to Microsoft Graph via API...(validates that app secret is applied to proper app, and that tenant id is valid)" 
        # Get an access token for Graph API
        $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
        $headers.Add("Content-Type", "application/x-www-form-urlencoded")
        $body = "client_id=$ApplicationId&grant_type=client_credentials&scope=https%3A%2F%2Fgraph.microsoft.com%2F.default&client_secret=$ApplicationSecret"

        try{
            $response = Invoke-RestMethod "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token" -Method 'POST' -Headers $headers -Body $body
        
            # If we get a response - we should get an access token and should be able to run the rest of these commands
            $access_token_reponse = $response | ConvertTo-Json | ConvertFrom-Json | Select-Object access_token
            $access_token = $access_token_reponse.access_token 

            Write-Host -ForegroundColor White -BackgroundColor Green -NoNewline "[SUCCESS]"
            Write-Host -ForegroundColor DarkGreen -BackgroundColor White " Connected to Graph via API! App secret and tenantid VALIDATED."

            # Write-Host "AccessToken: $access_token`n"
            # Connect-MgGraph -AccessToken $access_token

        }
        catch{
            Write-Host -ForegroundColor White -BackgroundColor DarkRed -NoNewline "`t[ERROR]"
            Write-Host -ForegroundColor DarkRed -BackgroundColor White " Could not to Graph via API! App secret or tenantid INVALID."
            Write-Host -NoNewline "`n`t"
            Write-Host $_

        }


    }        
    END { 


        
    }
    
    
    }
