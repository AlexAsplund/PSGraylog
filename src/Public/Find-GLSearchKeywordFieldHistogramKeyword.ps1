<#
.SYNOPSIS
    Datetime histogram of a query using keyword timerange.
.DESCRIPTION
    Datetime histogram of a query using keyword timerange.


    For more information about this cmdlet - please search for /search/universal/keyword/fieldhistogram in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Find-GLSearchKeywordFieldHistogramKeyword -Query <String> -Field <String> -Interval <String> -Keyword <String> -Filter <String> -Cardinality <Bool>
.NOTES
    Auto generated
#>
function Find-GLSearchKeywordFieldHistogramKeyword {
    [CmdletBinding()]
    param(
        # Query (Lucene syntax)
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Query,
        # Field of whose values to get the histogram of
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Field,
        # Histogram interval / bucket size. (year, quarter, month, week, day, hour or minute)
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Interval,
        # Range keyword
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Keyword,
        # Filter
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Filter,
        # Calculate the cardinality of the field as well
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [bool]$Cardinality,

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
        if (![string]::IsNullOrEmpty($Query)) {
            $Query = [system.web.httputility]::UrlEncode($Query)

            $QueryArray += "query=$Query"
        }

        if (![string]::IsNullOrEmpty($Field)) {
            $Field = [system.web.httputility]::UrlEncode($Field)

            $QueryArray += "field=$Field"
        }

        if (![string]::IsNullOrEmpty($Interval)) {
            $Interval = [system.web.httputility]::UrlEncode($Interval)

            $QueryArray += "interval=$Interval"
        }

        if (![string]::IsNullOrEmpty($Keyword)) {
            $Keyword = [system.web.httputility]::UrlEncode($Keyword)

            $QueryArray += "keyword=$Keyword"
        }

        if (![string]::IsNullOrEmpty($Filter)) {
            $Filter = [system.web.httputility]::UrlEncode($Filter)

            $QueryArray += "filter=$Filter"
        }

        if (![string]::IsNullOrEmpty($Cardinality)) {


            $QueryArray += "cardinality=$Cardinality"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/search/universal/keyword/fieldhistogram'
        $APIPath = $APIPath -replace "\{\}","$"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            if ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                Write-Error -Exception $Error[0].Exception -Message "Invalid timerange parameters provided." -ErrorAction $ErrorActionPreference
            }
            elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                Write-Error -Exception $Error[0].Exception -Message "Invalid interval provided." -ErrorAction $ErrorActionPreference
            }
            elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                Write-Error -Exception $Error[0].Exception -Message "Field is not of numeric type." -ErrorAction $ErrorActionPreference
            }
            else {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
            }

        }


    }
    end {}
}
