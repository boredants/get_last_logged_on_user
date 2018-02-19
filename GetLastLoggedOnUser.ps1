$computerName = Read-Host "Enter a computer name (must be a member of the domain)"

$UserLoginTypes = 2,7
Get-WinEvent -ComputerName $computerName -FilterHashtable @{logname='security';ID=4624} |`
 SELECT TimeCreated, @{N='Username'; E={$_.Properties[5].Value}}, @{N='LogonType'; E={$_.Properties[8].Value}} |`
 WHERE {$UserLoginTypes -contains $_.LogonType}  | Sort-Object TimeCreated | Select -last 1
