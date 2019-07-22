<#
.SYNOPSIS
    Get job with the given ID
.DESCRIPTION
    Get job with the given ID
    

    For more information about this cmdlet - please search for /cluster/jobs/{jobId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLClusterJobsJob -Jobid <String>
.NOTES
    Auto generated
#>
Function Get-GLClusterJobsJob {
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
        $APIPath = '/cluster/jobs/{jobId}'
        $APIPath = $APIPath -Replace "\{Jobid\}","$Jobid" 
        $QueryString = $QueryArray -join '&'
        
        Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl+$APIPath+"?"+$QueryString) -Credential $Credential
        
    }
    End {}
}
