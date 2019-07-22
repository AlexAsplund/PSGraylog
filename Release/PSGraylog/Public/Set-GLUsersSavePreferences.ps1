<#
.SYNOPSIS
    Update a user's preferences set.
.DESCRIPTION
    Update a user's preferences set.
    

    For more information about this cmdlet - please search for /users/{username}/preferences in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Set-GLUsersSavePreferences -Username <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
Function Set-GLUsersSavePreferences {
    [CmdletBinding()]
    Param(
        # The name of the user to modify.
        [Parameter(Mandatory=$True)]
        [String]$Username,
         # The map of preferences to assign to the user.
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
        $APIPath = '/users/{username}/preferences'
        $APIPath = $APIPath -Replace "\{Username\}","$Username" 
        Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json)
    }
    End {}
}
