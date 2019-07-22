<#
.SYNOPSIS
    Update the given cache settings
.DESCRIPTION
    Update the given cache settings
    

    For more information about this cmdlet - please search for /system/lookup/caches/{idOrName} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Update-GLSystemLookupCache -Idorname <String> -Body <String>
.NOTES
    Auto generated
#>
Function Update-GLSystemLookupCache {
    [CmdletBinding()]
    Param(
        # Parameter idOrName
        [Parameter(Mandatory=$False)]
        [String]$Idorname,
         # Parameter JSON Body
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
        if(![string]::IsNullOrEmpty($Idorname)){
        $Idorname = [system.web.httputility]::UrlEncode($Idorname)
        
        $QueryArray += "idOrName=$Idorname"
    }    
        
        if(![string]::IsNullOrEmpty($Body)){
        $Body = [system.web.httputility]::UrlEncode($Body)
        
        $QueryArray += "JSON Body=$Body"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/lookup/caches/{idOrName}'
        $APIPath = $APIPath -Replace "\{Idorname\}","$Idorname" 
        Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json)
    }
    End {}
}
