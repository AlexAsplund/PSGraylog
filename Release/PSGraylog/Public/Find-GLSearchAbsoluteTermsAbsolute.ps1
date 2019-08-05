<#
.SYNOPSIS
    Most common field terms of a query using an absolute timerange.
.DESCRIPTION
    Most common field terms of a query using an absolute timerange.


    For more information about this cmdlet - please search for /search/universal/absolute/terms in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Find-GLSearchAbsoluteTermsAbsolute -Field <String> -Query <String> -Stacked_Fields <String> -Size <Int> -FromString <DateTime> -ToString <DateTime> -Filter <String> -Order <String>
.NOTES
    Auto generated
#>
function Find-GLSearchAbsoluteTermsAbsolute {
    [CmdletBinding()]
    param(
        # Message field of to return terms of
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Field,
        # Query (Lucene syntax)
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Query,
        # Fields to stack
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Stacked_Fields,
        # Maximum number of terms to return
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [int]$Size,
        # Timerange start. See search method description for date format
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [datetime]$From,
        # Timerange end. See search method description for date format
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [datetime]$To,
        # Filter
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Filter,
        # Sorting (field:asc / field:desc)
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Order,

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
        if (![string]::IsNullOrEmpty($Field)) {
            $Field = [system.web.httputility]::UrlEncode($Field)

            $QueryArray += "field=$Field"
        }

        if (![string]::IsNullOrEmpty($Query)) {
            $Query = [system.web.httputility]::UrlEncode($Query)

            $QueryArray += "query=$Query"
        }

        if (![string]::IsNullOrEmpty($Stacked_Fields)) {
            $Stacked_Fields = [system.web.httputility]::UrlEncode($Stacked_Fields)

            $QueryArray += "stacked_fields=$Stacked_Fields"
        }

        if (![string]::IsNullOrEmpty($Size)) {


            $QueryArray += "size=$Size"
        }

        if (![string]::IsNullOrEmpty($From)) {

            [string]$FromString = $From.ToUniversalTime() | Get-Date -Format 'yyyy-MM-ddTHH:mm:ss.fffZ'
            $QueryArray += "from=$FromString"
        }

        if (![string]::IsNullOrEmpty($To)) {

            [string]$ToString = $To.ToUniversalTime() | Get-Date -Format 'yyyy-MM-ddTHH:mm:ss.fffZ'
            $QueryArray += "to=$ToString"
        }

        if (![string]::IsNullOrEmpty($Filter)) {
            $Filter = [system.web.httputility]::UrlEncode($Filter)

            $QueryArray += "filter=$Filter"
        }

        if (![string]::IsNullOrEmpty($Order)) {
            $Order = [system.web.httputility]::UrlEncode($Order)

            $QueryArray += "order=$Order"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/search/universal/absolute/terms'
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
