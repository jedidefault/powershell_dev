##### Exchange Online Connect
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking -AllowClobber
$Userslist = Import-CSV C:\Powershell\bulkimport.csv
#$ErrorActionPreference = SilentlyContinue
##### Functions
function Email
{ 
        If (($Firstname) -and ($Lastname)) 
    {  
        Return $Firstname.SubString(0, 1).ToLower() + $Lastname.ToLower()
    } 
}
    Write-Host $useremail

##### Add Groups
    ForEach ($User in $Userslist)
{
#####

##### Microsoft Group Variables

##### Microsoft 365 Group Variables
    $M365GROUP1 = "GROUP NAME HERE"
    $M365GROUP2 = "GROUP NAME HERE"
    $M365GROUP3 = "GROUP NAME HERE"
    $M365GROUP4 = "GROUP NAME HERE"

##### O365 User CSV Query
    
    $Firstname = $User.firstname
    $Lastname = $User.lastname
    $email = $User.firstname.SubString(0, 1).ToLower() + $User.lastname.ToLower() + "@DOMAIN.COM"

    $M365GROUP1user = $email | Where {$User.GROUP1 -like "Yes"}
    $M365GROUP2user = $email | Where {$User.GROUP2 -like "Yes"}
    $M365GROUP3user = $email | Where {$User.GROUP3 -like "Yes"}
    $M365GROUP4user = $email | Where {$User.GROUP4 -like "Yes"}
    $DISTRIBUTIONGROUPuser = $email | Where {$User.DISTRIBUTIONGROUP -like "Yes"}

    $GROUP1RecipientDetails = Get-Recipient -RecipientTypeDetails groupmailbox -Identity $M365GROUP1
    $GROUP2RecipientDetails = Get-Recipient -RecipientTypeDetails groupmailbox -Identity $M365GROUP2
    $GROUP3RecipientDetails = Get-Recipient -RecipientTypeDetails groupmailbox -Identity $M365GROUP3
    $GROUP4RecipientDetails = Get-Recipient -RecipientTypeDetails groupmailbox -Identity $M365GROUP4

##### Flow to Add Distribution Groups

    Add-DistributionGroupMember -Identity "DISTRIBUTION GROUP NAME" -Member $DISTRIBUTIONGROUPuser

##### Flow to ADD Microsoft 365 Group
    Add-UnifiedGroupLinks –Identity $GROUP1RecipientDetails –LinkType "Members" –Links $M365GROUP1user
    Add-UnifiedGroupLinks –Identity $GROUP2RecipientDetails.Name –LinkType "Members" –Links $M365GROUP2user
    Add-UnifiedGroupLinks –Identity $GROUP3RecipientDetails.Name –LinkType "Members" –Links $M365GROUP3user
    Add-UnifiedGroupLinks –Identity $GROUP4RecipientDetails.Name –LinkType "Members" –Links $M365GROUP4user

    Add-UnifiedGroupLinks –Identity $GROUP1RecipientDetails –LinkType "Subscribers" –Links $M365GROUP1user
    Add-UnifiedGroupLinks –Identity $GROUP2RecipientDetails.Name –LinkType "Subscribers" –Links $M365GROUP2user
    Add-UnifiedGroupLinks –Identity $GROUP3RecipientDetails –LinkType "Subscribers" –Links $M365GROUP3user
    Add-UnifiedGroupLinks –Identity $GROUP4RecipientDetails.Name –LinkType "Subscribers" –Links $M365GROUP4user

}
Remove-PSSession $Session