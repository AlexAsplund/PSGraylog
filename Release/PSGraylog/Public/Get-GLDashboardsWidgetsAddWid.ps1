<#
.SYNOPSIS
    Add a widget to a dashboard
.DESCRIPTION
    Add a widget to a dashboard
    

    For more information about this cmdlet - please search for /dashboards/{dashboardId}/widgets in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLDashboardsWidgetsAddWid -Dashboardid <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
function Get-GLDashboardsWidgetsAddWid {
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
        if ($PSCmdlet.ShouldProcess($Dashboardid,"Add a widget to a dashboard")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Dashboardid)) {
                $Dashboardid = [system.web.httputility]::UrlEncode($Dashboardid)

                $QueryArray += "dashboardId=$Dashboardid"
            }

            if (![string]::IsNullOrEmpty($Body)) {


                $QueryArray += "JSON body=$Body"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/dashboards/{dashboardId}/widgets'
            $APIPath = $APIPath -replace "\{Dashboardid\}","$Dashboardid"
            try {
                Invoke-RestMethod -Method POST -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json) -ErrorAction Stop
            }
            catch {
                if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                    Write-Error -Exception $Error[0].Exception -Message "Dashboard not found." -ErrorAction $ErrorActionPreference
                }
                elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                    Write-Error -Exception $Error[0].Exception -Message "Validation error." -ErrorAction $ErrorActionPreference
                }
                elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                    Write-Error -Exception $Error[0].Exception -Message "No such widget type." -ErrorAction $ErrorActionPreference
                }
                else {
                    Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
                }

            }

        }
    }
    end {}
}
