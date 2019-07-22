<#
.SYNOPSIS
    Generates a new access token for a user
.DESCRIPTION
    Generates a new access token for a user
    

    For more information about this cmdlet - please search for /users/{username}/tokens/{name} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    New-GLUsersGenerateToken -Username <String> -Name <String> -Body <String>
.NOTES
    Auto generated
#>
Function New-GLUsersGenerateToken {
    [CmdletBinding()]
    Param(
        # Parameter username
        [Parameter(Mandatory=$True)]
        [String]$Username,
         # Descriptive name for this token (e.g. 'cronjob') 
        [Parameter(Mandatory=$True)]
        [String]$Name,
         # Placeholder because POST requests should have a body. Set to '{}', the content will be ignored.
        [Parameter(Mandatory=$False)]
        [String]$Body,
 
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
        
        if(![string]::IsNullOrEmpty($Name)){
        $Name = [system.web.httputility]::UrlEncode($Name)
        
        $QueryArray += "name=$Name"
    }    
        
        if(![string]::IsNullOrEmpty($Body)){
        $Body = [system.web.httputility]::UrlEncode($Body)
        
        $QueryArray += "JSON Body=$Body"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/users/{username}/tokens/{name}'
        $APIPath = $APIPath -Replace "\{Username\}","$Username" 
        $APIPath = $APIPath -Replace "\{Name\}","$Name" 
        Invoke-RestMethod -Method POST -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json)
    }
    End {}
}
