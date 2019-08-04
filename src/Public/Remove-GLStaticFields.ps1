<#
.SYNOPSIS
    Remove static field of an input
.DESCRIPTION
    Remove static field of an input
    

    For more information about this cmdlet - please search for /system/inputs/{inputId}/staticfields/{key} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLStaticFields -Key <String> -Inputid <String>
.NOTES
    Auto generated
#>
function Remove-GLStaticFields {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter Key
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Key,
        # Parameter inputId
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Inputid,

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
        if ($PSCmdlet.ShouldProcess($Key,"Remove static field of an input")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Key)) {
                $Key = [system.web.httputility]::UrlEncode($Key)

                $QueryArray += "Key=$Key"
            }

            if (![string]::IsNullOrEmpty($Inputid)) {
                $Inputid = [system.web.httputility]::UrlEncode($Inputid)

                $QueryArray += "inputId=$Inputid"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/system/inputs/{inputId}/staticfields/{key}'
            $APIPath = $APIPath -replace "\{Inputid\}","$Inputid"
            $APIPath = $APIPath -replace "\{Key\}","$Key"
            try {
                Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -ErrorAction Stop
            }
            catch {
                if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                    Write-Error -Exception $Error[0].Exception -Message "No such input on this node." -ErrorAction $ErrorActionPreference
                }
                elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                    Write-Error -Exception $Error[0].Exception -Message "No such static field." -ErrorAction $ErrorActionPreference
                }
                else {
                    Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
                }

            }

        }
    }
    end {}
}
