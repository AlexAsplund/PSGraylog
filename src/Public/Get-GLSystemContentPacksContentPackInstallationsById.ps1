<#
.SYNOPSIS
    Get details about the installations of a content pack
.DESCRIPTION
    Get details about the installations of a content pack
    

    For more information about this cmdlet - please search for /system/content_packs/{contentPackId}/installations in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemContentPacksContentPackInstallationsById -Contentpackid <String>
.NOTES
    Auto generated
#>
Function Get-GLSystemContentPacksContentPackInstallationsById {
    [CmdletBinding()]
    Param(
        # Content pack ID
        [Parameter(Mandatory=$True)]
        [String]$Contentpackid,

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
        if(![string]::IsNullOrEmpty($Contentpackid)){
        $Contentpackid = [system.web.httputility]::UrlEncode($Contentpackid)
        
        $QueryArray += "contentPackId=$Contentpackid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/content_packs/{contentPackId}/installations'
        $APIPath = $APIPath -Replace "\{Contentpackid\}","$Contentpackid" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
