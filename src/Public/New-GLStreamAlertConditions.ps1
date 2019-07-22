<#
.SYNOPSIS
    Create an alert condition
.DESCRIPTION
    Create an alert condition
    

    For more information about this cmdlet - please search for /streams/{streamId}/alerts/conditions in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    New-GLStreamAlertConditions -Streamid <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
Function New-GLStreamAlertConditions {
    [CmdletBinding()]
    Param(
        # The stream id this new alert condition belongs to.
        [Parameter(Mandatory=$True)]
        [String]$Streamid,
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
        
        if(![string]::IsNullOrEmpty($Body)){
        
        
        $QueryArray += "JSON body=$Body"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/streams/{streamId}/alerts/conditions'
        $APIPath = $APIPath -Replace "\{Streamid\}","$Streamid" 
        Invoke-RestMethod -Method POST -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json)
    }
    End {}
}
