<#
.SYNOPSIS
    Pauses message processing
.DESCRIPTION
    Pauses message processing
    If the message journal is enabled, incoming messages will be spooled on disk, if it is disabled, you might lose messages from inputs which cannot buffer themselves, like AMQP or Kafka-based inputs.

    For more information about this cmdlet - please search for /system/processing/pause in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Set-GLSystemProcessingPauseProcessing 
.NOTES
    Auto generated
#>
function Set-GLSystemProcessingPauseProcessing {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(

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
        if ($PSCmdlet.ShouldProcess("All?","Pauses message processing")) {
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
