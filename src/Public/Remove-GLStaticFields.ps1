<#
.SYNOPSIS
    Remove static field of an input
.DESCRIPTION
    Remove static field of an input
    

    For more information about this cmdlet - please search for /system/inputs/{inputId}/staticfields/{key} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLStaticFields -Key <String> -Inputid <String>
.NOTES
    Auto generated
#>
Function Remove-GLStaticFields {
    [CmdletBinding()]
    Param(
        # Parameter Key
        [Parameter(Mandatory=$True)]
        [String]$Key,
         # Parameter inputId
        [Parameter(Mandatory=$True)]
        [String]$Inputid,
 
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
        if(![string]::IsNullOrEmpty($Key)){
        $Key = [system.web.httputility]::UrlEncode($Key)
        
        $QueryArray += "Key=$Key"
    }    
        
        if(![string]::IsNullOrEmpty($Inputid)){
        $Inputid = [system.web.httputility]::UrlEncode($Inputid)
        
        $QueryArray += "inputId=$Inputid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/inputs/{inputId}/staticfields/{key}'
        $APIPath = $APIPath -Replace "\{Inputid\}","$Inputid" 
        $APIPath = $APIPath -Replace "\{Key\}","$Key" 
        Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential 
    }
    End {}
}
