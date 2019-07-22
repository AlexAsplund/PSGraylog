<#
.SYNOPSIS
    Render configuration template
.DESCRIPTION
    Render configuration template
    

    For more information about this cmdlet - please search for /sidecar/configurations/render/{sidecarId}/{configurationId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSidecarConfigurationsRenderConfiguration -Sidecarid <String> -Configurationid <String>
.NOTES
    Auto generated
#>
Function Get-GLSidecarConfigurationsRenderConfiguration {
    [CmdletBinding()]
    Param(
        # Parameter sidecarId
        [Parameter(Mandatory=$True)]
        [String]$Sidecarid,
         # Parameter configurationId
        [Parameter(Mandatory=$True)]
        [String]$Configurationid,
 
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
        
        if(![string]::IsNullOrEmpty($Configurationid)){
        $Configurationid = [system.web.httputility]::UrlEncode($Configurationid)
        
        $QueryArray += "configurationId=$Configurationid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/sidecar/configurations/render/{sidecarId}/{configurationId}'
        $APIPath = $APIPath -Replace "\{Sidecarid\}","$Sidecarid" 
        $APIPath = $APIPath -Replace "\{Configurationid\}","$Configurationid" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
