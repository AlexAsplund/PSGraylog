<#
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
function Cancel-GLSystemJobs {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter jobId
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Jobid,

        # Base url for the API, normally https://<grayloghost>:<port>/api
        [string]$APIUrl = $Global:GLApiUrl,

        # Graylog credentials as username:password or use Convert-GLTokenToCredential for token usage
        [pscredential]$Credential = $Global:GLCredential

    )

    begin {
        if ([string]::IsNullOrEmpty($APIUrl)) {
            Write-Error -ErrorAction Stop -Exception "APIUrl not set" -Message "APIUrl was null or empty, refer to the documentation"
        }
        if ($Null -eq $Credential) {
            Write-Error -ErrorAction Stop -Exception "Credential not set" -Message "Credential not set - refer to the documentation for help"
        }
    }

    process {
        if ($PSCmdlet.ShouldProcess($Jobid,"Cancel running job")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Jobid)) {
                $Jobid = [system.web.httputility]::UrlEncode($Jobid)

                $QueryArray += "jobId=$Jobid"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/system/jobs/{jobId}'
            $APIPath = $APIPath -replace "\{Jobid\}","$Jobid"
            try {
                Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -ErrorAction Stop
            }
            catch {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference

            }

        }
    }
    end {}
}
