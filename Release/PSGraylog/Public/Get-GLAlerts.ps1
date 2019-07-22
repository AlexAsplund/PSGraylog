<#
.SYNOPSIS
    Get an alert by ID.
.DESCRIPTION
    Get an alert by ID.
    

    For more information about this cmdlet - please search for /streams/alerts/{alertId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLAlerts -Alertid <String>
.NOTES
    Auto generated
#>
Function Get-GLAlerts {
    [CmdletBinding()]
    Param(
        # The alert ID to retrieve.
        [Parameter(Mandatory=$True)]
        [String]$Alertid,

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
        if(![string]::IsNullOrEmpty($Alertid)){
        $Alertid = [system.web.httputility]::UrlEncode($Alertid)
        
        $QueryArray += "alertId=$Alertid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/streams/alerts/{alertId}'
        $APIPath = $APIPath -Replace "\{Alertid\}","$Alertid" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
