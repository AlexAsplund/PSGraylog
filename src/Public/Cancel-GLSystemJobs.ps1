﻿<#
.SYNOPSIS
    Cancel running job
.DESCRIPTION
    Cancel running job
    

    For more information about this cmdlet - please search for /system/jobs/{jobId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Cancel-GLSystemJobs -Jobid <String>
.NOTES
    Auto generated
#>
Function Cancel-GLSystemJobs {
    [CmdletBinding()]
    Param(
        # Parameter jobId
        [Parameter(Mandatory=$True)]
        [String]$Jobid,

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
        if(![string]::IsNullOrEmpty($Jobid)){
        $Jobid = [system.web.httputility]::UrlEncode($Jobid)
        
        $QueryArray += "jobId=$Jobid"
    }    
        
        $Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}
        $APIPath = '/system/jobs/{jobId}'
        $APIPath = $APIPath -Replace "\{Jobid\}","$Jobid" 
        Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential 
    }
    End {}
}
