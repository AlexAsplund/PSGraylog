<#
.SYNOPSIS
    Get details about which entities will actually be uninstalled
.DESCRIPTION
    Get details about which entities will actually be uninstalled


    For more information about this cmdlet - please search for /system/content_packs/{contentPackId}/installations/{installationId}/uninstall_details in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemContentPacksUninstallDetails -Contentpackid <String> -Installationid <String>
.NOTES
    Auto generated
#>
function Get-GLSystemContentPacksUninstallDetails {
    [CmdletBinding()]
    param(
        # Content pack ID
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Contentpackid,
        # Installation ID
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Installationid,

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
        if (![string]::IsNullOrEmpty($Contentpackid)) {
            $Contentpackid = [system.web.httputility]::UrlEncode($Contentpackid)

            $QueryArray += "contentPackId=$Contentpackid"
        }

        if (![string]::IsNullOrEmpty($Installationid)) {
            $Installationid = [system.web.httputility]::UrlEncode($Installationid)

            $QueryArray += "installationId=$Installationid"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/system/content_packs/{contentPackId}/installations/{installationId}/uninstall_details'
        $APIPath = $APIPath -replace "\{Contentpackid\}","$Contentpackid"
        $APIPath = $APIPath -replace "\{Installationid\}","$Installationid"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            if ($Error[0].Exception.Response.StatusCode.value__ -eq 500) {
                Write-Error -Exception $Error[0].Exception -Message "Error loading content packs" -ErrorAction $ErrorActionPreference
            }
            else {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
            }

        }


    }
    end {}
}
