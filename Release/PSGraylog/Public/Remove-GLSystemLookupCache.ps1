<#
.SYNOPSIS
    Delete the given cache
.DESCRIPTION
    Delete the given cache
    The cache cannot be in use by any lookup table, otherwise the request will fail.

    For more information about this cmdlet - please search for /system/lookup/caches/{idOrName} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLSystemLookupCache -Idorname <String>
.NOTES
    Auto generated
#>
function Remove-GLSystemLookupCache {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter idOrName
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Idorname,

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
        if ($PSCmdlet.ShouldProcess($Idorname,"Delete the given cache")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Idorname)) {
                $Idorname = [system.web.httputility]::UrlEncode($Idorname)

                $QueryArray += "idOrName=$Idorname"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/system/lookup/caches/{idOrName}'
            $APIPath = $APIPath -replace "\{Idorname\}","$Idorname"
            try {
                Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -ErrorAction Stop
            }
            catch {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference

            }

        }
    }
    end {}
}
