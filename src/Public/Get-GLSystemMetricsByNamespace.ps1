<#
.SYNOPSIS
    Get all metrics of a namespace
.DESCRIPTION
    Get all metrics of a namespace


    For more information about this cmdlet - please search for /system/metrics/namespace/{namespace} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemMetricsByNamespace -Namespace <String>
.NOTES
    Auto generated
#>
function Get-GLSystemMetricsByNamespace {
    [CmdletBinding()]
    param(
        # Parameter namespace
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Namespace,

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
        if (![string]::IsNullOrEmpty($Namespace)) {
            $Namespace = [system.web.httputility]::UrlEncode($Namespace)

            $QueryArray += "namespace=$Namespace"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/system/metrics/namespace/{namespace}'
        $APIPath = $APIPath -replace "\{Namespace\}","$Namespace"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                Write-Error -Exception $Error[0].Exception -Message "No such metric namespace" -ErrorAction $ErrorActionPreference
            }
            else {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
            }

        }


    }
    end {}
}
