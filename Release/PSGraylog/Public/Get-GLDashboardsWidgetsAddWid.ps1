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
Function Get-GLDashboardsWidgetsAddWid {
    [CmdletBinding()]
    Param(
        # Parameter dashboardId
        [Parameter(Mandatory=$True)]
        [String]$Dashboardid,
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
        
        if(![string]::IsNullOrEmpty($Body)){
        
        
        $QueryArray += "JSON body=$Body"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/dashboards/{dashboardId}/widgets'
        $APIPath = $APIPath -Replace "\{Dashboardid\}","$Dashboardid" 
        Invoke-RestMethod -Method POST -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json)
    }
    End {}
}
