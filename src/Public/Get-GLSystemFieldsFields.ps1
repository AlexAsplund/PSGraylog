<#
.SYNOPSIS
    Get list of message fields that exist
.DESCRIPTION
    Get list of message fields that exist
    This operation is comparably fast because it reads directly from the indexer mapping.

    For more information about this cmdlet - please search for /system/fields in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemFieldsFields -Limit <Int>
.NOTES
    Auto generated
#>
Function Get-GLSystemFieldsFields {
    [CmdletBinding()]
    Param(
        # Maximum number of fields to return. Set to 0 for all fields.
        [Parameter(Mandatory=$False)]
        [Int]$Limit,

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
        if(![string]::IsNullOrEmpty($Limit)){
        
        
        $QueryArray += "limit=$Limit"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/fields'
        $APIPath = $APIPath -Replace "\{\}","$" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
