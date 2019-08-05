<#
.SYNOPSIS
    Delete a notification
.DESCRIPTION
    Delete a notification


    For more information about this cmdlet - please search for /system/notifications/{notificationType} in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    Remove-GLSystemNotificationsNotification -Notificationtype <String>
.NOTES
    Auto generated
#>
function Remove-GLSystemNotificationsNotification {
    [CmdletBinding(SupportsShouldProcess,ConfirmImpact = 'Medium')]
    param(
        # Parameter notificationType
        [Parameter(Mandatory = $False,ValueFromPipelineByPropertyName = $true)]
        [string]$Notificationtype,

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
        if ($PSCmdlet.ShouldProcess($Notificationtype,"Delete a notification")) {
            $QueryArray = @()
            if (![string]::IsNullOrEmpty($Notificationtype)) {
                $Notificationtype = [system.web.httputility]::UrlEncode($Notificationtype)

                $QueryArray += "notificationType=$Notificationtype"
            }

            $Headers = @{ Accept = 'application/json'; 'X-Requested-By' = 'PSGraylog Module' }
            $APIPath = '/system/notifications/{notificationType}'
            $APIPath = $APIPath -replace "\{Notificationtype\}","$Notificationtype"
            try {
                Invoke-RestMethod -Method DELETE -Headers $Headers -ContentType 'application/json' -Uri "$APIUrl$APIPath" -Credential $Credential -ErrorAction Stop
            }
            catch {
                if ($Error[0].Exception.Response.StatusCode.value__ -eq 404) {
                    Write-Error -Exception $Error[0].Exception -Message "No such notification type." -ErrorAction $ErrorActionPreference
                }
                else {
                    Write-Error -Exception $Error[0].Exception -Message $Error[0].Message -ErrorAction $ErrorActionPreference
                }

            }

        }
    }
    end {}
}
