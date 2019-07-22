<#
.SYNOPSIS
    Update a decorator
.DESCRIPTION
    Update a decorator
    

    For more information about this cmdlet - please search for /search/decorators/{decoratorId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Update-GLSearchDecorators -DecoratorId <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
Function Update-GLSearchDecorators {
    [CmdletBinding()]
    Param(
        # Parameter decorator id
        [Parameter(Mandatory=$True)]
        [String]$DecoratorId,
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
        if(![string]::IsNullOrEmpty($DecoratorId)){
        $DecoratorId = [system.web.httputility]::UrlEncode($DecoratorId)
        
        $QueryArray += "decorator id=$DecoratorId"
    }    
        
        if(![string]::IsNullOrEmpty($Body)){
        
        
        $QueryArray += "JSON body=$Body"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/search/decorators/{decoratorId}'
        $APIPath = $APIPath -Replace "\{Decoratorid\}","$Decoratorid" 
        Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json)
    }
    End {}
}
