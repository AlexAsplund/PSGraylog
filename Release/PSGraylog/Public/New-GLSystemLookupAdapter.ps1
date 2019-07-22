<#
.SYNOPSIS
    Create a new data adapter
.DESCRIPTION
    Create a new data adapter
    

    For more information about this cmdlet - please search for /system/lookup/adapters in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    New-GLSystemLookupAdapter -Body <String>
.NOTES
    Auto generated
#>
Function New-GLSystemLookupAdapter {
    [CmdletBinding()]
    Param(
        # Parameter JSON Body
        [Parameter(Mandatory=$False)]
        [String]$Body,

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
        if(![string]::IsNullOrEmpty($Body)){
        $Body = [system.web.httputility]::UrlEncode($Body)
        
        $QueryArray += "JSON Body=$Body"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/lookup/adapters'
        $APIPath = $APIPath -Replace "\{\}","$" 
        Invoke-RestMethod -Method POST -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json)
    }
    End {}
}
