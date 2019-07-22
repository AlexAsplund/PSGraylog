<#
.SYNOPSIS
    Set a collector action
.DESCRIPTION
    Set a collector action
    

    For more information about this cmdlet - please search for /sidecar/action/{sidecarId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Set-GLSidecarCollectorActionsAction -Sidecarid <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
Function Set-GLSidecarCollectorActionsAction {
    [CmdletBinding()]
    Param(
        # The id this Sidecar is registering as.
        [Parameter(Mandatory=$True)]
        [String]$Sidecarid,
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
        if(![string]::IsNullOrEmpty($Sidecarid)){
        $Sidecarid = [system.web.httputility]::UrlEncode($Sidecarid)
        
        $QueryArray += "sidecarId=$Sidecarid"
    }    
        
        if(![string]::IsNullOrEmpty($Body)){
        
        
        $QueryArray += "JSON body=$Body"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/sidecar/action/{sidecarId}'
        $APIPath = $APIPath -Replace "\{Sidecarid\}","$Sidecarid" 
        Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json)
    }
    End {}
}
