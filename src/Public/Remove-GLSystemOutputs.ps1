<#
.SYNOPSIS
    Delete output
.DESCRIPTION
    Delete output
    

    For more information about this cmdlet - please search for /system/outputs/{outputId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLSystemOutputs -Outputid <String>
.NOTES
    Auto generated
#>
Function Remove-GLSystemOutputs {
    [CmdletBinding()]
    Param(
        # The id of the output that should be deleted
        [Parameter(Mandatory=$True)]
        [String]$Outputid,

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
        if(![string]::IsNullOrEmpty($Outputid)){
        $Outputid = [system.web.httputility]::UrlEncode($Outputid)
        
        $QueryArray += "outputId=$Outputid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/outputs/{outputId}'
        $APIPath = $APIPath -Replace "\{Outputid\}","$Outputid" 
        Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential 
    }
    End {}
}
