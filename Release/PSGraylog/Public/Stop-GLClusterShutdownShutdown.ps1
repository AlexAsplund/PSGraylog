<#
.SYNOPSIS
    Shutdown node gracefully.
.DESCRIPTION
    Shutdown node gracefully.
    Attempts to process all buffered and cached messages before exiting, shuts down inputs first to make sure that no new messages are accepted.

    For more information about this cmdlet - please search for /cluster/{nodeId}/shutdown in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Stop-GLClusterShutdownShutdown -Nodeid <String>
.NOTES
    Auto generated
#>
Function Stop-GLClusterShutdownShutdown {
    [CmdletBinding()]
    Param(
        # The id of the node to shutdown.
        [Parameter(Mandatory=$True)]
        [String]$Nodeid,

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
                $BodyHash = @{}
$QueryArray | Foreach { 
                    $val = $_ -split '='
                    $BodyHash[$val[0]] = $val[1]
                }
                $Body = $BodyHash | ConvertTo-Json
                Invoke-RestMethod -Method POST -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -Body $Body
    }
    End {}
}
