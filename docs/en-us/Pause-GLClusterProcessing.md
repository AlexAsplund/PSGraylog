---
external help file: PSGraylog-help.xml
Module Name: PSGraylog
online version:
schema: 2.0.0
---

# Pause-GLClusterProcessing

## SYNOPSIS
Pause message processing on node

## SYNTAX

```
Pause-GLClusterProcessing [-Nodeid] <String> [[-APIUrl] <String>] [[-Credential] <PSCredential>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Pause message processing on node
If the message journal is enabled, incoming messages will be spooled on disk, if it is disabled, you might lose messages from inputs which cannot buffer themselves, like AMQP or Kafka-based inputs.

For more information about this cmdlet - please search for /cluster/{nodeId}/processing/pause in the docs available at http(s)://your-graylog.fqdn/api/api-docs

## EXAMPLES

### EXAMPLE 1
```

```

## PARAMETERS

### -Nodeid
The id of the node where processing will be paused.

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
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
