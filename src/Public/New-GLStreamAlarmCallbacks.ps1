﻿<#
.SYNOPSIS
    Create an alarm callback
.DESCRIPTION
    Create an alarm callback
    

    For more information about this cmdlet - please search for /streams/{streamid}/alarmcallbacks in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    New-GLStreamAlarmCallbacks -Streamid <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
Function New-GLStreamAlarmCallbacks {
    [CmdletBinding()]
    Param(
        # The stream id this new alarm callback belongs to.
        [Parameter(Mandatory=$True)]
        [String]$Streamid,
         # Parameter JSON body
        [Parameter(Mandatory=$True)]
        [PSCustomObject]$Body,
 
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
        
        if(![string]::IsNullOrEmpty($Body)){
        
        
        $QueryArray += "JSON body=$Body"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/streams/{streamid}/alarmcallbacks'
        $APIPath = $APIPath -Replace "\{Streamid\}","$Streamid" 
        Invoke-RestMethod -Method POST -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json)
    }
    End {}
}
