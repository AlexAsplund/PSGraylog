<#
.SYNOPSIS
    Create a new user account.
.DESCRIPTION
    Create a new user account.
    

    For more information about this cmdlet - please search for /users in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    New-GLUsers -Body <PSCustomObject>
.NOTES
    Auto generated
#>
Function New-GLUsers {
    [CmdletBinding()]
    Param(
        # Must contain username, full_name, email, password and a list of permissions.
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
        if(![string]::IsNullOrEmpty($Body)){
        
        
        $QueryArray += "JSON body=$Body"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/users'
        $APIPath = $APIPath -Replace "\{\}","$" 
        Invoke-RestMethod -Method POST -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json)
    }
    End {}
}
