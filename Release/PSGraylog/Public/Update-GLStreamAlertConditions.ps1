<#
.SYNOPSIS
    Modify an alert condition
.DESCRIPTION
    Modify an alert condition
    

    For more information about this cmdlet - please search for /streams/{streamId}/alerts/conditions/{conditionId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Update-GLStreamAlertConditions -Streamid <String> -Conditionid <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
Function Update-GLStreamAlertConditions {
    [CmdletBinding()]
    Param(
        # The stream id the alert condition belongs to.
        [Parameter(Mandatory=$True)]
        [String]$Streamid,
         # The alert condition id.
        [Parameter(Mandatory=$True)]
        [String]$Conditionid,
         # Parameter JSON body
        [Parameter(Mandatory=$True)]
        [PSCustomObject]$Body,
 
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
        
        if(![string]::IsNullOrEmpty($Body)){
        
        
        $QueryArray += "JSON body=$Body"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/streams/{streamId}/alerts/conditions/{conditionId}'
        $APIPath = $APIPath -Replace "\{Streamid\}","$Streamid" 
        $APIPath = $APIPath -Replace "\{Conditionid\}","$Conditionid" 
        Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json)
    }
    End {}
}
