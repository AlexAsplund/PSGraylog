<#
.SYNOPSIS
    Update a stream rule
.DESCRIPTION
    Update a stream rule
    

    For more information about this cmdlet - please search for /streams/{streamid}/rules/{streamRuleId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Update-GLStreamRules -Streamid <String> -Streamruleid <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
function Update-GLStreamRules {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # The stream id this rule belongs to.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Streamid,
        # The stream rule id we are updating
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Streamruleid,
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
        if ($PSCmdlet.ShouldProcess($Streamid,"Update a stream rule")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Streamid)) {
                $Streamid = [system.web.httputility]::UrlEncode($Streamid)

                $QueryArray += "streamid=$Streamid"
            }

            if (![string]::IsNullOrEmpty($Streamruleid)) {
                $Streamruleid = [system.web.httputility]::UrlEncode($Streamruleid)

                $QueryArray += "streamRuleId=$Streamruleid"
            }

            if (![string]::IsNullOrEmpty($Body)) {


                $QueryArray += "JSON body=$Body"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/streams/{streamid}/rules/{streamRuleId}'
            $APIPath = $APIPath -replace "\{Streamid\}","$Streamid"
            $APIPath = $APIPath -replace "\{Streamruleid\}","$Streamruleid"
            try {
                Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json) -ErrorAction Stop
            }
            catch {
                if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                    Write-Error -Exception $Error[0].Exception -Message "Stream or stream rule not found." -ErrorAction $ErrorActionPreference
                }
                elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                    Write-Error -Exception $Error[0].Exception -Message "Invalid JSON Body." -ErrorAction $ErrorActionPreference
                }
                else {
                    Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
                }

            }

        }
    }
    end {}
}
