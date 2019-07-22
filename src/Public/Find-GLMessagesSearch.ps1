<#
.SYNOPSIS
    Get a single message.
.DESCRIPTION
    Get a single message.
    

    For more information about this cmdlet - please search for /messages/{index}/{messageId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Find-GLMessagesSearch -Index <String> -Messageid <String>
.NOTES
    Auto generated
#>
Function Find-GLMessagesSearch {
    [CmdletBinding()]
    Param(
        # The index this message is stored in.
        [Parameter(Mandatory=$True)]
        [String]$Index,
         # Parameter messageId
        [Parameter(Mandatory=$True)]
        [String]$Messageid,
 
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
        
        if(![string]::IsNullOrEmpty($Messageid)){
        $Messageid = [system.web.httputility]::UrlEncode($Messageid)
        
        $QueryArray += "messageId=$Messageid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/messages/{index}/{messageId}'
        $APIPath = $APIPath -Replace "\{Index\}","$Index" 
        $APIPath = $APIPath -Replace "\{Messageid\}","$Messageid" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
