<#
.SYNOPSIS
    Ordered field terms of a query computed on another field using a relative timerange.
.DESCRIPTION
    Ordered field terms of a query computed on another field using a relative timerange.
    

    For more information about this cmdlet - please search for /search/universal/relative/termsstats in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSearchRelativeTermsStatsRelative -Key_Field <String> -Value_Field <String> -Order <String> -Query <String> -Size <Int> -Range <Int> -Filter <String>
.NOTES
    Auto generated
#>
Function Get-GLSearchRelativeTermsStatsRelative {
    [CmdletBinding()]
    Param(
        # Message field of to return terms of
        [Parameter(Mandatory=$True)]
        [String]$Key_Field,
         # Value field used for computation
        [Parameter(Mandatory=$True)]
        [String]$Value_Field,
         # What to order on (Allowed values: TERM, REVERSE_TERM, COUNT, REVERSE_COUNT, TOTAL, REVERSE_TOTAL, MIN, REVERSE_MIN, MAX, REVERSE_MAX, MEAN, REVERSE_MEAN)
        [Parameter(Mandatory=$True)]
        [String]$Order,
         # Query (Lucene syntax)
        [Parameter(Mandatory=$True)]
        [String]$Query,
         # Maximum number of terms to return
        [Parameter(Mandatory=$False)]
        [Int]$Size,
         # Relative timeframe to search in. See search method description.
        [Parameter(Mandatory=$True)]
        [Int]$Range,
         # Filter
        [Parameter(Mandatory=$False)]
        [String]$Filter,
 
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
        if(![string]::IsNullOrEmpty($Key_Field)){
        $Key_Field = [system.web.httputility]::UrlEncode($Key_Field)
        
        $QueryArray += "key_field=$Key_Field"
    }    
        
        if(![string]::IsNullOrEmpty($Value_Field)){
        $Value_Field = [system.web.httputility]::UrlEncode($Value_Field)
        
        $QueryArray += "value_field=$Value_Field"
    }    
        
        if(![string]::IsNullOrEmpty($Order)){
        $Order = [system.web.httputility]::UrlEncode($Order)
        
        $QueryArray += "order=$Order"
    }    
        
        if(![string]::IsNullOrEmpty($Query)){
        $Query = [system.web.httputility]::UrlEncode($Query)
        
        $QueryArray += "query=$Query"
    }    
        
        if(![string]::IsNullOrEmpty($Size)){
        
        
        $QueryArray += "size=$Size"
    }    
        
        if(![string]::IsNullOrEmpty($Range)){
        
        
        $QueryArray += "range=$Range"
    }    
        
        if(![string]::IsNullOrEmpty($Filter)){
        $Filter = [system.web.httputility]::UrlEncode($Filter)
        
        $QueryArray += "filter=$Filter"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/search/universal/relative/termsstats'
        $APIPath = $APIPath -Replace "\{\}","$" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
