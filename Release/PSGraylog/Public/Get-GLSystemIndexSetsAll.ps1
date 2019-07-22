<#
.SYNOPSIS
    Get a list of all index sets
.DESCRIPTION
    Get a list of all index sets
    

    For more information about this cmdlet - please search for /system/indices/index_sets in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemIndexSetsAll -Skip <Int> -Limit <Int> -Stats <Bool>
.NOTES
    Auto generated
#>
Function Get-GLSystemIndexSetsAll {
    [CmdletBinding()]
    Param(
        # The number of elements to skip (offset).
        [Parameter(Mandatory=$True)]
        [Int]$Skip,
         # The maximum number of elements to return.
        [Parameter(Mandatory=$True)]
        [Int]$Limit,
         # Include index set stats.
        [Parameter(Mandatory=$False)]
        [Bool]$Stats,
 
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
        
        if(![string]::IsNullOrEmpty($Stats)){
        
        
        $QueryArray += "stats=$Stats"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/indices/index_sets'
        $APIPath = $APIPath -Replace "\{\}","$" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}

