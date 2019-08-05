<#
.SYNOPSIS
    Copy a configuration
.DESCRIPTION
    Copy a configuration
    This is a stateless method which copies a collector configuration to one with another name

    For more information about this cmdlet - please search for /plugins/org.graylog.plugins.collector/configurations/{id}/{name} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Copy-GLPluginsCollectorConfigurationConfiguration -Id <String>
.NOTES
    Auto generated
#>
function Copy-GLPluginsCollectorConfigurationConfiguration {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
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
        if ($PSCmdlet.ShouldProcess($Id,"Copy a configuration")) {
            $BodyHash = @{}
            $QueryArray | ForEach-Object {
                $val = $_ -split '='
                $BodyHash[$val[0]] = $val[1]
            }
            $Body = $BodyHash | ConvertTo-Json
            try { Invoke-RestMethod -Method POST -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body $Body -ErrorAction Stop } catch { if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) { Write-Error -Exception $Error[0].Exception -Message "Configuration not found." -ErrorAction $ErrorActionPreference } elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 400) { Write-Error -Exception $Error[0].Exception -Message "Invalid ObjectId." -ErrorAction $ErrorActionPreference } else { Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference } }

        }
    }
    end {}
}
