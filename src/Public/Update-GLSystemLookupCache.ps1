<#
.SYNOPSIS
    Update the given cache settings
.DESCRIPTION
    Update the given cache settings
    

    For more information about this cmdlet - please search for /system/lookup/caches/{idOrName} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Update-GLSystemLookupCache -Idorname <String> -Body <String>
.NOTES
    Auto generated
#>
function Update-GLSystemLookupCache {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter idOrName
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Idorname,
        # Parameter JSON Body
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Body,

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
        if ($PSCmdlet.ShouldProcess($Idorname,"Update the given cache settings")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Idorname)) {
                $Idorname = [system.web.httputility]::UrlEncode($Idorname)

                $QueryArray += "idOrName=$Idorname"
            }

            if (![string]::IsNullOrEmpty($Body)) {
                $Body = [system.web.httputility]::UrlEncode($Body)

                $QueryArray += "JSON Body=$Body"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/system/lookup/caches/{idOrName}'
            $APIPath = $APIPath -replace "\{Idorname\}","$Idorname"
            try {
                Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json) -ErrorAction Stop
            }
            catch {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference

            }

        }
    }
    end {}
}
