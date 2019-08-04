<#
.SYNOPSIS
    Revoke all permissions for a user without deleting the account.
.DESCRIPTION
    Revoke all permissions for a user without deleting the account.
    

    For more information about this cmdlet - please search for /users/{username}/permissions in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLUsersPermissions -Username <String>
.NOTES
    Auto generated
#>
function Remove-GLUsersPermissions {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # The name of the user to modify.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Username,

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
        if ($PSCmdlet.ShouldProcess($Username,"Revoke all permissions for a user without deleting the account.")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Username)) {
                $Username = [system.web.httputility]::UrlEncode($Username)

                $QueryArray += "username=$Username"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/users/{username}/permissions'
            $APIPath = $APIPath -replace "\{Username\}","$Username"
            try {
                Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -ErrorAction Stop
            }
            catch {
                if ($Error[0].Exception.Response.StatusCode.value__ -eq 500) {
                    Write-Error -Exception $Error[0].Exception -Message "When saving the user failed." -ErrorAction $ErrorActionPreference
                }
                else {
                    Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
                }

            }

        }
    }
    end {}
}
