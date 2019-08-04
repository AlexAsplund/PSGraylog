---
external help file: PSGraylog-help.xml
Module Name: PSGraylog
online version:
schema: 2.0.0
---

# Start-GLStreamAlertsCheckConditions

## SYNOPSIS
Check for triggered alert conditions of this streams.
Results cached for 30 seconds.

## SYNTAX

```
Start-GLStreamAlertsCheckConditions [-Streamid] <String> [[-APIUrl] <String>] [[-Credential] <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
Check for triggered alert conditions of this streams.
Results cached for 30 seconds.


For more information about this cmdlet - please search for /streams/{streamId}/alerts/check in the docs available at http(s)://your-graylog.fqdn/api/api-docs

## EXAMPLES

### EXAMPLE 1
```

```

## PARAMETERS

### -Streamid
The ID of the stream to check.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
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
Position: 2
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
Position: 3
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
