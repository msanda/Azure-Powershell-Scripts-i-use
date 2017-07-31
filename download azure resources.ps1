$myResourceGroup = ""
$mySite = ""
#Get App settings
$webApp = Get-AzureRMWebAppSlot -ResourceGroupName $myResourceGroup -Name $mySite -Slot production
$appSettingList = $webApp.SiteConfig.AppSettings


#use App settings on web App
$hash = @{}
ForEach ($kvp in $appSettingList) {
    $hash[$kvp.Name] = $kvp.Value
}

Set-AzureRmWebAppSlot -ResourceGroupName $myResourceGroup -Name $mySite -AppSettings $hash -slot Production