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
Function Get-GLDashboardsWidgetsWidValue {
    [CmdletBinding()]
    Param(
        # Parameter dashboardId
        [Parameter(Mandatory=$True)]
        [String]$Dashboardid,
         # Parameter widgetId
        [Parameter(Mandatory=$True)]
        [String]$Widgetid,
 
        # Base url for the API, normally https://<grayloghost>:<port>/api
        [string]$APIUrl = $Global:GLApiUrl,

        # Graylog credentials as username:password or use Convert-GLTokenToCredential for token usage
        [PSCredential]$Credential = $Global:GLCredential
    
    )

    Begin{
        if([string]::IsNullOrEmpty($APIUrl)) {
            Write-Error -ErrorAction Stop -Exception "APIUrl not set" -Message "APIUrl was null or empty, refer to the documentation"
        }
        if($Null -eq $Credential){
            Write-Error -ErrorAction -Exception "Credential not set" -Message "Credential not set - refer to the documentation for help"
        }
    }

    Process {
                
        $QueryArray = @()
        if(![string]::IsNullOrEmpty($Dashboardid)){
        $Dashboardid = [system.web.httputility]::UrlEncode($Dashboardid)
        
        $QueryArray += "dashboardId=$Dashboardid"
    }    
        
        if(![string]::IsNullOrEmpty($Widgetid)){
        $Widgetid = [system.web.httputility]::UrlEncode($Widgetid)
        
        $QueryArray += "widgetId=$Widgetid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/dashboards/{dashboardId}/widgets/{widgetId}/value'
        $APIPath = $APIPath -Replace "\{Dashboardid\}","$Dashboardid" 
        $APIPath = $APIPath -Replace "\{Widgetid\}","$Widgetid" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
