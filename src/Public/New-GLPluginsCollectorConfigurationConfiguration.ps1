<#
.SYNOPSIS
    Create new collector configuration
.DESCRIPTION
    Create new collector configuration
    

    For more information about this cmdlet - please search for /plugins/org.graylog.plugins.collector/configurations in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    New-GLPluginsCollectorConfigurationConfiguration -Createdefaults <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
function New-GLPluginsCollectorConfigurationConfiguration {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter createDefaults
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Createdefaults,
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
        if ($PSCmdlet.ShouldProcess($Createdefaults,"Create new collector configuration")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Createdefaults)) {
                $Createdefaults = [system.web.httputility]::UrlEncode($Createdefaults)

                $QueryArray += "createDefaults=$Createdefaults"
            }

            if (![string]::IsNullOrEmpty($Body)) {


                $QueryArray += "JSON body=$Body"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/plugins/org.graylog.plugins.collector/configurations'
            $APIPath = $APIPath -replace "\{\}","$"
            try {
                Invoke-RestMethod -Method POST -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json) -ErrorAction Stop
            }
            catch {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference

            }

        }
    }
    end {}
}
