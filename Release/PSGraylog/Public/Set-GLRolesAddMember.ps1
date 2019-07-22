<#
.SYNOPSIS
    Add a user to a role
.DESCRIPTION
    Add a user to a role
    

    For more information about this cmdlet - please search for /roles/{rolename}/members/{username} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Set-GLRolesAddMember -Rolename <String> -Username <String> -Body <String>
.NOTES
    Auto generated
#>
Function Set-GLRolesAddMember {
    [CmdletBinding()]
    Param(
        # Parameter rolename
        [Parameter(Mandatory=$False)]
        [String]$Rolename,
         # Parameter username
        [Parameter(Mandatory=$False)]
        [String]$Username,
         # Placeholder because PUT requests should have a body. Set to '{}', the content will be ignored.
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
        if(![string]::IsNullOrEmpty($Rolename)){
        $Rolename = [system.web.httputility]::UrlEncode($Rolename)
        
        $QueryArray += "rolename=$Rolename"
    }    
        
        if(![string]::IsNullOrEmpty($Username)){
        $Username = [system.web.httputility]::UrlEncode($Username)
        
        $QueryArray += "username=$Username"
    }    
        
        if(![string]::IsNullOrEmpty($Body)){
        $Body = [system.web.httputility]::UrlEncode($Body)
        
        $QueryArray += "JSON Body=$Body"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/roles/{rolename}/members/{username}'
        $APIPath = $APIPath -Replace "\{Rolename\}","$Rolename" 
        $APIPath = $APIPath -Replace "\{Username\}","$Username" 
        Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json)
    }
    End {}
}
