﻿<#
.SYNOPSIS
    Delete a dashboard and all its widgets
.DESCRIPTION
    Delete a dashboard and all its widgets
    

    For more information about this cmdlet - please search for /dashboards/{dashboardId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLDashboards -Dashboardid <String>
.NOTES
    Auto generated
#>
Function Remove-GLDashboards {
    [CmdletBinding()]
    Param(
        # Parameter dashboardId
        [Parameter(Mandatory=$True)]
        [String]$Dashboardid,

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
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/dashboards/{dashboardId}'
        $APIPath = $APIPath -Replace "\{Dashboardid\}","$Dashboardid" 
        Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential 
    }
    End {}
}
