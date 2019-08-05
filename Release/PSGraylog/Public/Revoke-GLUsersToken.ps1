<#
.SYNOPSIS
    Removes a token for a user
.DESCRIPTION
    Removes a token for a user


    For more information about this cmdlet - please search for /users/{username}/tokens/{token} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Revoke-GLUsersToken -Username <String> -Token <String>
.NOTES
    Auto generated
#>
function Revoke-GLUsersToken {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter username
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Username,
        # Parameter token
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Token,

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
        if ($PSCmdlet.ShouldProcess($Username,"Removes a token for a user")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Username)) {
                $Username = [system.web.httputility]::UrlEncode($Username)

                $QueryArray += "username=$Username"
            }

            if (![string]::IsNullOrEmpty($Token)) {
                $Token = [system.web.httputility]::UrlEncode($Token)

                $QueryArray += "token=$Token"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/users/{username}/tokens/{token}'
            $APIPath = $APIPath -replace "\{Username\}","$Username"
            $APIPath = $APIPath -replace "\{Token\}","$Token"
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
