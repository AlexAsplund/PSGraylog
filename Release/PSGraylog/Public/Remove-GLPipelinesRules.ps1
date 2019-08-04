<#
.SYNOPSIS
    Delete a processing rule
.DESCRIPTION
    Delete a processing rule
    It can take up to a second until the change is applied

    For more information about this cmdlet - please search for /system/pipelines/rule/{id} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLPipelinesRules -Id <String>
.NOTES
    Auto generated
#>
function Remove-GLPipelinesRules {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter id
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
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
        if ($PSCmdlet.ShouldProcess($Id,"Delete a processing rule")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Id)) {
                $Id = [system.web.httputility]::UrlEncode($Id)

                $QueryArray += "id=$Id"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/system/pipelines/rule/{id}'
            $APIPath = $APIPath -replace "\{Id\}","$Id"
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
