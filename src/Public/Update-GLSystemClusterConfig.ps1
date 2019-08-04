<#
.SYNOPSIS
    Update configuration in database
.DESCRIPTION
    Update configuration in database
    

    For more information about this cmdlet - please search for /system/cluster_config/{configClass} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Update-GLSystemClusterConfig -Configclass <String> -Body <String>
.NOTES
    Auto generated
#>
function Update-GLSystemClusterConfig {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # The name of the cluster configuration class
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Configclass,
        # The payload of the cluster configuration
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
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
        if ($PSCmdlet.ShouldProcess($Configclass,"Update configuration in database")) {
            $BodyHash = @{}
            $QueryArray | ForEach-Object {
                $val = $_ -split '='
                $BodyHash[$val[0]] = $val[1]
            }
            $Body = $BodyHash | ConvertTo-Json
            try { Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body $Body -ErrorAction Stop } catch { Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference }

        }
    }
    end {}
}
