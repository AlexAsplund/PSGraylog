<#
.SYNOPSIS
    Delete one revision of a content pack
.DESCRIPTION
    Delete one revision of a content pack
    

    For more information about this cmdlet - please search for /system/content_packs/{contentPackId}/{revision} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLSystemContentPacksContentPack -Contentpackid <String> -Revision <Int>
.NOTES
    Auto generated
#>
Function Remove-GLSystemContentPacksContentPack {
    [CmdletBinding()]
    Param(
        # Content Pack ID
        [Parameter(Mandatory=$True)]
        [String]$Contentpackid,
         # Content Pack revision
        [Parameter(Mandatory=$True)]
        [Int]$Revision,
 
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
        
        if(![string]::IsNullOrEmpty($Revision)){
        
        
        $QueryArray += "revision=$Revision"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/content_packs/{contentPackId}/{revision}'
        $APIPath = $APIPath -Replace "\{Contentpackid\}","$Contentpackid" 
        $APIPath = $APIPath -Replace "\{Revision\}","$Revision" 
        Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential 
    }
    End {}
}
