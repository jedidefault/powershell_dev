    ##### Import active directory module for running AD cmdlets
Import-Module activedirectory

    ##### GLOBAL VARIABLES
       $ErrorActionPreference = 'SilentlyContinue'

    ##### FUNCTIONS 
function Username
{
        If (($Firstname) -and ($Lastname)) 
    {  
        Return $Firstname.SubString(0, 1).ToLower() + $Lastname.ToLower()
    } 
}
Write-Host $userflast

    #####Store the data from ADUsers.csv in the $ADUsers variable
        $ADUsers = Import-csv C:\Powershell\bulkimport.csv

    ##### Loop through each row containing user details in the CSV file 

foreach ($User in $ADUsers) 
    {
    
	##### Read user data from each field in each row and assign the data to a variable as below
	##### BLOCK VARIABLES	
	    #$Username 	   = Username
	    $Username2	   = $User.firstname + $User.lastname
	    $Password 	   = $User.password
	    $Firstname 	   = $User.firstname
	    $Lastname 	   = $User.lastname
	    $OU 		   = "CLIENT OU"
        $streetaddress = "ADDRESS"
        $city          = "New York"
        $zipcode       = "10001"
        $state         = "NY"
        $country       = "US"
    	$jobtitle      = $User.jobtitle
    	$department    = $User.department
        $Firstname 	    = $User.firstname
        $Lastname 	    = $User.lastname
        $userflast      = Username
        $ErrorActionPreference = 'SilentlyContinue'
  
    ##### User Account Checking
        $usercheck     = Get-ADUser -F {SamAccountName -eq $userflast}

	##### Check to see if the user already exists in AD
	if ($usercheck)
	{
        New-ADUser `
            -SamAccountName $Username2 `
            -UserPrincipalName "$Username2@ADDOMAIN.com" `
            -Name "$Firstname $Lastname" `
            -GivenName $Firstname `
            -Surname $Lastname `
            -Enabled $True `
            -DisplayName "$Lastname, $Firstname" `
            -Path $OU `
            -City $city `
            -Company $company `
            -State $state `
            -StreetAddress $streetaddress `
            -OfficePhone $telephone `
            -Title $jobtitle `
            -Department $department `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force) -ChangePasswordAtLogon $false   
	}
    else
    {
        New-ADUser `
            -SamAccountName $userflast `
            -UserPrincipalName "$userflast@ADDDOMAIN.com" `
            -Name "$Firstname $Lastname" `
            -GivenName $Firstname `
            -Surname $Lastname `
            -Enabled $True `
            -DisplayName "$Lastname, $Firstname" `
            -Path $OU `
            -City $city `
            -Company $company `
            -State $state `
            -StreetAddress $streetaddress `
            -OfficePhone $telephone `
            -Title $jobtitle `
            -Department $department `
            -AccountPassword (convertto-securestring $Password -AsPlainText -Force) -ChangePasswordAtLogon $false  
    }
}