<#
.SYNOPSIS
    Show JSON schema for configuration of given retention strategies
.DESCRIPTION
    Show JSON schema for configuration of given retention strategies
    This resource returns a JSON schema for the configuration of the given retention strategy.

    For more information about this cmdlet - please search for /system/indices/retention/strategies/{strategy} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemIndicesRetentionConfigSchema -Strategy <String>
.NOTES
    Auto generated
#>
function Get-GLSystemIndicesRetentionConfigSchema {
    [CmdletBinding()]
    param(
        # The name of the retention strategy
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Strategy,

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
        if (![string]::IsNullOrEmpty($Strategy)) {
            $Strategy = [system.web.httputility]::UrlEncode($Strategy)

            $QueryArray += "strategy=$Strategy"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/system/indices/retention/strategies/{strategy}'
        $APIPath = $APIPath -replace "\{Strategy\}","$Strategy"
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
