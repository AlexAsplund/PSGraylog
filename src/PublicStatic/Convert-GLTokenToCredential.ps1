<#
.SYNOPSIS
    Converts graylog token to [PSCredential]
.DESCRIPTION
    Converts graylog token to [PSCredential] by setting token as username and "token" as password.
.EXAMPLE
    PS C:\> Convert-GLTokenToCredential -Token $Key
    Returns a [PSCredential] object
#>
function Convert-GLTokenToCredential {
    [CmdletBinding()]
    param (
        [parameter(Mandatory)]
        [string]$Token
    )
    
    begin {
    }
    
    process {
        $PSCredential = [PSCredential]::new($Token, ("token" | ConvertTo-SecureString -AsPlainText -Force))
    }
    
    end {
        return $PSCredential
    }
}