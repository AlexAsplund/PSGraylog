<#
.SYNOPSIS
    Add an alert receiver
.DESCRIPTION
    Add an alert receiver
    

    For more information about this cmdlet - please search for /streams/{streamId}/alerts/receivers in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Add-GLStreamAlertsReceiver -Streamid <String> -Entity <String> -Type <String>
.NOTES
    Auto generated
#>
function Add-GLStreamAlertsReceiver {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # The stream id this new alert condition belongs to.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Streamid,
        # Name/ID of user or email address to add as alert receiver.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Entity,
        # Type: users or emails
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Type,

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
        if ($PSCmdlet.ShouldProcess($Streamid,"Add an alert receiver")) {
            $BodyHash = @{}
            $QueryArray | ForEach-Object {
                $val = $_ -split '='
                $BodyHash[$val[0]] = $val[1]
            }
            $Body = $BodyHash | ConvertTo-Json
            try { Invoke-RestMethod -Method POST -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body $Body -ErrorAction Stop } catch { if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) { Write-Error -Exception $Error[0].Exception -Message "Stream not found." -ErrorAction $ErrorActionPreference } elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 400) { Write-Error -Exception $Error[0].Exception -Message "Invalid ObjectId." -ErrorAction $ErrorActionPreference } elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 400) { Write-Error -Exception $Error[0].Exception -Message "Stream has no email alarm callbacks." -ErrorAction $ErrorActionPreference } else { Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference } }

        }
    }
    end {}
}
