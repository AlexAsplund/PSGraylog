<#
.SYNOPSIS
    Create a decorator
.DESCRIPTION
    Create a decorator


    For more information about this cmdlet - please search for /search/decorators/{decoratorId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLSearchDecorators -DecoratorId <String>
.NOTES
    Auto generated
#>
function Remove-GLSearchDecorators {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter decorator id
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$DecoratorId,

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
        if ($PSCmdlet.ShouldProcess($DecoratorId,"Create a decorator")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($DecoratorId)) {
                $DecoratorId = [system.web.httputility]::UrlEncode($DecoratorId)

                $QueryArray += "decorator id=$DecoratorId"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/search/decorators/{decoratorId}'
            $APIPath = $APIPath -replace "\{Decoratorid\}","$Decoratorid"
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
