<#
.SYNOPSIS
    Get the most recent alarms of all streams.
.DESCRIPTION
    Get the most recent alarms of all streams.
    

    For more information about this cmdlet - please search for /streams/alerts in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLAlertsRecent -Since <Int> -Limit <Int>
.NOTES
    Auto generated
#>
Function Get-GLAlertsRecent {
    [CmdletBinding()]
    Param(
        # Optional parameter to define a lower date boundary. (UNIX timestamp)
        [Parameter(Mandatory=$False)]
        [Int]$Since,
         # Maximum number of alerts to return.
        [Parameter(Mandatory=$False)]
        [Int]$Limit,
 
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
        if(![string]::IsNullOrEmpty($Since)){
        
        
        $QueryArray += "since=$Since"
    }    
        
        if(![string]::IsNullOrEmpty($Limit)){
        
        
        $QueryArray += "limit=$Limit"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/streams/alerts'
        $APIPath = $APIPath -Replace "\{\}","$" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
