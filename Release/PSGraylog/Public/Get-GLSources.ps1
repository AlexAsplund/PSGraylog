﻿<#
.SYNOPSIS
    Get a list of all sources (not more than 5000) that have messages in the current indices. The result is cached for 10 seconds.
.DESCRIPTION
    Get a list of all sources (not more than 5000) that have messages in the current indices. The result is cached for 10 seconds.
    Range: The parameter is in seconds relative to the current time. 86400 means 'in the last day',0 is special and means 'across all indices'

    For more information about this cmdlet - please search for /sources in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSources -Range <Int> -Size <Int>
.NOTES
    Auto generated
#>
Function Get-GLSources {
    [CmdletBinding()]
    Param(
        # Relative timeframe to search in. See method description.
        [Parameter(Mandatory=$True)]
        [Int]$Range,
         # Maximum size of the result set.
        [Parameter(Mandatory=$False)]
        [Int]$Size,
 
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
        if(![string]::IsNullOrEmpty($Range)){
        
        
        $QueryArray += "range=$Range"
    }    
        
        if(![string]::IsNullOrEmpty($Size)){
        
        
        $QueryArray += "size=$Size"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/sources'
        $APIPath = $APIPath -Replace "\{\}","$" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
