<#
.SYNOPSIS
    Update an extractor
.DESCRIPTION
    Update an extractor
    

    For more information about this cmdlet - please search for /system/inputs/{inputId}/extractors/{extractorId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Update-GLExtractors -Inputid <String> -Extractorid <String> -Body <PSCustomObject>
.NOTES
    Auto generated
#>
Function Update-GLExtractors {
    [CmdletBinding()]
    Param(
        # Parameter inputId
        [Parameter(Mandatory=$True)]
        [String]$Inputid,
         # Parameter extractorId
        [Parameter(Mandatory=$True)]
        [String]$Extractorid,
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
        if(![string]::IsNullOrEmpty($Inputid)){
        $Inputid = [system.web.httputility]::UrlEncode($Inputid)
        
        $QueryArray += "inputId=$Inputid"
    }    
        
        if(![string]::IsNullOrEmpty($Extractorid)){
        $Extractorid = [system.web.httputility]::UrlEncode($Extractorid)
        
        $QueryArray += "extractorId=$Extractorid"
    }    
        
        if(![string]::IsNullOrEmpty($Body)){
        
        
        $QueryArray += "JSON body=$Body"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/inputs/{inputId}/extractors/{extractorId}'
        $APIPath = $APIPath -Replace "\{Inputid\}","$Inputid" 
        $APIPath = $APIPath -Replace "\{Extractorid\}","$Extractorid" 
        Invoke-RestMethod -Method PUT -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body ($Body | ConvertTo-Json)
    }
    End {}
}
