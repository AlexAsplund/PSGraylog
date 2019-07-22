<#
.SYNOPSIS
    Export message search with relative timerange.
.DESCRIPTION
    Export message search with relative timerange.
    Search for messages in a relative timerange, specified as seconds from now. Example: 300 means search from 5 minutes ago to now.

    For more information about this cmdlet - please search for /search/universal/relative/export in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Find-GLSearchRelativeExportSearchRelativeChunked -Query <String> -Range <Int> -Limit <Int> -Offset <Int> -Batch_Size <Int> -Filter <String> -Fields <String>
.NOTES
    Auto generated
#>
Function Find-GLSearchRelativeExportSearchRelativeChunked {
    [CmdletBinding()]
    Param(
        # Query (Lucene syntax)
        [Parameter(Mandatory=$True)]
        [String]$Query,
         # Relative timeframe to search in. See method description.
        [Parameter(Mandatory=$True)]
        [Int]$Range,
         # Maximum number of messages to return.
        [Parameter(Mandatory=$False)]
        [Int]$Limit,
         # Offset
        [Parameter(Mandatory=$False)]
        [Int]$Offset,
         # Batch size for the backend storage export request.
        [Parameter(Mandatory=$False)]
        [Int]$Batch_Size,
         # Filter
        [Parameter(Mandatory=$False)]
        [String]$Filter,
         # Comma separated list of fields to return
        [Parameter(Mandatory=$True)]
        [String]$Fields,
 
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
        if(![string]::IsNullOrEmpty($Query)){
        $Query = [system.web.httputility]::UrlEncode($Query)
        
        $QueryArray += "query=$Query"
    }    
        
        if(![string]::IsNullOrEmpty($Range)){
        
        
        $QueryArray += "range=$Range"
    }    
        
        if(![string]::IsNullOrEmpty($Limit)){
        
        
        $QueryArray += "limit=$Limit"
    }    
        
        if(![string]::IsNullOrEmpty($Offset)){
        
        
        $QueryArray += "offset=$Offset"
    }    
        
        if(![string]::IsNullOrEmpty($Batch_Size)){
        
        
        $QueryArray += "batch_size=$Batch_Size"
    }    
        
        if(![string]::IsNullOrEmpty($Filter)){
        $Filter = [system.web.httputility]::UrlEncode($Filter)
        
        $QueryArray += "filter=$Filter"
    }    
        
        if(![string]::IsNullOrEmpty($Fields)){
        $Fields = [system.web.httputility]::UrlEncode($Fields)
        
        $QueryArray += "fields=$Fields"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/search/universal/relative/export'
        $APIPath = $APIPath -Replace "\{\}","$" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
