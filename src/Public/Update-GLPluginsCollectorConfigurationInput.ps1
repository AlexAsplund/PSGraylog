<#
.SYNOPSIS
    Update a configuration input
.DESCRIPTION
    Update a configuration input
    This is a stateless method which updates a collector input

    For more information about this cmdlet - please search for /plugins/org.graylog.plugins.collector/configurations/{id}/inputs/{input_id} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Update-GLPluginsCollectorConfigurationInput -Id <String> -Input_Id <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
function Update-GLPluginsCollectorConfigurationInput {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter id
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Id,
        # Parameter input_id
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Input_Id,
        # Parameter JSON body
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [pscustomobject]$Body,

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
        if ($PSCmdlet.ShouldProcess($Id,"Update a configuration input")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Id)) {
                $Id = [system.web.httputility]::UrlEncode($Id)

                $QueryArray += "id=$Id"
            }

            if (![string]::IsNullOrEmpty($Input_Id)) {
                $Input_Id = [system.web.httputility]::UrlEncode($Input_Id)

                $QueryArray += "input_id=$Input_Id"
            }

            if (![string]::IsNullOrEmpty($Body)) {


                $QueryArray += "JSON body=$Body"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/plugins/org.graylog.plugins.collector/configurations/{id}/inputs/{input_id}'
            $APIPath = $APIPath -replace "\{Id\}","$Id"
            try {
                Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json) -ErrorAction Stop
            }
            catch {
                if ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                    Write-Error -Exception $Error[0].Exception -Message "The supplied request is not valid." -ErrorAction $ErrorActionPreference
                }
                else {
                    Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
                }

            }

        }
    }
    end {}
}
