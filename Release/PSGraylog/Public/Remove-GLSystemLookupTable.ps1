<#
.SYNOPSIS
    Delete the lookup table
.DESCRIPTION
    Delete the lookup table
    

    For more information about this cmdlet - please search for /system/lookup/tables/{idOrName} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLSystemLookupTable -Idorname <String>
.NOTES
    Auto generated
#>
Function Remove-GLSystemLookupTable {
    [CmdletBinding()]
    Param(
        # Parameter idOrName
        [Parameter(Mandatory=$False)]
        [String]$Idorname,

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
        if(![string]::IsNullOrEmpty($Idorname)){
        $Idorname = [system.web.httputility]::UrlEncode($Idorname)
        
        $QueryArray += "idOrName=$Idorname"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/lookup/tables/{idOrName}'
        $APIPath = $APIPath -Replace "\{Idorname\}","$Idorname" 
        Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential 
    }
    End {}
}
