---
external help file: PSGraylog-help.xml
Module Name: PSGraylog
online version:
schema: 2.0.0
---

# Send-GLHelloWorldRedirectToWebConsole

## SYNOPSIS
Redirecting to web console if it runs on same port.

## SYNTAX

```
Send-GLHelloWorldRedirectToWebConsole [[-APIUrl] <String>] [[-Credential] <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Redirecting to web console if it runs on same port.


For more information about this cmdlet - please search for  in the docs available at http(s)://your-graylog.fqdn/api/api-docs

## EXAMPLES

### EXAMPLE 1
```
Send-GLHelloWorldRedirectToWebConsole
```

## PARAMETERS

### -APIUrl
Base url for the API, normally https://\<grayloghost\>:\<port\>/api

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
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
Position: 2
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
