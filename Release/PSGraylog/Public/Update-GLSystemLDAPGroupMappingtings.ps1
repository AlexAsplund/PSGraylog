<#
.SYNOPSIS
    Update the LDAP group to Graylog role mapping
.DESCRIPTION
    Update the LDAP group to Graylog role mapping
    Corresponds directly to the output of GET /system/ldap/settings/groups

    For more information about this cmdlet - please search for /system/ldap/settings/groups in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Update-GLSystemLDAPGroupMappingtings -Body <PSCustomObject>
.NOTES
    Auto generated
#>
function Update-GLSystemLDAPGroupMappingtings {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # A hash in which the keys are the LDAP group names and values is the Graylog role name.
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
        if ($PSCmdlet.ShouldProcess($Body,"Update the LDAP group to Graylog role mapping")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Body)) {


                $QueryArray += "JSON body=$Body"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/system/ldap/settings/groups'
            $APIPath = $APIPath -replace "\{\}","$"
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
