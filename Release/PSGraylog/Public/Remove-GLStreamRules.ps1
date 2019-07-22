﻿<#
.SYNOPSIS
    Delete a stream rule
.DESCRIPTION
    Delete a stream rule
    

    For more information about this cmdlet - please search for /streams/{streamid}/rules/{streamRuleId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLStreamRules -Streamid <String> -Streamruleid <String>
.NOTES
    Auto generated
#>
Function Remove-GLStreamRules {
    [CmdletBinding()]
    Param(
        # The stream id this new rule belongs to.
        [Parameter(Mandatory=$True)]
        [String]$Streamid,
         # Parameter streamRuleId
        [Parameter(Mandatory=$True)]
        [String]$Streamruleid,
 
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
        if(![string]::IsNullOrEmpty($Streamid)){
        $Streamid = [system.web.httputility]::UrlEncode($Streamid)
        
        $QueryArray += "streamid=$Streamid"
    }    
        
        if(![string]::IsNullOrEmpty($Streamruleid)){
        $Streamruleid = [system.web.httputility]::UrlEncode($Streamruleid)
        
        $QueryArray += "streamRuleId=$Streamruleid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/streams/{streamid}/rules/{streamRuleId}'
        $APIPath = $APIPath -Replace "\{Streamid\}","$Streamid" 
        $APIPath = $APIPath -Replace "\{Streamruleid\}","$Streamruleid" 
        Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential 
    }
    End {}
}
