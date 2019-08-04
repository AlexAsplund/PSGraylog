<#
.SYNOPSIS
    Test matching of a stream against a supplied message
.DESCRIPTION
    Test matching of a stream against a supplied message
    

    For more information about this cmdlet - please search for /streams/{streamId}/testMatch in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Test-GLStreamsMatch -Streamid <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
function Test-GLStreamsMatch {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter streamId
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Streamid,
        # Parameter JSON body
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [pscustomobject]$Body,

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
        if ($PSCmdlet.ShouldProcess($Streamid,"Test matching of a stream against a supplied message")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Streamid)) {
                $Streamid = [system.web.httputility]::UrlEncode($Streamid)

                $QueryArray += "streamId=$Streamid"
            }

            if (![string]::IsNullOrEmpty($Body)) {


                $QueryArray += "JSON body=$Body"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/streams/{streamId}/testMatch'
            $APIPath = $APIPath -replace "\{Streamid\}","$Streamid"
            try {
                Invoke-RestMethod -Method POST -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json) -ErrorAction Stop
            }
            catch {
                if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                    Write-Error -Exception $Error[0].Exception -Message "Stream not found." -ErrorAction $ErrorActionPreference
                }
                elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                    Write-Error -Exception $Error[0].Exception -Message "Invalid or missing Stream id." -ErrorAction $ErrorActionPreference
                }
                else {
                    Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
                }

            }

        }
    }
    end {}
}
