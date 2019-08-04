<#
.SYNOPSIS
    Set the loglevel of a single logger
.DESCRIPTION
    Set the loglevel of a single logger
    Provided level is falling back to DEBUG if it does not exist

    For more information about this cmdlet - please search for /system/loggers/{loggerName}/level/{level} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Set-GLSystemLoggersSingleLoggerLevel -Loggername <String> -Level <String>
.NOTES
    Auto generated
#>
function Set-GLSystemLoggersSingleLoggerLevel {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter loggerName
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Loggername,
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
        if ($PSCmdlet.ShouldProcess($Loggername,"Set the loglevel of a single logger")) {
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
