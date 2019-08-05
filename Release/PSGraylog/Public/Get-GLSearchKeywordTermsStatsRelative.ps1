<#
.SYNOPSIS
    Ordered field terms of a query computed on another field using a keyword timerange.
.DESCRIPTION
    Ordered field terms of a query computed on another field using a keyword timerange.


    For more information about this cmdlet - please search for /search/universal/keyword/termsstats in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSearchKeywordTermsStatsRelative -Key_Field <String> -Value_Field <String> -Order <String> -Query <String> -Size <Int> -Keyword <String> -Filter <String>
.NOTES
    Auto generated
#>
function Get-GLSearchKeywordTermsStatsRelative {
    [CmdletBinding()]
    param(
        # Message field of to return terms of
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Key_Field,
        # Value field used for computation
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Value_Field,
        # What to order on (Allowed values: TERM, REVERSE_TERM, COUNT, REVERSE_COUNT, TOTAL, REVERSE_TOTAL, MIN, REVERSE_MIN, MAX, REVERSE_MAX, MEAN, REVERSE_MEAN)
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Order,
        # Query (Lucene syntax)
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Query,
        # Maximum number of terms to return
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [int]$Size,
        # Keyword timeframe
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Keyword,
        # Filter
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Filter,

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
        if (![string]::IsNullOrEmpty($Key_Field)) {
            $Key_Field = [system.web.httputility]::UrlEncode($Key_Field)

            $QueryArray += "key_field=$Key_Field"
        }

        if (![string]::IsNullOrEmpty($Value_Field)) {
            $Value_Field = [system.web.httputility]::UrlEncode($Value_Field)

            $QueryArray += "value_field=$Value_Field"
        }

        if (![string]::IsNullOrEmpty($Order)) {
            $Order = [system.web.httputility]::UrlEncode($Order)

            $QueryArray += "order=$Order"
        }

        if (![string]::IsNullOrEmpty($Query)) {
            $Query = [system.web.httputility]::UrlEncode($Query)

            $QueryArray += "query=$Query"
        }

        if (![string]::IsNullOrEmpty($Size)) {


            $QueryArray += "size=$Size"
        }

        if (![string]::IsNullOrEmpty($Keyword)) {
            $Keyword = [system.web.httputility]::UrlEncode($Keyword)

            $QueryArray += "keyword=$Keyword"
        }

        if (![string]::IsNullOrEmpty($Filter)) {
            $Filter = [system.web.httputility]::UrlEncode($Filter)

            $QueryArray += "filter=$Filter"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/search/universal/keyword/termsstats'
        $APIPath = $APIPath -replace "\{\}","$"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            if ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                Write-Error -Exception $Error[0].Exception -Message "Invalid timerange parameters provided." -ErrorAction $ErrorActionPreference
            }
            else {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
            }

        }


    }
    end {}
}
