<#
.SYNOPSIS
    Get pipeline connections for the given stream
.DESCRIPTION
    Get pipeline connections for the given stream
    

    For more information about this cmdlet - please search for /system/pipelines/connections/{streamId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLPipelinesConnectionsPipelinesForStream -Streamid <String>
.NOTES
    Auto generated
#>
function Get-GLPipelinesConnectionsPipelinesForStream {
    [CmdletBinding()]
    param(
        # Parameter streamId
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Streamid,

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

        $QueryArray = @()
        if (![string]::IsNullOrEmpty($Streamid)) {
            $Streamid = [system.web.httputility]::UrlEncode($Streamid)

            $QueryArray += "streamId=$Streamid"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/system/pipelines/connections/{streamId}'
        $APIPath = $APIPath -replace "\{Streamid\}","$Streamid"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference

        }


    }
    end {}
}
