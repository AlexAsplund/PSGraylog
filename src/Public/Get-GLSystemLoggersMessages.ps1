<#
.SYNOPSIS
    Get recent internal log messages
.DESCRIPTION
    Get recent internal log messages
    

    For more information about this cmdlet - please search for /system/loggers/messages/recent in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemLoggersMessages -Limit <Int> -Level <String>
.NOTES
    Auto generated
#>
Function Get-GLSystemLoggersMessages {
    [CmdletBinding()]
    Param(
        # How many log messages should be returned
        [Parameter(Mandatory=$False)]
        [Int]$Limit,
         # Which log level (or higher) should the messages have
        [Parameter(Mandatory=$False)]
        [String]$Level,
 
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
        if(![string]::IsNullOrEmpty($Limit)){
        
        
        $QueryArray += "limit=$Limit"
    }    
        
        if(![string]::IsNullOrEmpty($Level)){
        $Level = [system.web.httputility]::UrlEncode($Level)
        
        $QueryArray += "level=$Level"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/loggers/messages/recent'
        $APIPath = $APIPath -Replace "\{\}","$" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
