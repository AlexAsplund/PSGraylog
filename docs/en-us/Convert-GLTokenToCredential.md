---
external help file: PSGraylog-help.xml
Module Name: PSGraylog
online version:
schema: 2.0.0
---

# Convert-GLTokenToCredential

## SYNOPSIS
Converts graylog token to \[PSCredential\]

## SYNTAX

```
Convert-GLTokenToCredential [-Token] <String> [<CommonParameters>]
```

## DESCRIPTION
Converts graylog token to \[PSCredential\] by setting token as username and "token" as password.

## EXAMPLES

### EXAMPLE 1
```
Convert-GLTokenToCredential -Token $Key
```

Returns a \[PSCredential\] object

## PARAMETERS

### -Token
{{Fill Token Description}}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
