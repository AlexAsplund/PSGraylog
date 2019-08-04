<#
.SYNOPSIS
    Pass back rendered collector configuratin
.DESCRIPTION
    Pass back rendered collector configuratin
    This method uploads a collector configuration

    For more information about this cmdlet - please search for /plugins/org.graylog.plugins.collector/collectors/{collectorId}/configuration in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Set-GLPluginsSystemCollectorsUpload -Collectorid <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
function Set-GLPluginsSystemCollectorsUpload {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # The collector id this collector is registering as.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Collectorid,
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
        if ($PSCmdlet.ShouldProcess($Collectorid,"Pass back rendered collector configuratin")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Collectorid)) {
                $Collectorid = [system.web.httputility]::UrlEncode($Collectorid)

                $QueryArray += "collectorId=$Collectorid"
            }

            if (![string]::IsNullOrEmpty($Body)) {


                $QueryArray += "JSON body=$Body"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/plugins/org.graylog.plugins.collector/collectors/{collectorId}/configuration'
            $APIPath = $APIPath -replace "\{Collectorid\}","$Collectorid"
            try {
                Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json) -ErrorAction Stop
            }
            catch {
                if ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                    Write-Error -Exception $Error[0].Exception -Message "The supplied request is not valid." -ErrorAction $ErrorActionPreference
                }
                else {
                    Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
                }

            }

        }
    }
    end {}
}
