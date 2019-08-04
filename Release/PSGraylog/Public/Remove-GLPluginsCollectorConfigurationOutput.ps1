<#
.SYNOPSIS
    Delete output from configuration
.DESCRIPTION
    Delete output from configuration
    

    For more information about this cmdlet - please search for /plugins/org.graylog.plugins.collector/configurations/{id}/outputs/{outputId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLPluginsCollectorConfigurationOutput -Id <String>
.NOTES
    Auto generated
#>
function Remove-GLPluginsCollectorConfigurationOutput {
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
        if ($PSCmdlet.ShouldProcess($Id,"Delete output from configuration")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Id)) {
                $Id = [system.web.httputility]::UrlEncode($Id)

                $QueryArray += "id=$Id"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/plugins/org.graylog.plugins.collector/configurations/{id}/outputs/{outputId}'
            $APIPath = $APIPath -replace "\{Id\}","$Id"
            $APIPath = $APIPath -replace "\{Outputid\}","$Outputid"
            try {
                Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -ErrorAction Stop
            }
            catch {
                if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                    Write-Error -Exception $Error[0].Exception -Message "Configuration or Output not found." -ErrorAction $ErrorActionPreference
                }
                elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                    Write-Error -Exception $Error[0].Exception -Message "Invalid ObjectId." -ErrorAction $ErrorActionPreference
                }
                elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 412) {
                    Write-Error -Exception $Error[0].Exception -Message "Still inputs assigned to output" -ErrorAction $ErrorActionPreference
                }
                else {
                    Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
                }

            }

        }
    }
    end {}
}
