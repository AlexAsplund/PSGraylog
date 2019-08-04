---
external help file: PSGraylog-help.xml
Module Name: PSGraylog
online version:
schema: 2.0.0
---

# Get-GLSources

## SYNOPSIS
Get a list of all sources (not more than 5000) that have messages in the current indices.
The result is cached for 10 seconds.

## SYNTAX

```
Get-GLSources [-Range] <Int32> [[-Size] <Int32>] [[-APIUrl] <String>] [[-Credential] <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
Get a list of all sources (not more than 5000) that have messages in the current indices.
The result is cached for 10 seconds.
Range: The parameter is in seconds relative to the current time.
86400 means 'in the last day',0 is special and means 'across all indices'

For more information about this cmdlet - please search for /sources in the docs available at http(s)://your-graylog.fqdn/api/api-docs

## EXAMPLES

### EXAMPLE 1
```
-Size <Int>
```

## PARAMETERS

### -Range
Relative timeframe to search in.
See method description.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Size
Maximum size of the result set.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -APIUrl
Base url for the API, normally https://\<grayloghost\>:\<port\>/api

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: $Global:GLApiUrl
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Graylog credentials as username:password or use Convert-GLTokenToCredential for token usage

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: $Global:GLCredential
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Auto generated

## RELATED LINKS
