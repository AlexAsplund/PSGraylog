<#
.SYNOPSIS
    Get an alert condition
.DESCRIPTION
    Get an alert condition


    For more information about this cmdlet - please search for /streams/{streamId}/alerts/conditions/{conditionId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLStreamAlertConditions -Streamid <String> -Conditionid <String>
.NOTES
    Auto generated
#>
function Get-GLStreamAlertConditions {
    [CmdletBinding()]
    param(
        # The stream id this alert condition belongs to.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Streamid,
        # The alert condition id to be fetched
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Conditionid,

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

        if (![string]::IsNullOrEmpty($Conditionid)) {
            $Conditionid = [system.web.httputility]::UrlEncode($Conditionid)

            $QueryArray += "conditionId=$Conditionid"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/streams/{streamId}/alerts/conditions/{conditionId}'
        $APIPath = $APIPath -replace "\{Streamid\}","$Streamid"
        $APIPath = $APIPath -replace "\{Conditionid\}","$Conditionid"
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
