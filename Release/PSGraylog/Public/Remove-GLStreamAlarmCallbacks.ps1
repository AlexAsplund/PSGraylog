<#
.SYNOPSIS
    Delete an alarm callback
.DESCRIPTION
    Delete an alarm callback
    

    For more information about this cmdlet - please search for /streams/{streamid}/alarmcallbacks/{alarmCallbackId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLStreamAlarmCallbacks -Streamid <String> -Alarmcallbackid <String>
.NOTES
    Auto generated
#>
Function Remove-GLStreamAlarmCallbacks {
    [CmdletBinding()]
    Param(
        # The stream id this alarm callback belongs to.
        [Parameter(Mandatory=$True)]
        [String]$Streamid,
         # Parameter alarmCallbackId
        [Parameter(Mandatory=$True)]
        [String]$Alarmcallbackid,
 
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
        
        if(![string]::IsNullOrEmpty($Alarmcallbackid)){
        $Alarmcallbackid = [system.web.httputility]::UrlEncode($Alarmcallbackid)
        
        $QueryArray += "alarmCallbackId=$Alarmcallbackid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/streams/{streamid}/alarmcallbacks/{alarmCallbackId}'
        $APIPath = $APIPath -Replace "\{Streamid\}","$Streamid" 
        $APIPath = $APIPath -Replace "\{Alarmcallbackid\}","$Alarmcallbackid" 
        Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential 
    }
    End {}
}
