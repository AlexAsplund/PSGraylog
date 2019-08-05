<#
.SYNOPSIS
    Get a single widget value.
.DESCRIPTION
    Get a single widget value.


    For more information about this cmdlet - please search for /dashboards/{dashboardId}/widgets/{widgetId}/value in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLDashboardsWidgetsWidValue -Dashboardid <String> -Widgetid <String>
.NOTES
    Auto generated
#>
function Get-GLDashboardsWidgetsWidValue {
    [CmdletBinding()]
    param(
        # Parameter dashboardId
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Dashboardid,
        # Parameter widgetId
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Widgetid,

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

        $QueryArray = @()
        if (![string]::IsNullOrEmpty($Dashboardid)) {
            $Dashboardid = [system.web.httputility]::UrlEncode($Dashboardid)

            $QueryArray += "dashboardId=$Dashboardid"
        }

        if (![string]::IsNullOrEmpty($Widgetid)) {
            $Widgetid = [system.web.httputility]::UrlEncode($Widgetid)

            $QueryArray += "widgetId=$Widgetid"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/dashboards/{dashboardId}/widgets/{widgetId}/value'
        $APIPath = $APIPath -replace "\{Dashboardid\}","$Dashboardid"
        $APIPath = $APIPath -replace "\{Widgetid\}","$Widgetid"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                Write-Error -Exception $Error[0].Exception -Message "Dashboard not found." -ErrorAction $ErrorActionPreference
            }
            elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                Write-Error -Exception $Error[0].Exception -Message "Widget not found." -ErrorAction $ErrorActionPreference
            }
            elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 504) {
                Write-Error -Exception $Error[0].Exception -Message "Computation failed on indexer side." -ErrorAction $ErrorActionPreference
            }
            else {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
            }

        }


    }
    end {}
}
