# Install description

``` powershell

    Invoke-RestMethod https://github.com/AlexAsplund/PSGraylog/releases/download/0.0.3/PSGraylog-0.0.3.zip -OutFile .\PSGraylog-0.0.3.zip
    Expand-Archive -Path .\PSGraylog-0.0.3.zip -DestinationPath <your module dir>

```