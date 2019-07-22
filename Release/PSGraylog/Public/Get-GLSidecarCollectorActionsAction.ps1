﻿<#
.SYNOPSIS
    Returns queued actions for the specified Sidecar id
.DESCRIPTION
    Returns queued actions for the specified Sidecar id
    

    For more information about this cmdlet - please search for /sidecar/action/{sidecarId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSidecarCollectorActionsAction -Sidecarid <String>
.NOTES
    Auto generated
#>
Function Get-GLSidecarCollectorActionsAction {
    [CmdletBinding()]
    Param(
        # Parameter sidecarId
        [Parameter(Mandatory=$True)]
        [String]$Sidecarid,

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
        if(![string]::IsNullOrEmpty($Sidecarid)){
        $Sidecarid = [system.web.httputility]::UrlEncode($Sidecarid)
        
        $QueryArray += "sidecarId=$Sidecarid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/sidecar/action/{sidecarId}'
        $APIPath = $APIPath -Replace "\{Sidecarid\}","$Sidecarid" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
