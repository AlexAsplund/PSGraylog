﻿<#
.SYNOPSIS
    List configured lookup tables
.DESCRIPTION
    List configured lookup tables
    

    For more information about this cmdlet - please search for /system/lookup/tables in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemLookupTables -Page <Int> -Per_Page <Int> -Sort <String> -Order <String> -Query <String> -Resolve <Bool>
.NOTES
    Auto generated
#>
Function Get-GLSystemLookupTables {
    [CmdletBinding()]
    Param(
        # Parameter page
        [Parameter(Mandatory=$False)]
        [Int]$Page,
         # Parameter per_page
        [Parameter(Mandatory=$False)]
        [Int]$Per_Page,
         # The field to sort the result on
        [Parameter(Mandatory=$True)]
        [String]$Sort,
         # The sort direction
        [Parameter(Mandatory=$False)]
        [String]$Order,
         # Parameter query
        [Parameter(Mandatory=$False)]
        [String]$Query,
         # Parameter resolve
        [Parameter(Mandatory=$False)]
        [Bool]$Resolve,
 
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
        if(![string]::IsNullOrEmpty($Page)){
        
        
        $QueryArray += "page=$Page"
    }    
        
        if(![string]::IsNullOrEmpty($Per_Page)){
        
        
        $QueryArray += "per_page=$Per_Page"
    }    
        
        if(![string]::IsNullOrEmpty($Sort)){
        $Sort = [system.web.httputility]::UrlEncode($Sort)
        
        $QueryArray += "sort=$Sort"
    }    
        
        if(![string]::IsNullOrEmpty($Order)){
        $Order = [system.web.httputility]::UrlEncode($Order)
        
        $QueryArray += "order=$Order"
    }    
        
        if(![string]::IsNullOrEmpty($Query)){
        $Query = [system.web.httputility]::UrlEncode($Query)
        
        $QueryArray += "query=$Query"
    }    
        
        if(![string]::IsNullOrEmpty($Resolve)){
        
        
        $QueryArray += "resolve=$Resolve"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/lookup/tables'
        $APIPath = $APIPath -Replace "\{\}","$" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
