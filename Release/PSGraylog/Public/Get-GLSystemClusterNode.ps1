<#
.SYNOPSIS
    Information about a node.
.DESCRIPTION
    Information about a node.
    This is returning information of a node in context to its state in the cluster. Use the system API of the node itself to get system information.

    For more information about this cmdlet - please search for /system/cluster/nodes/{nodeId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Get-GLSystemClusterNode -Nodeid <String>
.NOTES
    Auto generated
#>
function Get-GLSystemClusterNode {
    [CmdletBinding()]
    param(
        # Parameter nodeId
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Nodeid,

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
        if (![string]::IsNullOrEmpty($Nodeid)) {
            $Nodeid = [system.web.httputility]::UrlEncode($Nodeid)

            $QueryArray += "nodeId=$Nodeid"
        }

        $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
        $APIPath = '/system/cluster/nodes/{nodeId}'
        $APIPath = $APIPath -replace "\{Nodeid\}","$Nodeid"
        $QueryString = $QueryArray -join '&'

        try {
            Invoke-RestMethod -Method GET -Headers $Headers -ContentType 'application/json' -Uri ($APIUrl + $APIPath + "?" + $QueryString) -Credential $Credential -ErrorAction Stop
        }
        catch {
            if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                Write-Error -Exception $Error[0].Exception -Message "Node not found." -ErrorAction $ErrorActionPreference
            }
            else {
                Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
            }

        }


    }
    end {}
}
