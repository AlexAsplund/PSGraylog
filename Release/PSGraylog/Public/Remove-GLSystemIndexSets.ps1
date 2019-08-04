<#
.SYNOPSIS
    Delete index set
.DESCRIPTION
    Delete index set
    

    For more information about this cmdlet - please search for /system/indices/index_sets/{id} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLSystemIndexSets -Id <String> -Delete_Indices <Bool>
.NOTES
    Auto generated
#>
function Remove-GLSystemIndexSets {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter id
        [Parameter(Mandatory = $True,ValueFromPipelineByPropertyName = $true)]
        [string]$Id,
        # Parameter delete_indices
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [bool]$Delete_Indices,

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
        if ($PSCmdlet.ShouldProcess($Id,"Delete index set")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Id)) {
                $Id = [system.web.httputility]::UrlEncode($Id)

                $QueryArray += "id=$Id"
            }

            if (![string]::IsNullOrEmpty($Delete_Indices)) {


                $QueryArray += "delete_indices=$Delete_Indices"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/system/indices/index_sets/{id}'
            $APIPath = $APIPath -replace "\{Id\}","$Id"
            try {
                Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -ErrorAction Stop
            }
            catch {
                if ($Error[0].Exception.Response.StatusCode.value__ -eq 403) {
                    Write-Error -Exception $Error[0].Exception -Message "Unauthorized" -ErrorAction $ErrorActionPreference
                }
                elseif ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                    Write-Error -Exception $Error[0].Exception -Message "Index set not found" -ErrorAction $ErrorActionPreference
                }
                else {
                    Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
                }

            }

        }
    }
    end {}
}
