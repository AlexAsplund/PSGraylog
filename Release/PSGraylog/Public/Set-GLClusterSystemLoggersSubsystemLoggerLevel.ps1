<#
.SYNOPSIS
    Set the loglevel of a whole subsystem
.DESCRIPTION
    Set the loglevel of a whole subsystem
    Provided level is falling back to DEBUG if it does not exist

    For more information about this cmdlet - please search for /cluster/system/loggers/{nodeId}/subsystems/{subsystem}/level/{level} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Set-GLClusterSystemLoggersSubsystemLoggerLevel -Nodeid <String> -Subsystem <String> -Level <String>
.NOTES
    Auto generated
#>
function Set-GLClusterSystemLoggersSubsystemLoggerLevel {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter nodeId
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Nodeid,
        # Parameter subsystem
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Subsystem,
        # Parameter level
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Level,

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
        if ($PSCmdlet.ShouldProcess($Nodeid,"Set the loglevel of a whole subsystem")) {
            $BodyHash = @{}
            $QueryArray | ForEach-Object {
                $val = $_ -split '='
                $BodyHash[$val[0]] = $val[1]
            }
            $Body = $BodyHash | ConvertTo-Json
            try { Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body $Body -ErrorAction Stop } catch { if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) { Write-Error -Exception $Error[0].Exception -Message "No such subsystem." -ErrorAction $ErrorActionPreference } else { Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference } }

        }
    }
    end {}
}
