﻿<#
.SYNOPSIS
    Show JSON schema for configuration of given retention strategies
.DESCRIPTION
    Show JSON schema for configuration of given retention strategies
    This resource returns a JSON schema for the configuration of the given retention strategy.

    For more information about this cmdlet - please search for /system/indices/retention/strategies/{strategy} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemIndicesRetentionConfigSchema -Strategy <String>
.NOTES
    Auto generated
#>
Function Get-GLSystemIndicesRetentionConfigSchema {
    [CmdletBinding()]
    Param(
        # The name of the retention strategy
        [Parameter(Mandatory=$True)]
        [String]$Strategy,

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
        if(![string]::IsNullOrEmpty($Strategy)){
        $Strategy = [system.web.httputility]::UrlEncode($Strategy)
        
        $QueryArray += "strategy=$Strategy"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/indices/retention/strategies/{strategy}'
        $APIPath = $APIPath -Replace "\{Strategy\}","$Strategy" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}