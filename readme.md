# PSGraylog

## Description
A Powershell Module for Graylog3 generated from it's swagger api data.

PoC-stage so a lot is going to change! Also a majority of the cmdlets is untested so take that into consideration.
But everything I've tried so far has worked.

Also, the code is not cleaned up yet and so far it's just a PoC.

But there's a lot of content already in the [docs!](docs/en-us/PSGraylog.md)

### Why not use Auto Rest?

Wanted to learn how to generate functions with Powershell code for another future project.

## Usage

### Url and credentials

Easiest way is to use `Set-GLApiConfig` and your regular graylog credentials. This will set the global variables `GLApiUrl` and `GLCredential`

``` Powershell
$MyCreds = Get-Credential

# Set global variables
Set-GLApiConfig -ApiUrl 'https://graylog.contoso.com/api' -Credential $MyCreds
```

You can also use a token:

``` Powershell
# This creates a credential object with "abcdefgh12345" as username and "token" as password.
$TokenCredential = Convert-GlTokenToCredential -Token abcdefgh12345

# Set global variables
Set-GLApiConfig -ApiUrl 'https://graylog.contoso.com/api' -Credential $TokenCredential
```
### Examples
Some rudimentary documentation is included in most cmdlets: `Get-Help Get-GLCluster`

All the `Get-GL*`-commands are pretty straight forward. And if parameters are needed they're pretty self explaining.

On my todo-list is to use the type information and such from the swagger data and refine it even more.

#### Do a simple search with `Find-GLSearchRelativeSearchRelative`

Remember that this by default only returns the first 150 messages. So here we're going to fetch the first 2000 from the last hour (3600s)

``` Powershell
$Result = Find-GLSearchRelativeSearchRelative -Query "winlogbeat_winlog_event_data_TargetUserName:waldo" -Range 3600 -Limit 2000
$Result.messages
```

#### Set and Post commands with a `-Body` parameters

The Body parameter must be a `[PSCustomObject]`
Right now the documentation on how to structure the body-object is available in your api-docs (http://your-graylog/api/api-docs)

##### `Set`-method example with `Update-GLStreamAlertConditions`

First of, we need to get the `StreamId` and `ConditionId` (done quickly using `Get-GLAlertConditionsAll`)

``` Powershell
    $StreamId = "0000000000000001"
    $ConditionId = "4cb87ce0-eaba-4b3f-ada4-a7610c4be28f"

    # Object to update the AlertCondition with
    $UpdateObject = [PSCustomObject]@{
        title = 'My Test Condition'
        type = 'messagecount'
        parameters = [PSCustomObject]@{
            query = "winlogbeat_winlog_event_data_SubjectUserName:hacker"
        }
    }

    # Update the AlertCondition
    Update-GLStreamAlertConditions -StreamId $StreamId -ConditionId $ConditionId -Body $UpdateObject
    
    # *Returns the AlertConditionObject*
```

This should be pretty universal for all Update/Set/New commands with the body parameter.


    
## About PSGraylog
A Powershell module to interact with Graylog

## Build dependencies
Install-Module psake,pester,platyps

## About Author
Author: Alex Asplund
https://automativity.com
