<#
.SYNOPSIS
    Delete an index. This will also trigger an index ranges rebuild job.
.DESCRIPTION
    Delete an index. This will also trigger an index ranges rebuild job.
    

    For more information about this cmdlet - please search for /system/indexer/indices/{index} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLIndexerIndices -Index <String>
.NOTES
    Auto generated
#>
Function Remove-GLIndexerIndices {
    [CmdletBinding()]
    Param(
        # Parameter index
        [Parameter(Mandatory=$False)]
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
        $APIPath = '/system/indexer/indices/{index}'
        $APIPath = $APIPath -Replace "\{Index\}","$Index" 
        Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential 
    }
    End {}
}
