﻿<#
.SYNOPSIS
    Remove an alert receiver
.DESCRIPTION
    Remove an alert receiver
    

    For more information about this cmdlet - please search for /streams/{streamId}/alerts/receivers in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLStreamAlertsReceiver -Streamid <String> -Entity <String> -Type <String>
.NOTES
    Auto generated
#>
Function Remove-GLStreamAlertsReceiver {
    [CmdletBinding()]
    Param(
        # The stream id this new alert condition belongs to.
        [Parameter(Mandatory=$True)]
        [String]$Streamid,
         # Name/ID of user or email address to remove from alert receivers.
        [Parameter(Mandatory=$True)]
        [String]$Entity,
         # Type: users or emails
        [Parameter(Mandatory=$True)]
        [String]$Type,
 
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
        
        $QueryArray += "streamId=$Streamid"
    }    
        
        if(![string]::IsNullOrEmpty($Entity)){
        $Entity = [system.web.httputility]::UrlEncode($Entity)
        
        $QueryArray += "entity=$Entity"
    }    
        
        if(![string]::IsNullOrEmpty($Type)){
        $Type = [system.web.httputility]::UrlEncode($Type)
        
        $QueryArray += "type=$Type"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/streams/{streamId}/alerts/receivers'
        $APIPath = $APIPath -Replace "\{Streamid\}","$Streamid" 
        Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential 
    }
    End {}
}
