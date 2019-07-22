Function Get-GLFunctionType
{
    param($ParamObject)

    $TranslateTable = @{
        Integer = "Int"
        String  = "String"
        Boolean = "Bool"
        Array   = "Array"
        Any     = 'PSCustomObject'
        Object  = $ParamObject.Additional
    }
    
    $Return = $TranslateTable.($ParamObject.Type)
   
    if ($ParamObject.Id -ne $null)
    {
        $Return = ($ModelList | ? { $_.RealId -eq $ParamObject.Id }).id

    }

    if ($null -eq $Return)
    {
        switch -regex ($ParamObject.name)
        {
            'JSON' { $Return = 'PSCustomObject' }
        }
    }

    if ($Return -notmatch "Graylog")
    {
        if ($null -ne $ParamObject.Additional)
        {
            $Return = $TranslateTable.($ParamObject.Additional)
        }

    }

    if ($null -eq $Return)
    {
        $Return = "String"
    }
    
  
    Return $Return
}


Function New-GLFunction
{
    param(
        $SwaggerObject,
        $OutDir = $PSScriptRoot,
        $Context,
        $Models
    )
    $Prefix = "GL"
    $Operation = $SwaggerObject.Operations
    $TextInfo = (Get-Culture).TextInfo
    $Verb = $null
    # Select proper verb
    if ($Verb -eq $null -and $Operation.Method -eq 'Put')
    {
        $Verb = "Set"

    }
    Switch -regex ($Operation.nickname)
    {
        '^all' { $Verb = 'Get' }
        'revoke' { $Verb = 'Revoke' }
        'create|generate' { $Verb = 'New' }
        'delete' { $Verb = 'Remove' }
        'edit|change|save' { $Verb = "Set" }
        'list|Get' { $Verb = "Get" }
        'search|histogram|absolute' { $Verb = 'Find' }
        'update' { $Verb = 'Update' }

        
    } 
    if ($Verb -eq $null -and $Operation.Method -eq 'Get')
    {
        if ($Operation.Summary -match 'get|list')
        {
            $Verb = "Get"
        }
        if ($Operation.Summary -match 'Delete')
        {
            $Verb = "Remove"
        }
        if ($Operation.Summary -match 'Close')
        {
            $Verb = "Close"
        }
        if ($Operation.Summary -match 'Reopen')
        {
            $Verb = "Open"
        }
    }
    if ($Verb -eq $null -and $Operation.Method -ne 'Get')
    {
        if ($Operation.Summary -match 'Delete')
        {
            $Verb = "Remove"
        }
        if ($Operation.Summary -match 'Close')
        {
            $Verb = "Close"
        }
        if ($Operation.Summary -match 'Reopen')
        {
            $Verb = "Open"
        }
        if ($Operation.Summary -match '^Get')
        {
            $Verb = "Get"
        }
        if ($Operation.Summary -match 'Set')
        {
            $Verb = "Set"
        }
        if ($Operation.Summary -match 'Stop')
        {
            $Verb = "Set"
        }
        
    }
    if ($Verb -eq $null)
    {
        Switch -Regex (($Operation.nickname + $Operation.summary))
        {
            'test' { $Verb = "Test" }
            'resolve' { $Verb = "Resolve" }
            'stats' { $Verb = "Get" }
            'Download' { $Verb = "Download" }
            'Pause' { $Verb = "Pause" }
            'Send' { $Verb = "Send" }
            'Count' { $Verb = "Measure" }
            'read' { $Verb = "Get" }
            'add' { $Verb = "Add" }
            'Simulate' { $Verb = "Simulate" }
            'connect' { $Verb = "Connect" }
            'remove' { $Verb = "Remove" }
            'info' { $Verb = "Get" }
            'purge' { $Verb = "Purge" }
            'Lookup' { $Verb = "Resolve" }
            'resume' { $Verb = "Resume" }
            'Shutdown' { $Verb = "Stop" }
            'current thr' { $Verb = "Get" }
            'stat' { $Verb = "Get" }
            'Terminate' { $Verb = "Stop" }
            'validate' { $Verb = "Test" }
            'start' { $Verb = "Start" }
            'Show' { $Verb = "Get" }
            'Cycle' { $Verb = "Set" }
            'Trigger' { $Verb = "Start" }
            'clone' { $Verb = "Copy" }
            'Parse' { $Verb = "Parse" }
            'Analyze' { $Verb = "Analyze" }
            'terms|(keyword|Relative)' { $Verb = "Find" }
            'assign' { $Verb = "Set" }
            'Register' { $Verb = "Register" }
            'Copy' { $Verb = "Copy" }
            'List' { $Verb = "Get" }
            'Cancel' { $Verb = "Cancel" }
            'Hello|hello' { $Verb = "Test" }
            'Render' { $Verb = "Get" }
            'New' { $Verb = "New" }
            'Counts' { $Verb = "Get" }
            'Order' { $Verb = "Get" }
            'Install' { $Verb = "Install" }
            'Total number of messages' { $Verb = 'Get' }
        }
    }
    if ($Verb -eq $null)
    {
        Write-Warning "no verb match for $($Operation.nickname) - $($Operation.summary)"
    }

    $TranslateTable = @{
        Integer = "Int"
        String  = "String"
        Boolean = "Bool"
    }
    $Noun = ($Operation.nickname -split "") | ? { $_ -ne "" }
    $Noun[0] = $Operation.nickname.ToUpper()[0]
    $Noun = $Noun -join ""
    $Noun = $Noun -replace 'delete|remove|list|set|get|connect|Create', '' -replace "getall", 'All' -replace $Verb, ''
    $CmdletName = "$Verb-" + $Prefix + $Context + $Noun

    $ContentType = $Operation.produces

    $Parameters = @()
    
    Foreach ($Parameter in $Operation.parameters)
    {
     
        
        $ParameterObject = [PSCustomObject]@{
            Name      = ($TextInfo.ToTitleCase($Parameter.Name) -replace "JSON ", "" -replace ' ', '')
            realName  = $Parameter.Name
            HelpInfo  = $Parameter.Description
            Mandatory = $parameter.required
            Type      = (Get-GLFunctionType $Parameter)
            ParamType = $Parameter.paramType
            Models    = $Models
        }
        if ($Parameter.Name.length -eq 0 -and $Parameter.paramType -eq 'body')
        {
            $ParameterObject.Name = "Body"
            $ParameterObject.realName = "JSON Body"
        }
        $Parameters += $ParameterObject
    }
    
    $UriParameters = @()
    ($SwaggerObject.path | Select-String -Pattern "\{([a-z]+)\}" -AllMatches).matches.Groups | ? { $_.Name -eq 1 } | Foreach {
        $ParameterObject = [PSCustomObject]@{
            Name      = $TextInfo.ToTitleCase($_)
            realName  = $_
            HelpInfo  = "$_ value"
            Mandatory = $True
            Type      = "String"
            ParamType = "String"
        }
        if ([string]::IsNullOrEmpty($ParameterObject.Name))
        {
            Write-Warning ($_ | ConvertTo-Json)
        }    
        $UriParameters += $ParameterObject
    }
    
    
    # Parameter block
    $ParameterBlock = Foreach ($Parameter in ($Parameters | ? { $_ -ne $null }))
    {
        Write-Warning "Adding param $($Parameter.realname)"
        if ([string]::IsNullOrEmpty($Parameter.HelpInfo))
        {
            $Parameter.HelpInfo = "Parameter $($Parameter.realname)"
        }
        if ($Parameter.HelpInfo -match 'TimeRange')
        {
            $Parameter.Type = "DateTime"
        }
        @"
        # $($Parameter.HelpInfo)
        [Parameter(Mandatory=`$$($Parameter.Mandatory))]
        [$($Parameter.Type)]`$$($Parameter.Name),

"@
    }
    $ParameterBlock += '
        # Base url for the API, normally https://<grayloghost>:<port>/api
        [string]$APIUrl = $Global:GLApiUrl,

        # Graylog credentials as username:password or use Convert-GLTokenToCredential for token usage
        [PSCredential]$Credential = $Global:GLCredential
    '

    ############################
    
    $ScriptBlock = @()
    $ScriptBlock += ""
    $ScriptBlock += "`$QueryArray = @()"
    $Parameters | Foreach {
        $ScriptBlock += "if(![string]::IsNullOrEmpty(`$$($_.Name))){
        $(if($_.Type -eq 'string'){"`$$($_.name) = [system.web.httputility]::UrlEncode(`$$($_.name))"})
        $(if($_.Type -eq 'DateTime'){ "[string]`$$($_.Name)String = `$$($_.Name).ToUniversalTime() | Get-Date -Format 'yyyy-MM-ddTHH:mm:ss.fffZ'";$_.Name = ($_.Name+"String") })
        `$QueryArray += `"$($_.RealName)=`$$($_.Name)`"
    }    
        "
    }
    $ScriptBlock += "`$Headers = @{Accept = 'application/json';'X-Requested-By'='PSGraylog Module'}"
    $ScriptBlock += "`$APIPath = '$($SwaggerObject.Path)'"
    $UriParameters.name | Foreach {
        $ScriptBlock += "`$APIPath = `$APIPath -Replace `"\{$_\}`",`"`$$_`" "

    }
    if ($Operation.method -eq 'Get')
    {
        $ScriptBlock += "`$QueryString = `$QueryArray -join '&'"
        $ScriptBlock += ""
        $ScriptBlock += "Invoke-RestMethod -Method $($Operation.Method) -Headers `$Headers -ContentType 'application/json' -Uri (`$APIUrl+`$APIPath+`"`?`"+`$QueryString) -Credential `$Credential"
        $ScriptBlock += ""
    }
    else
    {
        if ($Operation.Method -match "put|post")
        {
            If (($Parameters | ? { $_.realName -match 'JSON Body' } | measure).count -ge 1)
            {
                Write-Warning "Body parameter found"
                $Body = "-Body (`$Body | ConvertTo-Json)"
                $CmdletName
            }
            else
            {
                $Body = "-Body `$Body"
                $Scriptblock = "`$BodyHash = @{}"
                $ScriptBlock += "`n"
                $ScriptBlock += "`$QueryArray | Foreach { 
                    `$val = `$_ -split '='
                    `$BodyHash[`$val[0]] = `$val[1]
                }
                `$Body = `$BodyHash | ConvertTo-Json
                "
            }
            
        }
        $ScriptBlock += "Invoke-RestMethod -Method $($Operation.Method) -Headers `$Headers -ContentType 'application/json' -Uri `"`$APIUrl`$APIPath`" -Credential `$Credential $Body"
    }
    $ExampleParameters = $Parameters | Foreach {
        "-" + $_.Name + " <" + $_.Type + ">"
    }
    $ExampleHelp = $CmdletName + " " + $ExampleParameters -join ' '
    $Function = @"
<#
.SYNOPSIS
    $($Operation.Summary)
.DESCRIPTION
    $($Operation.Summary)
    $(if(($Operation.Notes).length -ge 1){$Operation.Notes})

    For more information about this cmdlet - please search for $($Swaggerobject.Path) in the docs available at http(s)://your-graylog.fqdn/api/api-docs
.EXAMPLE
    $ExampleHelp
.NOTES
    Auto generated
#>
Function $($CmdletName) {
    [CmdletBinding()]
    Param(
$ParameterBlock
    )

    Begin{
        if([string]::IsNullOrEmpty(`$APIUrl)) {
            Write-Error -ErrorAction Stop -Exception "APIUrl not set" -Message "APIUrl was null or empty, refer to the documentation"
        }
        if(`$Null -eq `$Credential){
            Write-Error -ErrorAction -Exception "Credential not set" -Message "Credential not set - refer to the documentation for help"
        }
    }

    Process {
        $($ScriptBlock -replace "^","        " -join "`n")
    }
    End {}
}
"@
    $OutFile = "$OutDir\$Cmdletname.ps1"
    if (Test-Path $OutFile)
    {
        #Set-Content -Value $Function -Path "$OutDir\$Cmdletname-collide.ps1" -Encoding UTF8
        $NewFile = ($OutFile -replace '\.ps1', 'All.ps1')
        $NewCmdletName = $CmdletName + "All"

        $PathLength = (($Function | Select-String "\`$ApiPath *= *'(/.*)'").Matches.groups | ? { $_.Name -eq 1 }).Length
        $CollidedPathLength = (($OutFile | Select-String "\`$ApiPath *= *'(/.*)'").Matches.groups | ? { $_.Name -eq 1 }).length

        if ($CollidedPathLength -lt $PathLength)
        {
            mv $OutFile  $NewFile
            $NewVal = (Cat -Raw $NewFile) -replace $CmdletName, $NewCmdletName
            Set-Content -Path $NewFile -Value $NewVal
            Set-Content -Value $Function -Path "$OutDir\$Cmdletname.ps1" -Encoding UTF8
        }
        else
        {
            $CmdletName = $NewCmdletName
            Set-Content -Value $Function -Path "$OutDir\$Cmdletname.ps1" -Encoding UTF8    
        }
    }   
    else
    {
        Set-Content -Value $Function -Path "$OutDir\$Cmdletname.ps1" -Encoding UTF8
    }
    
}