<#
.SYNOPSIS
    Field value histogram of a query using an absolute timerange.
.DESCRIPTION
    Field value histogram of a query using an absolute timerange.
    

    For more information about this cmdlet - please search for /search/universal/absolute/fieldhistogram in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Find-GLSearchAbsoluteFieldHistogramAbsolute -Query <String> -Field <String> -Interval <String> -FromString <DateTime> -ToString <DateTime> -Filter <String> -Cardinality <Bool>
.NOTES
    Auto generated
#>
Function Find-GLSearchAbsoluteFieldHistogramAbsolute {
    [CmdletBinding()]
    Param(
        # Query (Lucene syntax)
        [Parameter(Mandatory=$True)]
        [String]$Query,
         # Field of whose values to get the histogram of
        [Parameter(Mandatory=$True)]
        [String]$Field,
         # Histogram interval / bucket size. (year, quarter, month, week, day, hour or minute)
        [Parameter(Mandatory=$True)]
        [String]$Interval,
         # Timerange start. See search method description for date format
        [Parameter(Mandatory=$True)]
        [DateTime]$From,
         # Timerange end. See search method description for date format
        [Parameter(Mandatory=$True)]
        [DateTime]$To,
         # Filter
        [Parameter(Mandatory=$False)]
        [String]$Filter,
         # Calculate the cardinality of the field as well
        [Parameter(Mandatory=$False)]
        [Bool]$Cardinality,
 
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
        
        if(![string]::IsNullOrEmpty($Field)){
        $Field = [system.web.httputility]::UrlEncode($Field)
        
        $QueryArray += "field=$Field"
    }    
        
        if(![string]::IsNullOrEmpty($Interval)){
        $Interval = [system.web.httputility]::UrlEncode($Interval)
        
        $QueryArray += "interval=$Interval"
    }    
        
        if(![string]::IsNullOrEmpty($From)){
        
        [string]$FromString = $From.ToUniversalTime() | Get-Date -Format 'yyyy-MM-ddTHH:mm:ss.fffZ'
        $QueryArray += "from=$FromString"
    }    
        
        if(![string]::IsNullOrEmpty($To)){
        
        [string]$ToString = $To.ToUniversalTime() | Get-Date -Format 'yyyy-MM-ddTHH:mm:ss.fffZ'
        $QueryArray += "to=$ToString"
    }    
        
        if(![string]::IsNullOrEmpty($Filter)){
        $Filter = [system.web.httputility]::UrlEncode($Filter)
        
        $QueryArray += "filter=$Filter"
    }    
        
        if(![string]::IsNullOrEmpty($Cardinality)){
        
        
        $QueryArray += "cardinality=$Cardinality"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/search/universal/absolute/fieldhistogram'
        $APIPath = $APIPath -Replace "\{\}","$" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
