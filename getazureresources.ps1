#change for deployment purposes
#Import-AzurePublishSettingsFile "C:\temp\me.publishsettings"
#login-azurermaccount

$subscription = Get-AzureRmSubscription | Select-Object SubscriptionName

foreach ($sub in $subscription)
{
    Select-AzureRMSubscription -SubscriptionName $sub  | Set-AzureRmContext

    $websitesToSave = "website1", "website2"
    $VMsToSave = "vm1", "vm2"
    $storageAccountsToSave = "storageaccount1"

    cls
    $GetWebSite = Get-AzureRmWebApp -Name "kremlintest" -ResourceGroupName "KremlinApps"

    $AppSettings = $GetWebSite.SiteConfig.AppSettings
    $ConnectionStrings  = $GetWebSite.SiteConfig.ConnectionStrings
#$hash = @{}
#ForEach ($kvp in $appSettingList) {
#    $hash[$kvp.Name] = $kvp.Value
#}

#$hash['NewKey'] = "NewValue"
#$hash['ExistingKey'] = "NewValue"


    ##Export application settings


    $AppSettings.GetEnumerator() | Sort-Object -Property Name -Descending |
    Select-Object -Property @{n='Key';e={$_.Name}},Value |
    #Export-Csv -Path C:\Users\Mak Sanda\appsitebackup\$Site.csv -NoTypeInformation
    Export-Csv -Path "C:\Users\Mak Sanda\appsitebackup\gateway5.csv" -NoTypeInformation

    $AppSettings.GetEnumerator() | Sort-Object -Property Name -Descending |
    Select-Object -Property @{n='Key';e={$_.Name}},Value |
    #Export-Csv -Path C:\Users\Mak Sanda\appsitebackup\$Site.csv -NoTypeInformation
    Export-Csv -Path "C:\Users\Mak Sanda\appsitebackup\gateway5.csv" -NoTypeInformation


    #Get-AzureWebsite | Where {$_.Name -notin $websitesToSave} | Remove-AzureWebsite -Force
    #Get-AzureService | Where {$_.Label -notin $VMsToSave} | Remove-AzureService -Force
    #Get-AzureDisk | Where {$_.AttachedTo -eq $null} | Remove-AzureDisk -DeleteVHD
    #Get-AzureStorageAccount | Where {$_.Label -notin $storageAccountsToSave} | Remove-AzureStorageAccount
    #Get-AzureAffinityGroup | Remove-AzureAffinityGroup
    #Remove-AzureVNetConfig
    }