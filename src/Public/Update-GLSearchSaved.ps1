<#
.SYNOPSIS
    Update a saved search
.DESCRIPTION
    Update a saved search
    

    For more information about this cmdlet - please search for /search/saved/{searchId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Update-GLSearchSaved -Searchid <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
Function Update-GLSearchSaved {
    [CmdletBinding()]
    Param(
        # Parameter searchId
        [Parameter(Mandatory=$True)]
        [String]$Searchid,
         # Parameter JSON body
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
        if(![string]::IsNullOrEmpty($Searchid)){
        $Searchid = [system.web.httputility]::UrlEncode($Searchid)
        
        $QueryArray += "searchId=$Searchid"
    }    
        
        if(![string]::IsNullOrEmpty($Body)){
        
        
        $QueryArray += "JSON body=$Body"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/search/saved/{searchId}'
        $APIPath = $APIPath -Replace "\{Searchid\}","$Searchid" 
        Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json)
    }
    End {}
}
