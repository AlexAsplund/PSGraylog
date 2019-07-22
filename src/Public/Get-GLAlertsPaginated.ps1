<#
.SYNOPSIS
    Get alarms of all streams, filtered by specifying limit and offset parameters.
.DESCRIPTION
    Get alarms of all streams, filtered by specifying limit and offset parameters.
    

    For more information about this cmdlet - please search for /streams/alerts/paginated in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLAlertsPaginated -Skip <Int> -Limit <Int> -State <String>
.NOTES
    Auto generated
#>
Function Get-GLAlertsPaginated {
    [CmdletBinding()]
    Param(
        # The number of elements to skip (offset).
        [Parameter(Mandatory=$True)]
        [Int]$Skip,
         # The maximum number of elements to return.
        [Parameter(Mandatory=$True)]
        [Int]$Limit,
         # Alert state (resolved/unresolved)
        [Parameter(Mandatory=$False)]
        [String]$State,
 
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
        if(![string]::IsNullOrEmpty($Skip)){
        
        
        $QueryArray += "skip=$Skip"
    }    
        
        if(![string]::IsNullOrEmpty($Limit)){
        
        
        $QueryArray += "limit=$Limit"
    }    
        
        if(![string]::IsNullOrEmpty($State)){
        $State = [system.web.httputility]::UrlEncode($State)
        
        $QueryArray += "state=$State"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/streams/alerts/paginated'
        $APIPath = $APIPath -Replace "\{\}","$" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
