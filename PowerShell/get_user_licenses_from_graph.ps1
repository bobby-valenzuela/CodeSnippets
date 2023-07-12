# Init
# A non-interactive script to gets the Microsoft licenses of an organization given some provided details.



# This command is useful for finding MSGraph commands based on a search string: Find-MgGraphCommand -Uri ".*users.*" -Method 'Get' -ApiVersion 'v1.0'

$azure_tenant_id = '<AZURE_TENANT_ID>'
$application_secret = 'APPLICATION_SECRET'
$application_id = '<CLIENT_ID>'

# Get an access token for Graph API
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/x-www-form-urlencoded")
$body = "client_id=$application_id&grant_type=client_credentials&scope=https%3A%2F%2Fgraph.microsoft.com%2F.default&client_secret=$application_secret"
$response = Invoke-RestMethod "https://login.microsoftonline.com/$azure_tenant_id/oauth2/v2.0/token" -Method 'POST' -Headers $headers -Body $body
$access_token_reponse = $response | ConvertTo-Json | ConvertFrom-Json | Select-Object access_token
$access_token = $access_token_reponse.access_token 

Write-Host $access_token

Connect-MgGraph -AccessToken $access_token

# Object for demonstration
$NewCSVObject = @{}

$users = (Get-MgUser).ForEach( {$_.UserPrincipalName} )

foreach ($user in $users)  
{  
    
    $license = (Get-MgUserLicenseDetail -UserId "$user").SkuPartNumber   
    $NewCSVObject += @{ "$user"= "$license" }
    
    [PSCustomObject]@{
        Email = $user
        License = [string]$license
    } | Export-Csv -Path licenseoutput.csv -NoTypeInformation -append
    
}  

$NewCSVObject

Disconnect-MgGraph
