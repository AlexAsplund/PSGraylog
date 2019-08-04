<#
.SYNOPSIS
    Total count of failed index operations since the given date.
.DESCRIPTION
    Total count of failed index operations since the given date.
    

    For more information about this cmdlet - please search for /system/indexer/failures/count in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Measure-GLIndexerFailuresCount -Since <String>
.NOTES
    Auto generated
#>
function Measure-GLIndexerFailuresCount {
    [CmdletBinding()]
    param(
        # ISO8601 date
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Since,

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
        if (![string]::IsNullOrEmpty($Since)) {
            $Since = [system.web.httputility]::UrlEncode($Since)

            $QueryArray += "since=$Since"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/system/indexer/failures/count'
        $APIPath = $APIPath -replace "\{\}","$"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            if ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                Write-Error -Exception $Error[0].Exception -Message "Invalid date parameter provided." -ErrorAction $ErrorActionPreference
            }
            else {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
            }

        }


    }
    end {}
}
