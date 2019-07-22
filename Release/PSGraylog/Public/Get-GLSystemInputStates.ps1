<#
.SYNOPSIS
    Get input state for specified input id on this node
.DESCRIPTION
    Get input state for specified input id on this node
    

    For more information about this cmdlet - please search for /system/inputstates/{inputId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemInputStates -Inputid <String>
.NOTES
    Auto generated
#>
Function Get-GLSystemInputStates {
    [CmdletBinding()]
    Param(
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
        if(![string]::IsNullOrEmpty($Inputid)){
        $Inputid = [system.web.httputility]::UrlEncode($Inputid)
        
        $QueryArray += "inputId=$Inputid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/inputstates/{inputId}'
        $APIPath = $APIPath -Replace "\{Inputid\}","$Inputid" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
