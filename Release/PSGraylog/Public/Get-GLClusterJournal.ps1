<#
.SYNOPSIS
    Get message journal information of a given node
.DESCRIPTION
    Get message journal information of a given node
    

    For more information about this cmdlet - please search for /cluster/{nodeId}/journal in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLClusterJournal -Nodeid <String>
.NOTES
    Auto generated
#>
Function Get-GLClusterJournal {
    [CmdletBinding()]
    Param(
        # The id of the node to get message journal information.
        [Parameter(Mandatory=$True)]
        [String]$Nodeid,

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
        if(![string]::IsNullOrEmpty($Nodeid)){
        $Nodeid = [system.web.httputility]::UrlEncode($Nodeid)
        
        $QueryArray += "nodeId=$Nodeid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/cluster/{nodeId}/journal'
        $APIPath = $APIPath -Replace "\{Nodeid\}","$Nodeid" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
