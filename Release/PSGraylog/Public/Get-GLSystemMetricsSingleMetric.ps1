<#
.SYNOPSIS
    Get a single metric
.DESCRIPTION
    Get a single metric
    

    For more information about this cmdlet - please search for /system/metrics/{metricName} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemMetricsSingleMetric -Metricname <String>
.NOTES
    Auto generated
#>
Function Get-GLSystemMetricsSingleMetric {
    [CmdletBinding()]
    Param(
        # Parameter metricName
        [Parameter(Mandatory=$True)]
        [String]$Metricname,

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
        if(![string]::IsNullOrEmpty($Metricname)){
        $Metricname = [system.web.httputility]::UrlEncode($Metricname)
        
        $QueryArray += "metricName=$Metricname"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/metrics/{metricName}'
        $APIPath = $APIPath -Replace "\{Metricname\}","$Metricname" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
