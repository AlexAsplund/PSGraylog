﻿<#
.SYNOPSIS
    Total count of failed index operations since the given date.
.DESCRIPTION
    Total count of failed index operations since the given date.
    

    For more information about this cmdlet - please search for /system/indexer/failures/count in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Measure-GLIndexerFailuresCount -Since <String>
.NOTES
    Auto generated
#>
Function Measure-GLIndexerFailuresCount {
    [CmdletBinding()]
    Param(
        # ISO8601 date
        [Parameter(Mandatory=$True)]
        [String]$Since,

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
        if(![string]::IsNullOrEmpty($Since)){
        $Since = [system.web.httputility]::UrlEncode($Since)
        
        $QueryArray += "since=$Since"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/indexer/failures/count'
        $APIPath = $APIPath -Replace "\{\}","$" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}