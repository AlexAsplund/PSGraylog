<#
.SYNOPSIS
    Test existing alert condition
.DESCRIPTION
    Test existing alert condition
    

    For more information about this cmdlet - please search for /streams/{streamId}/alerts/conditions/{conditionId}/test in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Test-GLStreamAlertConditionsExisting -Streamid <String> -Conditionid <String>
.NOTES
    Auto generated
#>
Function Test-GLStreamAlertConditionsExisting {
    [CmdletBinding()]
    Param(
        # The stream ID this alert condition belongs to.
        [Parameter(Mandatory=$True)]
        [String]$Streamid,
         # The alert condition ID to be fetched
        [Parameter(Mandatory=$True)]
        [String]$Conditionid,
 
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
