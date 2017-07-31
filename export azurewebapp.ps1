#get all resource group name
$temp = Get-AzureRmResource

foreach ($resource in $temp){
    if ($resource.ResourceType -eq "Microsoft.Web/sites")
    {
        #Write-Host $resource.Name 
        Export-AzureRmResourceGroup -ResourceGroupName $resource.ResourceGroupName -IncludeParameterDefaultValue 
        $jsonfilename = $resource.ResourceGroupName + "_sitename_" + $resource.Name  +".json"
        (Get-AzureRmWebApp -ResourceGroupName $resource.ResourceGroupName -Name $resource.Name).SiteConfig.AppSettings | ConvertTo-Json | Out-File $jsonfilename
        
    }

}