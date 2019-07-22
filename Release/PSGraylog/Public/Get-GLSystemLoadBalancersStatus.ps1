<#
.SYNOPSIS
    Get status of this Graylog server node for load balancers. Returns ALIVE with HTTP 200, DEAD with HTTP 503, or THROTTLED with HTTP 429.
.DESCRIPTION
    Get status of this Graylog server node for load balancers. Returns ALIVE with HTTP 200, DEAD with HTTP 503, or THROTTLED with HTTP 429.
    

    For more information about this cmdlet - please search for /system/lbstatus in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemLoadBalancersStatus 
.NOTES
    Auto generated
#>
Function Get-GLSystemLoadBalancersStatus {
    [CmdletBinding()]
    Param(

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
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/lbstatus'
        $APIPath = $APIPath -Replace "\{\}","$" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
