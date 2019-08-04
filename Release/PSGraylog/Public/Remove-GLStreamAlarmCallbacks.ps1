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
function Remove-GLStreamAlarmCallbacks {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # The stream id this alarm callback belongs to.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Streamid,
        # Parameter alarmCallbackId
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
        if ($PSCmdlet.ShouldProcess($Streamid,"Delete an alarm callback")) {
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
            try {
                Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -ErrorAction Stop
            }
            catch {
                if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                    Write-Error -Exception $Error[0].Exception -Message "Alarm callback not found." -ErrorAction $ErrorActionPreference
                }
                elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                    Write-Error -Exception $Error[0].Exception -Message "Invalid ObjectId." -ErrorAction $ErrorActionPreference
                }
                else {
                    Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
                }

            }

        }
    }
    end {}
}
