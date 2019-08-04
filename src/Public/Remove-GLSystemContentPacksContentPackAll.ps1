<#
.SYNOPSIS
    Delete all revisions of a content pack
.DESCRIPTION
    Delete all revisions of a content pack
    

    For more information about this cmdlet - please search for /system/content_packs/{contentPackId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLSystemContentPacksContentPackAll -Contentpackid <String>
.NOTES
    Auto generated
#>
function Remove-GLSystemContentPacksContentPackAll {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Content Pack ID
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Contentpackid,

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
        if ($PSCmdlet.ShouldProcess($Contentpackid,"Delete all revisions of a content pack")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Contentpackid)) {
                $Contentpackid = [system.web.httputility]::UrlEncode($Contentpackid)

                $QueryArray += "contentPackId=$Contentpackid"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/system/content_packs/{contentPackId}'
            $APIPath = $APIPath -replace "\{Contentpackid\}","$Contentpackid"
            try {
                Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -ErrorAction Stop
            }
            catch {
                if ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                    Write-Error -Exception $Error[0].Exception -Message "Missing or invalid content pack" -ErrorAction $ErrorActionPreference
                }
                elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 500) {
                    Write-Error -Exception $Error[0].Exception -Message "Error while saving content pack" -ErrorAction $ErrorActionPreference
                }
                else {
                    Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
                }

            }

        }
    }
    end {}
}

