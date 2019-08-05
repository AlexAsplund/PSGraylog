<#
.SYNOPSIS
    Get history of a single metric
.DESCRIPTION
    Get history of a single metric
    The maximum retention time is currently only 5 minutes.

    For more information about this cmdlet - please search for /system/metrics/{metricName}/history in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemMetricsHistoryHistoricSingleMetric -Metricname <String> -After <String>
.NOTES
    Auto generated
#>
function Get-GLSystemMetricsHistoryHistoricSingleMetric {
    [CmdletBinding()]
    param(
        # Parameter metricName
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Metricname,
        # Only values for after this UTC timestamp (1970 epoch)
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$After,

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
        if (![string]::IsNullOrEmpty($Metricname)) {
            $Metricname = [system.web.httputility]::UrlEncode($Metricname)

            $QueryArray += "metricName=$Metricname"
        }

        if (![string]::IsNullOrEmpty($After)) {
            $After = [system.web.httputility]::UrlEncode($After)

            $QueryArray += "after=$After"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/system/metrics/{metricName}/history'
        $APIPath = $APIPath -replace "\{Metricname\}","$Metricname"
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
