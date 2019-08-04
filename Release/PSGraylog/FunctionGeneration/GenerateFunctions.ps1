param(
    [Parameter(Mandatory)]
    [string]$BaseUri,
    $OutDir = $PSScriptRoot
)
$TextInfo = (Get-Culture).TextInfo

$APIPath = ("$BaseUri" + "api")
$APIDocRoot = ("$BaseUri" + "api/api-docs/")
$DocRoot = Invoke-RestMethod -Uri $APIDocRoot




$Apis = @()
$DocRoot.apis | foreach {
    
    $Obj = (Invoke-RestMethod ($APIDocRoot + $_.Path))
    
    $APIs += [PSCustomObject]@{
        APIs    = $Obj.apis
        Context = ($_.Name -replace "[/ ]", '')
        Models  = $Obj.models.psobject.Properties.value | ? { $_.id -ne $null }
    }
    
}

# Create Model list
$ModelList = @()
$apis.models | group id | foreach { $_.group | select -first 1 } | foreach {
    $ModelList += $_
}

Function Get-GLTranslatedId($Id)
{
    $NewId = $ID -replace 'urn:.+models:', '' -replace ':', ' ' -split " " | foreach {
        if ($_ -cmatch '^[a-z0-9]')
        {
            $TextInfo.ToTitleCase($_)
        }
        else
        {
            $_
        }
    } 
    If ($NewId -match 'request')
    {
        $ModelType = "Request"
    }
    else
    {
        $ModelType = "Response"
    }
    $NewId = ($NewId | ? { $_ -notmatch '^(request|response)$' }) -join "" -creplace '[Rr]esponse[s].*|[Rr]equest[s]*', '' 
    $NewId = 'GrayLog' + ($ModelType + $NewId) -replace ' ', ''
    Return $NewId
}

$ModelList | foreach {
    
   
    
    $_ | Add-Member -MemberType NoteProperty -Name RealId -Value $_.Id -Force
    $_ | Add-Member -MemberType NoteProperty -Name Type -Value ($_.Id -split ":" | select -last 1) -Force
    $NewId = Get-GLTranslatedId -Id $_.Id
    If ($NewId -match 'request')
    {
        $ModelType = "Request"
    }
    else
    {
        $ModelType = "Response"
    }

    $_ | Add-Member -MemberType NoteProperty -Name ModelType -Value $ModelType -Force

    $_.Id = $NewId
    
}


Function Create-GLClass
{
    param(
        $ModelListObject
    )
    
    $Parameters = @()
    $OutArray = @()
    $OutArray += "Class $($ModelListObject.id) {"
    $OutArray += ""
    
    $ModelListObject.properties.psobject.Properties | Foreach {
        $ParamObject = [PSCustomObject]@{
            Name       = $_.Name
            Type       = $_.value.type
            Id         = $_.value.id
            Additional = $_.value.additional_properties.type
         
        }
        $ClassName = Get-GLFunctionType -ParamObject $ParamObject
        $Classname
        $OutArray += "    [$ClassName]`$$($ParamObject.Name)"
        $Parameters += [PSCustomObject]@{
            Class        = $ClassName
            VariableName = $ParamObject.Name
        }
    }
    $OutArray += ""
    $ParamString = $Parameters | Foreach {
        "[$($_.Class)]`$$($_.VariableName)"
    }
    
    $OutArray += "    $($ModellistObject.Id)() {}"
    $OutArray += ""
    $OutArray += "    $($ModellistObject.Id)($($ParamSTring -join ",")) {"
    $Parameters | Foreach {
        $OutArray += "        `$This.$($_.VariableName) = `$$($_.VariableName)"
    }
    $OutArray += "    }"
    $OutArray += "}"
    $Out = $OutArray -join "`n"
   
    Set-Content -Path  ".\Classes\$($ModelListObject.id).ps1" -Value $Out
    
}

$ModelList | ? { $_.ModelType -eq 'Request' } | Group id | foreach { $_.Group | Select -First 1 } | Foreach { $_.id; Create-GLClass -ModelListObject $_ }
$ClassString = ""
ls .\Classes | Foreach {
    $ClassString += cat $_.FullName -Raw 
    $ClassString += "`n"
}
rm .\Classes\Graylog*
Set-Content -Path ".\Classes\GraylogAllClasses.ps1" -Value $ClassString

$Functions = @()
rm $Outdir\* 

Write-Output "Generating functions"
Foreach ($Collection in $Apis )
{
    $Collection.APIs | ? { $_.Operations -ne $null } | foreach {

        $Functions += New-GLFunction -SwaggerObject $_ -OutDir $OutDir -Context $Collection.Context
        
    }
}
Write-Output "Beutify output"
(ls $OutDir).FullName | foreach {
    Write-Output $_
    Edit-DTWBeautifyScript -SourcePath $_ -IndentType FourSpaces -NewLine CRLF
}
 