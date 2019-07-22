<#
.SYNOPSIS
    Simple function that sets the global variables "`$Global:GLApiUrl" and "`$Global:GLCredential"
.DESCRIPTION
    Simple function that sets the global variables "`$Global:GLApiUrl" and "`$Global:GLCredential"
    These can also be supplied as a parameter to every command
.EXAMPLE
    PS C:\> Set-GLApiConfig -ApiUrl "https://graylog.domain.com/api" -Credential $MyCredential
    Sets global variables "`$Global:GLApiUrl" and "`$Global:GLCredential"
.EXAMPLE
    PS C:\> $TokenCreds = Convert-GLTokenToCredential -Token abcdefghijklmnop123
    PS C:\> Set-GLApiConfig -ApiUrl "https://graylog.domain.com/api" -Credential $TokenCreds
    Sets global variables "`$Global:GLApiUrl" and "`$Global:GLCredential" using a token as credential instead of username/password
#>
function Set-GLApiConfig {
    [CmdletBinding()]
    param (
        [parameter(Mandatory)]
        [String]$APIUrl,

        [parameter(Mandatory)]
        [PSCredential]$Credential
    )
    
    begin {
        if($APIUrl -match '/$'){
            $APIUrl = $ApiUrl -replace '/$',''
            Write-Verbose "Removed Trailing slash on $APIUrl"
        }
    }
    
    process {
        $Global:GLApiUrl = $APIUrl
        $Global:GLCredential = $Credential
    }
    
    end {
    }
}