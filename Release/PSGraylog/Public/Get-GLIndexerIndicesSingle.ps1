<#
.SYNOPSIS
    Get information of an index and its shards.
.DESCRIPTION
    Get information of an index and its shards.
    

    For more information about this cmdlet - please search for /system/indexer/indices/{index} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLIndexerIndicesSingle -Index <String>
.NOTES
    Auto generated
#>
function Get-GLIndexerIndicesSingle {
    [CmdletBinding()]
    param(
        # Parameter index
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Index,

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

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/system/indexer/indices/{index}'
        $APIPath = $APIPath -replace "\{Index\}","$Index"
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
