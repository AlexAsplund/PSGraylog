<#
.SYNOPSIS
    Reopen a closed index. This will also trigger an index ranges rebuild job.
.DESCRIPTION
    Reopen a closed index. This will also trigger an index ranges rebuild job.


    For more information about this cmdlet - please search for /system/indexer/indices/{index}/reopen in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Open-GLIndexerIndicesRe -Index <String>
.NOTES
    Auto generated
#>
function Open-GLIndexerIndicesRe {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter index
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Index,

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
        if ($PSCmdlet.ShouldProcess($Index,"Reopen a closed index. This will also trigger an index ranges rebuild job.")) {
            $BodyHash = @{}
            $QueryArray | ForEach-Object {
                $val = $_ -split '='
                $BodyHash[$val[0]] = $val[1]
            }
            $Body = $BodyHash | ConvertTo-Json
            try { Invoke-RestMethod -Method POST -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body $Body -ErrorAction Stop } catch { Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference }

        }
    }
    end {}
}
