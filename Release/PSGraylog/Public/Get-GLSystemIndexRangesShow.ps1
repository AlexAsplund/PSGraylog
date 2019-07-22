<#
.SYNOPSIS
    Show single index range
.DESCRIPTION
    Show single index range
    

    For more information about this cmdlet - please search for /system/indices/ranges/{index: [a-z_0-9]+} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemIndexRangesShow -Index <String>
.NOTES
    Auto generated
#>
Function Get-GLSystemIndexRangesShow {
    [CmdletBinding()]
    Param(
        # The name of the Graylog-managed Elasticsearch index
        [Parameter(Mandatory=$True)]
        [String]$Index,

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
        if(![string]::IsNullOrEmpty($Index)){
        $Index = [system.web.httputility]::UrlEncode($Index)
        
        $QueryArray += "index=$Index"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/indices/ranges/{index: [a-z_0-9]+}'
        $APIPath = $APIPath -Replace "\{\}","$" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
