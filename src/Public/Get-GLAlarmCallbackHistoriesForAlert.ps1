<#
.SYNOPSIS
    Get a list of all alarm callbacks for this stream
.DESCRIPTION
    Get a list of all alarm callbacks for this stream
    

    For more information about this cmdlet - please search for /streams/{streamid}/alerts/{alertId}/history in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLAlarmCallbackHistoriesForAlert -Streamid <String> -Alertid <String>
.NOTES
    Auto generated
#>
Function Get-GLAlarmCallbackHistoriesForAlert {
    [CmdletBinding()]
    Param(
        # The id of the stream whose alarm callbacks history we want.
        [Parameter(Mandatory=$True)]
        [String]$Streamid,
         # The id of the alert whose callback history we want.
        [Parameter(Mandatory=$True)]
        [String]$Alertid,
 
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
        
        if(![string]::IsNullOrEmpty($Alertid)){
        $Alertid = [system.web.httputility]::UrlEncode($Alertid)
        
        $QueryArray += "alertId=$Alertid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/streams/{streamid}/alerts/{alertId}/history'
        $APIPath = $APIPath -Replace "\{Streamid\}","$Streamid" 
        $APIPath = $APIPath -Replace "\{Alertid\}","$Alertid" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
