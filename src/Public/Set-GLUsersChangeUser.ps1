﻿<#
.SYNOPSIS
    Modify user details.
.DESCRIPTION
    Modify user details.
    

    For more information about this cmdlet - please search for /users/{username} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Set-GLUsersChangeUser -Username <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
Function Set-GLUsersChangeUser {
    [CmdletBinding()]
    Param(
        # The name of the user to modify.
        [Parameter(Mandatory=$True)]
        [String]$Username,
         # Updated user information.
        [Parameter(Mandatory=$True)]
        [PSCustomObject]$Body,
 
        # Base url for the API, normally https://<grayloghost>:<port>/api
        [string]$APIUrl = $Global:GLApiUrl,

        # Graylog credentials as username:password or use Convert-GLTokenToCredential for token usage
        [PSCredential]$Credential = $Global:GLCredential
    
    )

    Begin{
        if([string]::IsNullOrEmpty($APIUrl)) {
            Write-Error -ErrorAction Stop -Exception "APIUrl not set" -Message "APIUrl was null or empty, refer to the documentation"
        }
        if($Null -eq $Credential){
            Write-Error -ErrorAction -Exception "Credential not set" -Message "Credential not set - refer to the documentation for help"
        }
    }

    Process {
                
        $QueryArray = @()
        if(![string]::IsNullOrEmpty($Username)){
        $Username = [system.web.httputility]::UrlEncode($Username)
        
        $QueryArray += "username=$Username"
    }    
        
        if(![string]::IsNullOrEmpty($Body)){
        
        
        $QueryArray += "JSON body=$Body"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/users/{username}'
        $APIPath = $APIPath -Replace "\{Username\}","$Username" 
        Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json)
    }
    End {}
}
