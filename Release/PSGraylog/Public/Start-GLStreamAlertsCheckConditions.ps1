<#
.SYNOPSIS
    Check for triggered alert conditions of this streams. Results cached for 30 seconds.
.DESCRIPTION
    Check for triggered alert conditions of this streams. Results cached for 30 seconds.
    

    For more information about this cmdlet - please search for /streams/{streamId}/alerts/check in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Start-GLStreamAlertsCheckConditions -Streamid <String>
.NOTES
    Auto generated
#>
function Start-GLStreamAlertsCheckConditions {
    [CmdletBinding()]
    param(
        # The ID of the stream to check.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Streamid,

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

            $QueryArray += "streamId=$Streamid"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/streams/{streamId}/alerts/check'
        $APIPath = $APIPath -replace "\{Streamid\}","$Streamid"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                Write-Error -Exception $Error[0].Exception -Message "Stream not found." -ErrorAction $ErrorActionPreference
            }
            elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                Write-Error -Exception $Error[0].Exception -Message "Invalid ObjectId." -ErrorAction $ErrorActionPreference
            }
            else {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
            }

        }


    }
    end {}
}
