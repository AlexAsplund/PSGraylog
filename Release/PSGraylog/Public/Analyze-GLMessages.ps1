<#
.SYNOPSIS
    Analyze a message string
.DESCRIPTION
    Analyze a message string
    Returns what tokens/terms a message string (message or full_message) is split to.

    For more information about this cmdlet - please search for /messages/{index}/analyze in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Analyze-GLMessages -Index <String> -Analyzer <String> -String <String>
.NOTES
    Auto generated
#>
function Analyze-GLMessages {
    [CmdletBinding()]
    param(
        # The index the message containing the string is stored in.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Index,
        # The analyzer to use.
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Analyzer,
        # The string to analyze.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$String,

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
        if (![string]::IsNullOrEmpty($Index)) {
            $Index = [system.web.httputility]::UrlEncode($Index)

            $QueryArray += "index=$Index"
        }

        if (![string]::IsNullOrEmpty($Analyzer)) {
            $Analyzer = [system.web.httputility]::UrlEncode($Analyzer)

            $QueryArray += "analyzer=$Analyzer"
        }

        if (![string]::IsNullOrEmpty($String)) {
            $String = [system.web.httputility]::UrlEncode($String)

            $QueryArray += "string=$String"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/messages/{index}/analyze'
        $APIPath = $APIPath -replace "\{Index\}","$Index"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                Write-Error -Exception $Error[0].Exception -Message "Specified index does not exist." -ErrorAction $ErrorActionPreference
            }
            else {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
            }

        }


    }
    end {}
}
