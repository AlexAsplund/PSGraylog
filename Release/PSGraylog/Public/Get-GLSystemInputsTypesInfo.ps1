<#
.SYNOPSIS
    Get information about a single input type
.DESCRIPTION
    Get information about a single input type
    

    For more information about this cmdlet - please search for /system/inputs/types/{inputType} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemInputsTypesInfo -Inputtype <String>
.NOTES
    Auto generated
#>
Function Get-GLSystemInputsTypesInfo {
    [CmdletBinding()]
    Param(
        # Parameter inputType
        [Parameter(Mandatory=$True)]
        [String]$Inputtype,

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
        if(![string]::IsNullOrEmpty($Inputtype)){
        $Inputtype = [system.web.httputility]::UrlEncode($Inputtype)
        
        $QueryArray += "inputType=$Inputtype"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/inputs/types/{inputType}'
        $APIPath = $APIPath -Replace "\{Inputtype\}","$Inputtype" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
