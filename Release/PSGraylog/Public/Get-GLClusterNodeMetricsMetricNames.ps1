﻿<#
.SYNOPSIS
    Get all metrics keys/names from node
.DESCRIPTION
    Get all metrics keys/names from node
    

    For more information about this cmdlet - please search for /cluster/{nodeId}/metrics/names in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLClusterNodeMetricsMetricNames -Nodeid <String>
.NOTES
    Auto generated
#>
Function Get-GLClusterNodeMetricsMetricNames {
    [CmdletBinding()]
    Param(
        # The id of the node whose metrics we want.
        [Parameter(Mandatory=$True)]
        [String]$Nodeid,

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
        if(![string]::IsNullOrEmpty($Nodeid)){
        $Nodeid = [system.web.httputility]::UrlEncode($Nodeid)
        
        $QueryArray += "nodeId=$Nodeid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/cluster/{nodeId}/metrics/names'
        $APIPath = $APIPath -Replace "\{Nodeid\}","$Nodeid" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}