<#
.SYNOPSIS
    Get a list of reopened indices, which will not be cleaned by retention cleaning
.DESCRIPTION
    Get a list of reopened indices, which will not be cleaned by retention cleaning
    

    For more information about this cmdlet - please search for /system/indexer/indices/{indexSetId}/reopened in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Open-GLIndexerIndicesIndexReed -Indexsetid <String>
.NOTES
    Auto generated
#>
function Open-GLIndexerIndicesIndexReed {
    [CmdletBinding()]
    param(
        # Parameter indexSetId
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Indexsetid,

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
        if (![string]::IsNullOrEmpty($Indexsetid)) {
            $Indexsetid = [system.web.httputility]::UrlEncode($Indexsetid)

            $QueryArray += "indexSetId=$Indexsetid"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/system/indexer/indices/{indexSetId}/reopened'
        $APIPath = $APIPath -replace "\{Indexsetid\}","$Indexsetid"
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
