<#
.SYNOPSIS
    Remove a user from a role
.DESCRIPTION
    Remove a user from a role
    

    For more information about this cmdlet - please search for /roles/{rolename}/members/{username} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLRolesMember -Rolename <String> -Username <String>
.NOTES
    Auto generated
#>
function Remove-GLRolesMember {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter rolename
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Rolename,
        # Parameter username
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
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
        if ($PSCmdlet.ShouldProcess($Rolename,"Remove a user from a role")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Rolename)) {
                $Rolename = [system.web.httputility]::UrlEncode($Rolename)

                $QueryArray += "rolename=$Rolename"
            }

            if (![string]::IsNullOrEmpty($Username)) {
                $Username = [system.web.httputility]::UrlEncode($Username)

                $QueryArray += "username=$Username"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/roles/{rolename}/members/{username}'
            $APIPath = $APIPath -replace "\{Rolename\}","$Rolename"
            $APIPath = $APIPath -replace "\{Username\}","$Username"
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
