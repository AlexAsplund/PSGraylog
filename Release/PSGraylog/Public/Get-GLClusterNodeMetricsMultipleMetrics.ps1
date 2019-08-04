<#
.SYNOPSIS
    Get the values of multiple metrics at once from node
.DESCRIPTION
    Get the values of multiple metrics at once from node
    

    For more information about this cmdlet - please search for /cluster/{nodeId}/metrics/multiple in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLClusterNodeMetricsMultipleMetrics -Nodeid <String> -RequestedMetrics <String>
.NOTES
    Auto generated
#>
function Get-GLClusterNodeMetricsMultipleMetrics {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # The id of the node whose metrics we want.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Nodeid,
        # Parameter Requested metrics
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$RequestedMetrics,

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
        if ($PSCmdlet.ShouldProcess($Nodeid,"Get the values of multiple metrics at once from node")) {
            $BodyHash = @{}
            $QueryArray | ForEach-Object {
                $val = $_ -split '='
                $BodyHash[$val[0]] = $val[1]
            }
            $Body = $BodyHash | ConvertTo-Json
            try { Invoke-RestMethod -Method POST -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body $Body -ErrorAction Stop } catch { if ($Error[0].Exception.Response.StatusCode.value__ -eq 400) { Write-Error -Exception $Error[0].Exception -Message "Malformed body" -ErrorAction $ErrorActionPreference } else { Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference } }

        }
    }
    end {}
}
