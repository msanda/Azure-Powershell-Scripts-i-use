# Activate Azure Powershell module
Import-Module Azure
 
# Subscription and Service Principal information
$SubscriptionId = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
$AzureTenantId = 'yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy' # TenantId of above subscription
$ServiceUri = 'https://resmanapi.klemmestad.com' # Unique Id of a Service Principal you must create
$ServicePassword = 'A Very Secret Password.' # The password of the Service Principal
$Password = ConvertTo-SecureString $ServicePassword -AsPlainText -Force
 
# Authentication
$AuthenticationCreds = New-object Microsoft.IdentityModel.Clients.ActiveDirectory.ClientCredential($ServiceUri,$Password)
 
$AuthenticationUri = 'https://login.windows.net/{0}' -f $AzureTenantId
$authenticationContext = New-Object Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationContext($AuthenticationUri,$false)
 
$resource = 'https://management.core.windows.net/'
$authenticationResult = $authenticationContext.AcquireToken($resource, $AuthenticationCreds)
 
$ResHeaders = @{'authorization' = $authenticationResult.CreateAuthorizationHeader()}
$ApiVersion = '2015-06-01-preview'
$OfferDurableId = 'MS-AZR-0111p' # Azure on Open
$Currency = 'NOK'
$Locale = 'nb-no'
$RegionInfo = 'NO'
$ResourceCard = "https://management.azure.com/subscriptions/{5}/providers/Microsoft.Commerce/RateCard?api-version={0}&`$filter=OfferDurableId eq '{1}' and Currency eq '{2}' and Locale eq '{3}' and RegionInfo eq '{4}'" -f $ApiVersion, $OfferDurableId, $Currency, $Locale, $RegionInfo, $SubscriptionId
 
$File = $env:TEMP + '\resourcecard.json'
Invoke-RestMethod -Uri $ResourceCard -Headers $ResHeaders -ContentType 'application/json' -OutFile $File
$Resources = Get-Content -Raw -Path $File -Encoding UTF8 | ConvertFrom-Json
 
Remove-Item -Force -Path $File
 
# Display result
$Resources.Meters | Out-GridView