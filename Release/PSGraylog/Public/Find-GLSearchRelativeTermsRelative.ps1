<#
.SYNOPSIS
    Most common field terms of a query using a relative timerange.
.DESCRIPTION
    Most common field terms of a query using a relative timerange.
    

    For more information about this cmdlet - please search for /search/universal/relative/terms in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Find-GLSearchRelativeTermsRelative -Field <String> -Query <String> -Stacked_Fields <String> -Size <Int> -Range <Int> -Filter <String> -Order <String>
.NOTES
    Auto generated
#>
Function Find-GLSearchRelativeTermsRelative {
    [CmdletBinding()]
    Param(
        # Message field of to return terms of
        [Parameter(Mandatory=$True)]
        [String]$Field,
         # Query (Lucene syntax)
        [Parameter(Mandatory=$True)]
        [String]$Query,
         # Fields to stack
        [Parameter(Mandatory=$False)]
        [String]$Stacked_Fields,
         # Maximum number of terms to return
        [Parameter(Mandatory=$False)]
        [Int]$Size,
         # Relative timeframe to search in. See search method description.
        [Parameter(Mandatory=$True)]
        [Int]$Range,
         # Filter
        [Parameter(Mandatory=$False)]
        [String]$Filter,
         # Sorting (field:asc / field:desc)
        [Parameter(Mandatory=$False)]
        [String]$Order,
 
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
        if(![string]::IsNullOrEmpty($Field)){
        $Field = [system.web.httputility]::UrlEncode($Field)
        
        $QueryArray += "field=$Field"
    }    
        
        if(![string]::IsNullOrEmpty($Query)){
        $Query = [system.web.httputility]::UrlEncode($Query)
        
        $QueryArray += "query=$Query"
    }    
        
        if(![string]::IsNullOrEmpty($Stacked_Fields)){
        $Stacked_Fields = [system.web.httputility]::UrlEncode($Stacked_Fields)
        
        $QueryArray += "stacked_fields=$Stacked_Fields"
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
        
        if(![string]::IsNullOrEmpty($Order)){
        $Order = [system.web.httputility]::UrlEncode($Order)
        
        $QueryArray += "order=$Order"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/search/universal/relative/terms'
        $APIPath = $APIPath -Replace "\{\}","$" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
