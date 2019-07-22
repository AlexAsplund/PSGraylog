<#
.SYNOPSIS
    Delete index set
.DESCRIPTION
    Delete index set
    

    For more information about this cmdlet - please search for /system/indices/index_sets/{id} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLSystemIndexSets -Id <String> -Delete_Indices <Bool>
.NOTES
    Auto generated
#>
Function Remove-GLSystemIndexSets {
    [CmdletBinding()]
    Param(
        # Parameter id
        [Parameter(Mandatory=$True)]
        [String]$Id,
         # Parameter delete_indices
        [Parameter(Mandatory=$False)]
        [Bool]$Delete_Indices,
 
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
        if(![string]::IsNullOrEmpty($Id)){
        $Id = [system.web.httputility]::UrlEncode($Id)
        
        $QueryArray += "id=$Id"
    }    
        
        if(![string]::IsNullOrEmpty($Delete_Indices)){
        
        
        $QueryArray += "delete_indices=$Delete_Indices"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/indices/index_sets/{id}'
        $APIPath = $APIPath -Replace "\{Id\}","$Id" 
        Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential 
    }
    End {}
}
