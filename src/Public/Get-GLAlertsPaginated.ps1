<#
.SYNOPSIS
    Get alarms of all streams, filtered by specifying limit and offset parameters.
.DESCRIPTION
    Get alarms of all streams, filtered by specifying limit and offset parameters.
    

    For more information about this cmdlet - please search for /streams/alerts/paginated in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLAlertsPaginated -Skip <Int> -Limit <Int> -State <String>
.NOTES
    Auto generated
#>
function Get-GLAlertsPaginated {
    [CmdletBinding()]
    param(
        # The number of elements to skip (offset).
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [int]$Skip,
        # The maximum number of elements to return.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [int]$Limit,
        # Alert state (resolved/unresolved)
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$State,

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
        if (![string]::IsNullOrEmpty($Skip)) {


            $QueryArray += "skip=$Skip"
        }

        if (![string]::IsNullOrEmpty($Limit)) {


            $QueryArray += "limit=$Limit"
        }

        if (![string]::IsNullOrEmpty($State)) {
            $State = [system.web.httputility]::UrlEncode($State)

            $QueryArray += "state=$State"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/streams/alerts/paginated'
        $APIPath = $APIPath -replace "\{\}","$"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            if ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                Write-Error -Exception $Error[0].Exception -Message "Invalid ObjectId." -ErrorAction $ErrorActionPreference
            }
            else {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
            }

        }


    }
    end {}
}
