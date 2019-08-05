<#
.SYNOPSIS
    Get a single message.
.DESCRIPTION
    Get a single message.


    For more information about this cmdlet - please search for /messages/{index}/{messageId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Find-GLMessagesSearch -Index <String> -Messageid <String>
.NOTES
    Auto generated
#>
function Find-GLMessagesSearch {
    [CmdletBinding()]
    param(
        # The index this message is stored in.
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Index,
        # Parameter messageId
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Messageid,

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
        if (![string]::IsNullOrEmpty($Index)) {
            $Index = [system.web.httputility]::UrlEncode($Index)

            $QueryArray += "index=$Index"
        }

        if (![string]::IsNullOrEmpty($Messageid)) {
            $Messageid = [system.web.httputility]::UrlEncode($Messageid)

            $QueryArray += "messageId=$Messageid"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/messages/{index}/{messageId}'
        $APIPath = $APIPath -replace "\{Index\}","$Index"
        $APIPath = $APIPath -replace "\{Messageid\}","$Messageid"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                Write-Error -Exception $Error[0].Exception -Message "Specified index does not exist." -ErrorAction $ErrorActionPreference
            }
            elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                Write-Error -Exception $Error[0].Exception -Message "Message does not exist." -ErrorAction $ErrorActionPreference
            }
            else {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
            }

        }


    }
    end {}
}
