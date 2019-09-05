<# ****************************************************
Purpose: Automates the process of nslook up on a list of 
         IP addresses pr host names in a csv file
Requires: The input is in csv format
******************************************************** #>

$path = "C:\Users\aulam\Documents\vi report\vi info_v1_pingable_inventory-find correct IP address.csv"


write-host ("Importing file")

$file = import-csv -path $path

$ip_address = "IP_address"
$hostname = "Name"

foreach ($record in $file) {    
            $name = $record.$hostname
            write-host("looking for " + $name)
            try{$record.$ip_address = ([System.Net.Dns]::gethostaddresses($name)).IPAddressToString}
            catch {$record.$ip_address = "Cannot find"} 
}
[pscustomobject]  $file | export-csv $path -NoTypeInformation


function find_hostname_or_ip($records,$lookup_item) {
    foreach ($record in $records) {
        if ($lookup_item -eq $hostname) {
            $address = $record.$ip_address
            $record.$hostname = ([System.Net.Dns]::gethostentry($address)).HostName
        }
        if ($lookup_item -eq $ip_address) {
        
            $name = $record.$hostname
            write-host("looking for " + $name)
            try{$record.$ip_address = ([System.Net.Dns]::gethostaddresses($name)).IPAddressToString}
            catch {$record.$ip_address = "Cannot find"} 
        }
    }
    [pscustomobject]  $file | export-csv $path -NoTypeInformation
}

function find_IP($records) {
    foreach ($record in $records) {    
            $name = $record.$hostname
            write-host("looking for " + $name)
            try{$record.$ip_address = ([System.Net.Dns]::gethostaddresses($name)).IPAddressToString}
            catch {$record.$ip_address = "Cannot find"} 
        
    }
    [pscustomobject]  $file | export-csv $path -NoTypeInformation
}

