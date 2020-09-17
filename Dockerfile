FROM microsoft/powershell:latest

WORKDIR /scripts
COPY publish.ps1 /scripts

RUN chmod +x /scripts/publish.ps1

ENTRYPOINT [ "pwsh", "/scripts/publish.ps1" ]
