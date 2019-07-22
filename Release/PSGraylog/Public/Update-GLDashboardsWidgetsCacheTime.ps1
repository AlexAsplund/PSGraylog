<#
.SYNOPSIS
    Update cache time of a widget
.DESCRIPTION
    Update cache time of a widget
    

    For more information about this cmdlet - please search for /dashboards/{dashboardId}/widgets/{widgetId}/cachetime in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Update-GLDashboardsWidgetsCacheTime -Dashboardid <String> -Widgetid <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
Function Update-GLDashboardsWidgetsCacheTime {
    [CmdletBinding()]
    Param(
        # Parameter dashboardId
        [Parameter(Mandatory=$True)]
        [String]$Dashboardid,
         # Parameter widgetId
        [Parameter(Mandatory=$True)]
        [String]$Widgetid,
         # Parameter JSON body
        [Parameter(Mandatory=$True)]
        [PSCustomObject]$Body,
 
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
        
        if(![string]::IsNullOrEmpty($Body)){
        
        
        $QueryArray += "JSON body=$Body"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/dashboards/{dashboardId}/widgets/{widgetId}/cachetime'
        $APIPath = $APIPath -Replace "\{Dashboardid\}","$Dashboardid" 
        $APIPath = $APIPath -Replace "\{Widgetid\}","$Widgetid" 
        Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json)
    }
    End {}
}
