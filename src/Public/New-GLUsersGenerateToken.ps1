<#
.SYNOPSIS
    Generates a new access token for a user
.DESCRIPTION
    Generates a new access token for a user


    For more information about this cmdlet - please search for /users/{username}/tokens/{name} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    New-GLUsersGenerateToken -Username <String> -Name <String> -Body <String>
.NOTES
    Auto generated
#>
function New-GLUsersGenerateToken {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter username
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Username,
        # Descriptive name for this token (e.g. 'cronjob')
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Name,
        # Placeholder because POST requests should have a body. Set to '{}', the content will be ignored.
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Body,

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
        if ($PSCmdlet.ShouldProcess($Username,"Generates a new access token for a user")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Username)) {
                $Username = [system.web.httputility]::UrlEncode($Username)

                $QueryArray += "username=$Username"
            }

            if (![string]::IsNullOrEmpty($Name)) {
                $Name = [system.web.httputility]::UrlEncode($Name)

                $QueryArray += "name=$Name"
            }

            if (![string]::IsNullOrEmpty($Body)) {
                $Body = [system.web.httputility]::UrlEncode($Body)

                $QueryArray += "JSON Body=$Body"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/users/{username}/tokens/{name}'
            $APIPath = $APIPath -replace "\{Username\}","$Username"
            $APIPath = $APIPath -replace "\{Name\}","$Name"
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
