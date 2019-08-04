<#
.SYNOPSIS
    Delete an extractor
.DESCRIPTION
    Delete an extractor
    

    For more information about this cmdlet - please search for /system/inputs/{inputId}/extractors/{extractorId} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLExtractorsTerminate -Inputid <String> -Extractorid <String>
.NOTES
    Auto generated
#>
function Remove-GLExtractorsTerminate {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter inputId
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Inputid,
        # Parameter extractorId
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Extractorid,

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
        if ($PSCmdlet.ShouldProcess($Inputid,"Delete an extractor")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Inputid)) {
                $Inputid = [system.web.httputility]::UrlEncode($Inputid)

                $QueryArray += "inputId=$Inputid"
            }

            if (![string]::IsNullOrEmpty($Extractorid)) {
                $Extractorid = [system.web.httputility]::UrlEncode($Extractorid)

                $QueryArray += "extractorId=$Extractorid"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/system/inputs/{inputId}/extractors/{extractorId}'
            $APIPath = $APIPath -replace "\{Inputid\}","$Inputid"
            $APIPath = $APIPath -replace "\{Extractorid\}","$Extractorid"
            try {
                Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -ErrorAction Stop
            }
            catch {
                if ($Error[0].Exception.Response.StatusCode.value__ -eq 400) {
                    Write-Error -Exception $Error[0].Exception -Message "Invalid request." -ErrorAction $ErrorActionPreference
                }
                elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                    Write-Error -Exception $Error[0].Exception -Message "Input not found." -ErrorAction $ErrorActionPreference
                }
                elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                    Write-Error -Exception $Error[0].Exception -Message "Extractor not found." -ErrorAction $ErrorActionPreference
                }
                else {
                    Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
                }

            }

        }
    }
    end {}
}
