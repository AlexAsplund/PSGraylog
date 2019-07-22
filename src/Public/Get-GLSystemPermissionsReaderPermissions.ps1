<#
.SYNOPSIS
    Get the initial permissions assigned to a reader account
.DESCRIPTION
    Get the initial permissions assigned to a reader account
    

    For more information about this cmdlet - please search for /system/permissions/reader/{username} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemPermissionsReaderPermissions -Username <String>
.NOTES
    Auto generated
#>
Function Get-GLSystemPermissionsReaderPermissions {
    [CmdletBinding()]
    Param(
        # Parameter username
        [Parameter(Mandatory=$True)]
        [String]$Username,

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
        if(![string]::IsNullOrEmpty($Username)){
        $Username = [system.web.httputility]::UrlEncode($Username)
        
        $QueryArray += "username=$Username"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/permissions/reader/{username}'
        $APIPath = $APIPath -Replace "\{Username\}","$Username" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
