<#
.SYNOPSIS
    Pause message processing on node
.DESCRIPTION
    Pause message processing on node
    If the message journal is enabled, incoming messages will be spooled on disk, if it is disabled, you might lose messages from inputs which cannot buffer themselves, like AMQP or Kafka-based inputs.

    For more information about this cmdlet - please search for /cluster/{nodeId}/processing/pause in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Pause-GLClusterProcessing -Nodeid <String>
.NOTES
    Auto generated
#>
Function Pause-GLClusterProcessing {
    [CmdletBinding()]
    Param(
        # The id of the node where processing will be paused.
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
