<#
.SYNOPSIS
    Delete the given cache
.DESCRIPTION
    Delete the given cache
    The cache cannot be in use by any lookup table, otherwise the request will fail.

    For more information about this cmdlet - please search for /system/lookup/caches/{idOrName} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLSystemLookupCache -Idorname <String>
.NOTES
    Auto generated
#>
Function Remove-GLSystemLookupCache {
    [CmdletBinding()]
    Param(
        # Parameter idOrName
        [Parameter(Mandatory=$False)]
        [String]$Idorname,

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
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/lookup/caches/{idOrName}'
        $APIPath = $APIPath -Replace "\{Idorname\}","$Idorname" 
        Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential 
    }
    End {}
}
