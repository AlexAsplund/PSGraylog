<#
.SYNOPSIS
    Message search with keyword as timerange.
.DESCRIPTION
    Message search with keyword as timerange.
    Search for messages in a timerange defined by a keyword like "yesterday" or "2 weeks ago to wednesday".

    For more information about this cmdlet - please search for /search/universal/keyword in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Find-GLSearchKeywordSearchKeyword -Query <String> -Keyword <String> -Limit <Int> -Offset <Int> -Filter <String> -Fields <String> -Sort <String> -Decorate <Bool>
.NOTES
    Auto generated
#>
function Find-GLSearchKeywordSearchKeyword {
    [CmdletBinding()]
    param(
        # Query (Lucene syntax)
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Query,
        # Range keyword
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Keyword,
        # Maximum number of messages to return.
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [int]$Limit,
        # Offset
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [int]$Offset,
        # Filter
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Filter,
        # Comma separated list of fields to return
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Fields,
        # Sorting (field:asc / field:desc)
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Sort,
        # Run decorators on search result
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [bool]$Decorate,

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

        if (![string]::IsNullOrEmpty($Keyword)) {
            $Keyword = [system.web.httputility]::UrlEncode($Keyword)

            $QueryArray += "keyword=$Keyword"
        }

        if (![string]::IsNullOrEmpty($Limit)) {


            $QueryArray += "limit=$Limit"
        }

        if (![string]::IsNullOrEmpty($Offset)) {


            $QueryArray += "offset=$Offset"
        }

        if (![string]::IsNullOrEmpty($Filter)) {
            $Filter = [system.web.httputility]::UrlEncode($Filter)

            $QueryArray += "filter=$Filter"
        }

        if (![string]::IsNullOrEmpty($Fields)) {
            $Fields = [system.web.httputility]::UrlEncode($Fields)

            $QueryArray += "fields=$Fields"
        }

        if (![string]::IsNullOrEmpty($Sort)) {
            $Sort = [system.web.httputility]::UrlEncode($Sort)

            $QueryArray += "sort=$Sort"
        }

        if (![string]::IsNullOrEmpty($Decorate)) {


            $QueryArray += "decorate=$Decorate"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/search/universal/keyword'
        $APIPath = $APIPath -replace "\{\}","$"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            if ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                Write-Error -Exception $Error[0].Exception -Message "Invalid keyword provided." -ErrorAction $ErrorActionPreference
            }
            else {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
            }

        }


    }
    end {}
}
