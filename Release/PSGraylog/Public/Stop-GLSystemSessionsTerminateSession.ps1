<#
.SYNOPSIS
    Terminate an existing session
.DESCRIPTION
    Terminate an existing session
    Destroys the session with the given ID: the equivalent of logging out.

    For more information about this cmdlet - please search for /system/sessions/{sessionId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Stop-GLSystemSessionsTerminateSession -Sessionid <String>
.NOTES
    Auto generated
#>
function Stop-GLSystemSessionsTerminateSession {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter sessionId
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Sessionid,

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
        if ($PSCmdlet.ShouldProcess($Sessionid,"Terminate an existing session")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Sessionid)) {
                $Sessionid = [system.web.httputility]::UrlEncode($Sessionid)

                $QueryArray += "sessionId=$Sessionid"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/system/sessions/{sessionId}'
            $APIPath = $APIPath -replace "\{Sessionid\}","$Sessionid"
            try {
                Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -ErrorAction Stop
            }
            catch {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference

            }

        }
    }
    end {}
}
