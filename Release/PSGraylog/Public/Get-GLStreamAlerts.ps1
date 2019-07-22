<#
.SYNOPSIS
    Get the most recent alarms of this stream.
.DESCRIPTION
    Get the most recent alarms of this stream.
    

    For more information about this cmdlet - please search for /streams/{streamId}/alerts in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLStreamAlerts -Streamid <String> -Since <Int> -Limit <Int>
.NOTES
    Auto generated
#>
Function Get-GLStreamAlerts {
    [CmdletBinding()]
    Param(
        # The stream id this new alert condition belongs to.
        [Parameter(Mandatory=$True)]
        [String]$Streamid,
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
        if(![string]::IsNullOrEmpty($Streamid)){
        $Streamid = [system.web.httputility]::UrlEncode($Streamid)
        
        $QueryArray += "streamId=$Streamid"
    }    
        
        if(![string]::IsNullOrEmpty($Since)){
        
        
        $QueryArray += "since=$Since"
    }    
        
        if(![string]::IsNullOrEmpty($Limit)){
        
        
        $QueryArray += "limit=$Limit"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/streams/{streamId}/alerts'
        $APIPath = $APIPath -Replace "\{Streamid\}","$Streamid" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
