<#
.SYNOPSIS
    Get a list of all alarm callback types
.DESCRIPTION
    Get a list of all alarm callback types
    

    For more information about this cmdlet - please search for /streams/{streamid}/alarmcallbacks/available in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLStreamAlarmCallbacksAvailable -Streamid <String>
.NOTES
    Auto generated
#>
Function Get-GLStreamAlarmCallbacksAvailable {
    [CmdletBinding()]
    Param(
        # The id of the stream whose alarm callbacks we want.
        [Parameter(Mandatory=$True)]
        [String]$Streamid,

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
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/streams/{streamid}/alarmcallbacks/available'
        $APIPath = $APIPath -Replace "\{Streamid\}","$Streamid" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
