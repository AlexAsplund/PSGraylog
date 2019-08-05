<#
.SYNOPSIS
    Query a lookup table
.DESCRIPTION
    Query a lookup table


    For more information about this cmdlet - please search for /system/lookup/tables/{name}/query in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Resolve-GLSystemLookupPerformLookup -Name <String> -Key <String>
.NOTES
    Auto generated
#>
function Resolve-GLSystemLookupPerformLookup {
    [CmdletBinding()]
    param(
        # Parameter name
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Name,
        # Parameter key
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Key,

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
        if (![string]::IsNullOrEmpty($Name)) {
            $Name = [system.web.httputility]::UrlEncode($Name)

            $QueryArray += "name=$Name"
        }

        if (![string]::IsNullOrEmpty($Key)) {
            $Key = [system.web.httputility]::UrlEncode($Key)

            $QueryArray += "key=$Key"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/system/lookup/tables/{name}/query'
        $APIPath = $APIPath -replace "\{Name\}","$Name"
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
