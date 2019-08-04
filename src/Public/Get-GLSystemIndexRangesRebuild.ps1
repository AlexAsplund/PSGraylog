<#
.SYNOPSIS
    Rebuild/sync index range information.
.DESCRIPTION
    Rebuild/sync index range information.
    This triggers a systemjob that scans every index and stores meta information about what indices contain messages in what timeranges. It atomically overwrites already existing meta information.

    For more information about this cmdlet - please search for /system/indices/ranges/rebuild in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemIndexRangesRebuild 
.NOTES
    Auto generated
#>
function Get-GLSystemIndexRangesRebuild {
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
        if ($PSCmdlet.ShouldProcess("All?","Rebuild/sync index range information.")) {
            $BodyHash = @{}
            $QueryArray | ForEach-Object {
                $val = $_ -split '='
                $BodyHash[$val[0]] = $val[1]
            }
            $Body = $BodyHash | ConvertTo-Json
            try { Invoke-RestMethod -Method POST -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body $Body -ErrorAction Stop } catch { if ($Error[0].Exception.Response.StatusCode.value__ -eq 202) { Write-Error -Exception $Error[0].Exception -Message "Rebuild/sync systemjob triggered." -ErrorAction $ErrorActionPreference } else { Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference } }

        }
    }
    end {}
}
