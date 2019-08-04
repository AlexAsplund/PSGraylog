<#
.SYNOPSIS
    Update a user's preferences set.
.DESCRIPTION
    Update a user's preferences set.
    

    For more information about this cmdlet - please search for /users/{username}/preferences in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Set-GLUsersSavePreferences -Username <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
function Set-GLUsersSavePreferences {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # The name of the user to modify.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Username,
        # The map of preferences to assign to the user.
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
        if ($PSCmdlet.ShouldProcess($Username,"Update a user's preferences set.")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Username)) {
                $Username = [system.web.httputility]::UrlEncode($Username)

                $QueryArray += "username=$Username"
            }

            if (![string]::IsNullOrEmpty($Body)) {


                $QueryArray += "JSON body=$Body"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/users/{username}/preferences'
            $APIPath = $APIPath -replace "\{Username\}","$Username"
            try {
                Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json) -ErrorAction Stop
            }
            catch {
                if ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                    Write-Error -Exception $Error[0].Exception -Message "Missing or invalid permission data." -ErrorAction $ErrorActionPreference
                }
                else {
                    Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
                }

            }

        }
    }
    end {}
}
