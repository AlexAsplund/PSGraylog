<#
.SYNOPSIS
    Information about a node.
.DESCRIPTION
    Information about a node.
    This is returning information of a node in context to its state in the cluster. Use the system API of the node itself to get system information.

    For more information about this cmdlet - please search for /system/cluster/nodes/{nodeId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemClusterNode -Nodeid <String>
.NOTES
    Auto generated
#>
Function Get-GLSystemClusterNode {
    [CmdletBinding()]
    Param(
        # Parameter nodeId
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
        $APIPath = '/system/cluster/nodes/{nodeId}'
        $APIPath = $APIPath -Replace "\{Nodeid\}","$Nodeid" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
