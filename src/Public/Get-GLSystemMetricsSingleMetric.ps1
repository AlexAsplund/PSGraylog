<#
.SYNOPSIS
    Get a single metric
.DESCRIPTION
    Get a single metric


    For more information about this cmdlet - please search for /system/metrics/{metricName} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemMetricsSingleMetric -Metricname <String>
.NOTES
    Auto generated
#>
function Get-GLSystemMetricsSingleMetric {
    [CmdletBinding()]
    param(
        # Parameter metricName
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Metricname,

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

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/system/metrics/{metricName}'
        $APIPath = $APIPath -replace "\{Metricname\}","$Metricname"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                Write-Error -Exception $Error[0].Exception -Message "No such metric" -ErrorAction $ErrorActionPreference
            }
            else {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
            }

        }


    }
    end {}
}
