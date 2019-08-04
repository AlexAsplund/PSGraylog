<#
.SYNOPSIS
    Show sidecars using the given configuration
.DESCRIPTION
    Show sidecars using the given configuration
    

    For more information about this cmdlet - please search for /sidecar/configurations/{id}/sidecars in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSidecarConfigurationsConfigurationSidecars -Id <String>
.NOTES
    Auto generated
#>
function Get-GLSidecarConfigurationsConfigurationSidecars {
    [CmdletBinding()]
    param(
        # Parameter id
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Id,

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
        if (![string]::IsNullOrEmpty($Id)) {
            $Id = [system.web.httputility]::UrlEncode($Id)

            $QueryArray += "id=$Id"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/sidecar/configurations/{id}/sidecars'
        $APIPath = $APIPath -replace "\{Id\}","$Id"
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
