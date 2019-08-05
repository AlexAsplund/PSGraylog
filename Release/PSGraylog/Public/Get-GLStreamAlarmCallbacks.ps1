<#
.SYNOPSIS
    Get a single specified alarm callback for this stream
.DESCRIPTION
    Get a single specified alarm callback for this stream


    For more information about this cmdlet - please search for /streams/{streamid}/alarmcallbacks/{alarmCallbackId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLStreamAlarmCallbacks -Streamid <String> -Alarmcallbackid <String>
.NOTES
    Auto generated
#>
function Get-GLStreamAlarmCallbacks {
    [CmdletBinding()]
    param(
        # The id of the stream whose alarm callbacks we want.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Streamid,
        # The alarm callback id we are getting
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Alarmcallbackid,

        # Base url for the API, normally https://<grayloghost>:<port>/api
        [string]$APIUrl = $Global:GLApiUrl,

        # Graylog credentials as username:password or use Convert-GLTokenToCredential for token usage
        [pscredential]$Credential = $Global:GLCredential

    )

    begin {
        if ([string]::IsNullOrEmpty($APIUrl)) {
            Write-Error -ErrorAction Stop -Exception "APIUrl not set" -Message "APIUrl was null or empty, refer to the documentation"
        }
        if ($Null -eq $Credential) {
            Write-Error -ErrorAction Stop -Exception "Credential not set" -Message "Credential not set - refer to the documentation for help"
        }
    }

    process {

        $QueryArray = @()
        if (![string]::IsNullOrEmpty($Streamid)) {
            $Streamid = [system.web.httputility]::UrlEncode($Streamid)

            $QueryArray += "streamid=$Streamid"
        }

        if (![string]::IsNullOrEmpty($Alarmcallbackid)) {
            $Alarmcallbackid = [system.web.httputility]::UrlEncode($Alarmcallbackid)

            $QueryArray += "alarmCallbackId=$Alarmcallbackid"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/streams/{streamid}/alarmcallbacks/{alarmCallbackId}'
        $APIPath = $APIPath -replace "\{Streamid\}","$Streamid"
        $APIPath = $APIPath -replace "\{Alarmcallbackid\}","$Alarmcallbackid"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference

        }


    }
    end {}
}
