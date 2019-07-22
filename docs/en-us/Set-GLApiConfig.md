---
external help file: PSGraylog-help.xml
Module Name: PSGraylog
online version:
schema: 2.0.0
---

# Set-GLApiConfig

## SYNOPSIS
Simple function that sets the global variables "\`$Global:GLApiUrl" and "\`$Global:GLCredential"

## SYNTAX

```
Set-GLApiConfig [-APIUrl] <String> [-Credential] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
Simple function that sets the global variables "\`$Global:GLApiUrl" and "\`$Global:GLCredential"
These can also be supplied as a parameter to every command

## EXAMPLES

### EXAMPLE 1
```
Set-GLApiConfig -ApiUrl "https://graylog.domain.com/api" -Credential $MyCredential
```

Sets global variables "\`$Global:GLApiUrl" and "\`$Global:GLCredential"

### EXAMPLE 2
```
$TokenCreds = Convert-GLTokenToCredential -Token abcdefghijklmnop123
```

PS C:\\\> Set-GLApiConfig -ApiUrl "https://graylog.domain.com/api" -Credential $TokenCreds
Sets global variables "\`$Global:GLApiUrl" and "\`$Global:GLCredential" using a token as credential instead of username/password

## PARAMETERS

### -APIUrl
{{Fill APIUrl Description}}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
{{Fill Credential Description}}

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
