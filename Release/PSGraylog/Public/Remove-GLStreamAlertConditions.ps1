<#
.SYNOPSIS
    Delete an alert condition
.DESCRIPTION
    Delete an alert condition
    

    For more information about this cmdlet - please search for /streams/{streamId}/alerts/conditions/{conditionId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLStreamAlertConditions -Streamid <String> -Conditionid <String>
.NOTES
    Auto generated
#>
Function Remove-GLStreamAlertConditions {
    [CmdletBinding()]
    Param(
        # The stream id this alert condition belongs to.
        [Parameter(Mandatory=$True)]
        [String]$Streamid,
         # The alert condition id to be deleted
        [Parameter(Mandatory=$True)]
        [String]$Conditionid,
 
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
        if(![string]::IsNullOrEmpty($Streamid)){
        $Streamid = [system.web.httputility]::UrlEncode($Streamid)
        
        $QueryArray += "streamId=$Streamid"
    }    
        
        if(![string]::IsNullOrEmpty($Conditionid)){
        $Conditionid = [system.web.httputility]::UrlEncode($Conditionid)
        
        $QueryArray += "conditionId=$Conditionid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/streams/{streamId}/alerts/conditions/{conditionId}'
        $APIPath = $APIPath -Replace "\{Streamid\}","$Streamid" 
        $APIPath = $APIPath -Replace "\{Conditionid\}","$Conditionid" 
        Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential 
    }
    End {}
}
