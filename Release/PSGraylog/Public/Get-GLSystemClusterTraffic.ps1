<#
.SYNOPSIS
    Get the cluster traffic stats
.DESCRIPTION
    Get the cluster traffic stats
    

    For more information about this cmdlet - please search for /system/cluster/traffic in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemClusterTraffic -Days <Int> -Daily <Bool>
.NOTES
    Auto generated
#>
Function Get-GLSystemClusterTraffic {
    [CmdletBinding()]
    Param(
        # For how many days the traffic stats should be returned
        [Parameter(Mandatory=$False)]
        [Int]$Days,
         # Whether the traffic should be aggregate to daily values
        [Parameter(Mandatory=$False)]
        [Bool]$Daily,
 
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
        if(![string]::IsNullOrEmpty($Days)){
        
        
        $QueryArray += "days=$Days"
    }    
        
        if(![string]::IsNullOrEmpty($Daily)){
        
        
        $QueryArray += "daily=$Daily"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/cluster/traffic'
        $APIPath = $APIPath -Replace "\{\}","$" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
