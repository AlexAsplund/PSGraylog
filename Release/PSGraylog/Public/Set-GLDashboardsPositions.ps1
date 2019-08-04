<#
.SYNOPSIS
    Update/set the positions of dashboard widgets.
.DESCRIPTION
    Update/set the positions of dashboard widgets.
    

    For more information about this cmdlet - please search for /dashboards/{dashboardId}/positions in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Set-GLDashboardsPositions -Dashboardid <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
function Set-GLDashboardsPositions {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter dashboardId
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Dashboardid,
        # Parameter JSON body
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
        if ($PSCmdlet.ShouldProcess($Dashboardid,"Update/set the positions of dashboard widgets.")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Dashboardid)) {
                $Dashboardid = [system.web.httputility]::UrlEncode($Dashboardid)

                $QueryArray += "dashboardId=$Dashboardid"
            }

            if (![string]::IsNullOrEmpty($Body)) {


                $QueryArray += "JSON body=$Body"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/dashboards/{dashboardId}/positions'
            $APIPath = $APIPath -replace "\{Dashboardid\}","$Dashboardid"
            try {
                Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json) -ErrorAction Stop
            }
            catch {
                if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                    Write-Error -Exception $Error[0].Exception -Message "Dashboard not found." -ErrorAction $ErrorActionPreference
                }
                else {
                    Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
                }

            }

        }
    }
    end {}
}
