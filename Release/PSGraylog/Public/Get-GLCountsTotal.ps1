<#
.SYNOPSIS
    Total number of messages in all your indices.
.DESCRIPTION
    Total number of messages in all your indices.
    

    For more information about this cmdlet - please search for /count/{indexSetId}/total in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLCountsTotal -Indexsetid <String>
.NOTES
    Auto generated
#>
Function Get-GLCountsTotal {
    [CmdletBinding()]
    Param(
        # Parameter indexSetId
        [Parameter(Mandatory=$False)]
        [String]$Indexsetid,

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
        if(![string]::IsNullOrEmpty($Indexsetid)){
        $Indexsetid = [system.web.httputility]::UrlEncode($Indexsetid)
        
        $QueryArray += "indexSetId=$Indexsetid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/count/{indexSetId}/total'
        $APIPath = $APIPath -Replace "\{Indexsetid\}","$Indexsetid" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
