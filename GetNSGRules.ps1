
#az login #(Uncomment If you need to login)
#$DebugPreference = "Continue"
$subs = Get-AzSubscription

foreach ($sub in $subs) 
    {
    Set-AzContext -Subscription $sub.Id
    Write-Output $sub.Id
    Write-Output "==============================="
    $nsgs = Get-AzNetworkSecurityGroup
    #Write-Output $sub.Name
    Foreach ($nsg in $nsgs) {
        Write-Output $nsgs.Name
         
        $nsgRules = $nsg.SecurityRules

     foreach ($nsgRule in $nsgRules) {  
    $nsgRule | Select-Object @{n='NsgID';e={$nsg.Id}},
    @{n='SubscriptionName';e={$sub.Name}},
    @{n='ResourceGroupName';e={$nsg.ResourceGroupName}},
    @{n='NetworkSecurityGroupName';e={$nsg.Name}},
    @{n='AssociatedWith';e={$nsg.AssociatedWith}},
    Name,Description,Priority, 
    @{Name='SourceAddressPrefix';Expression={[string]::join(",", ($_.SourceAddressPrefix))}},
    @{Name='SourcePortRange';Expression={[string]::join(",", ($_.SourcePortRange))}},
    @{Name='DestinationAddressPrefix';Expression={[string]::join(",", ($_.DestinationAddressPrefix))}},
    @{Name='DestinationPortRange';Expression={[string]::join(",", ($_.DestinationPortRange))}},
    Protocol,Access,Direction |
        Export-Csv /Users/aamanakh/Desktop/AR00410_10022.csv -NoTypeInformation -Encoding ASCII -Append   


            }
        }
        
    }

å