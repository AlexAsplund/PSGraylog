---
external help file: PSGraylog-help.xml
Module Name: PSGraylog
online version:
schema: 2.0.0
---

# Find-GLSearchKeywordFieldHistogramKeyword

## SYNOPSIS
Datetime histogram of a query using keyword timerange.

## SYNTAX

```
Find-GLSearchKeywordFieldHistogramKeyword [-Query] <String> [-Field] <String> [-Interval] <String>
 [-Keyword] <String> [[-Filter] <String>] [[-Cardinality] <Boolean>] [[-APIUrl] <String>]
 [[-Credential] <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Datetime histogram of a query using keyword timerange.


For more information about this cmdlet - please search for /search/universal/keyword/fieldhistogram in the docs available at http(s)://your-graylog.fqdn/api/api-docs

## EXAMPLES

### EXAMPLE 1
```
-Field <String> -Interval <String> -Keyword <String> -Filter <String> -Cardinality <Bool>
```

## PARAMETERS

### -Query
Query (Lucene syntax)

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

### -Field
Field of whose values to get the histogram of

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Interval
Histogram interval / bucket size.
(year, quarter, month, week, day, hour or minute)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Keyword
Range keyword

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Filter
Filter

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Cardinality
Calculate the cardinality of the field as well

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: False
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
Position: 7
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
Position: 8
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
