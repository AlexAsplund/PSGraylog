<#
.SYNOPSIS
    Update description of a widget
.DESCRIPTION
    Update description of a widget
    

    For more information about this cmdlet - please search for /dashboards/{dashboardId}/widgets/{widgetId}/description in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Update-GLDashboardsWidgetsDescription -Dashboardid <String> -Widgetid <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
function Update-GLDashboardsWidgetsDescription {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter dashboardId
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Dashboardid,
        # Parameter widgetId
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Widgetid,
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
        if ($PSCmdlet.ShouldProcess($Dashboardid,"Update description of a widget")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Dashboardid)) {
                $Dashboardid = [system.web.httputility]::UrlEncode($Dashboardid)

                $QueryArray += "dashboardId=$Dashboardid"
            }

            if (![string]::IsNullOrEmpty($Widgetid)) {
                $Widgetid = [system.web.httputility]::UrlEncode($Widgetid)

                $QueryArray += "widgetId=$Widgetid"
            }

            if (![string]::IsNullOrEmpty($Body)) {


                $QueryArray += "JSON body=$Body"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/dashboards/{dashboardId}/widgets/{widgetId}/description'
            $APIPath = $APIPath -replace "\{Dashboardid\}","$Dashboardid"
            $APIPath = $APIPath -replace "\{Widgetid\}","$Widgetid"
            try {
                Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json) -ErrorAction Stop
            }
            catch {
                if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                    Write-Error -Exception $Error[0].Exception -Message "Dashboard not found." -ErrorAction $ErrorActionPreference
                }
                elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                    Write-Error -Exception $Error[0].Exception -Message "Widget not found." -ErrorAction $ErrorActionPreference
                }
                else {
                    Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
                }

            }

        }
    }
    end {}
}
