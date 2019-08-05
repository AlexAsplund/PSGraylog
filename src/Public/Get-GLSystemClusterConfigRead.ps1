<#
.SYNOPSIS
    Get configuration settings from database
.DESCRIPTION
    Get configuration settings from database


    For more information about this cmdlet - please search for /system/cluster_config/{configClass} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemClusterConfigRead -Configclass <String>
.NOTES
    Auto generated
#>
function Get-GLSystemClusterConfigRead {
    [CmdletBinding()]
    param(
        # The name of the cluster configuration class
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Configclass,

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
        if (![string]::IsNullOrEmpty($Configclass)) {
            $Configclass = [system.web.httputility]::UrlEncode($Configclass)

            $QueryArray += "configClass=$Configclass"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/system/cluster_config/{configClass}'
        $APIPath = $APIPath -replace "\{Configclass\}","$Configclass"
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
