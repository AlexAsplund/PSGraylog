<#
.SYNOPSIS
    Delete configuration settings from database
.DESCRIPTION
    Delete configuration settings from database
    

    For more information about this cmdlet - please search for /system/cluster_config/{configClass} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLSystemClusterConfig -Configclass <String>
.NOTES
    Auto generated
#>
Function Remove-GLSystemClusterConfig {
    [CmdletBinding()]
    Param(
        # The name of the cluster configuration class
        [Parameter(Mandatory=$True)]
        [String]$Configclass,

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
        if(![string]::IsNullOrEmpty($Configclass)){
        $Configclass = [system.web.httputility]::UrlEncode($Configclass)
        
        $QueryArray += "configClass=$Configclass"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/cluster_config/{configClass}'
        $APIPath = $APIPath -Replace "\{Configclass\}","$Configclass" 
        Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential 
    }
    End {}
}
