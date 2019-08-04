<#
.SYNOPSIS
    Retrieve permissions for a single role
.DESCRIPTION
    Retrieve permissions for a single role
    

    For more information about this cmdlet - please search for /roles/{rolename} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLRolesRead -Rolename <String>
.NOTES
    Auto generated
#>
function Get-GLRolesRead {
    [CmdletBinding()]
    param(
        # Parameter rolename
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Rolename,

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

        $QueryArray = @()
        if (![string]::IsNullOrEmpty($Rolename)) {
            $Rolename = [system.web.httputility]::UrlEncode($Rolename)

            $QueryArray += "rolename=$Rolename"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/roles/{rolename}'
        $APIPath = $APIPath -replace "\{Rolename\}","$Rolename"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference

        }


    }
    end {}
}
