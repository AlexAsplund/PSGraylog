﻿<#
.SYNOPSIS
    Query a lookup table
.DESCRIPTION
    Query a lookup table
    

    For more information about this cmdlet - please search for /system/lookup/adapters/{name}/query in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Resolve-GLSystemLookupPerformAdapterLookup -Name <String> -Key <String>
.NOTES
    Auto generated
#>
Function Resolve-GLSystemLookupPerformAdapterLookup {
    [CmdletBinding()]
    Param(
        # Parameter name
        [Parameter(Mandatory=$False)]
        [String]$Name,
         # Parameter key
        [Parameter(Mandatory=$False)]
        [String]$Key,
 
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
        if(![string]::IsNullOrEmpty($Name)){
        $Name = [system.web.httputility]::UrlEncode($Name)
        
        $QueryArray += "name=$Name"
    }    
        
        if(![string]::IsNullOrEmpty($Key)){
        $Key = [system.web.httputility]::UrlEncode($Key)
        
        $QueryArray += "key=$Key"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/lookup/adapters/{name}/query'
        $APIPath = $APIPath -Replace "\{Name\}","$Name" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
