<#
.SYNOPSIS
    Add a user to a role
.DESCRIPTION
    Add a user to a role
    

    For more information about this cmdlet - please search for /roles/{rolename}/members/{username} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Set-GLRolesAddMember -Rolename <String> -Username <String> -Body <String>
.NOTES
    Auto generated
#>
function Set-GLRolesAddMember {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter rolename
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Rolename,
        # Parameter username
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Username,
        # Placeholder because PUT requests should have a body. Set to '{}', the content will be ignored.
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
        if ($PSCmdlet.ShouldProcess($Rolename,"Add a user to a role")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Rolename)) {
                $Rolename = [system.web.httputility]::UrlEncode($Rolename)

                $QueryArray += "rolename=$Rolename"
            }

            if (![string]::IsNullOrEmpty($Username)) {
                $Username = [system.web.httputility]::UrlEncode($Username)

                $QueryArray += "username=$Username"
            }

            if (![string]::IsNullOrEmpty($Body)) {
                $Body = [system.web.httputility]::UrlEncode($Body)

                $QueryArray += "JSON Body=$Body"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/roles/{rolename}/members/{username}'
            $APIPath = $APIPath -replace "\{Rolename\}","$Rolename"
            $APIPath = $APIPath -replace "\{Username\}","$Username"
            try {
                Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json) -ErrorAction Stop
            }
            catch {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference

            }

        }
    }
    end {}
}
