<#
.SYNOPSIS
    Returns queued actions for the specified collector id
.DESCRIPTION
    Returns queued actions for the specified collector id


    For more information about this cmdlet - please search for /plugins/org.graylog.plugins.collector/collectors/{collectorId}/action in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLPluginsSystemCollectorsAction -Collectorid <String>
.NOTES
    Auto generated
#>
function Get-GLPluginsSystemCollectorsAction {
    [CmdletBinding()]
    param(
        # Parameter collectorId
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Collectorid,

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
        if (![string]::IsNullOrEmpty($Collectorid)) {
            $Collectorid = [system.web.httputility]::UrlEncode($Collectorid)

            $QueryArray += "collectorId=$Collectorid"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/plugins/org.graylog.plugins.collector/collectors/{collectorId}/action'
        $APIPath = $APIPath -replace "\{Collectorid\}","$Collectorid"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                Write-Error -Exception $Error[0].Exception -Message "No actions found for specified id" -ErrorAction $ErrorActionPreference
            }
            else {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
            }

        }


    }
    end {}
}
