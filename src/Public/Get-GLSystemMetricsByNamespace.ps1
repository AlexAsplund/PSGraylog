﻿<#
.SYNOPSIS
    Get all metrics of a namespace
.DESCRIPTION
    Get all metrics of a namespace
    

    For more information about this cmdlet - please search for /system/metrics/namespace/{namespace} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemMetricsByNamespace -Namespace <String>
.NOTES
    Auto generated
#>
Function Get-GLSystemMetricsByNamespace {
    [CmdletBinding()]
    Param(
        # Parameter namespace
        [Parameter(Mandatory=$True)]
        [String]$Namespace,

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
        if(![string]::IsNullOrEmpty($Namespace)){
        $Namespace = [system.web.httputility]::UrlEncode($Namespace)
        
        $QueryArray += "namespace=$Namespace"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/metrics/namespace/{namespace}'
        $APIPath = $APIPath -Replace "\{Namespace\}","$Namespace" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
