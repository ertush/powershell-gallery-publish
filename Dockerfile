FROM microsoft/powershell:latest

COPY publish.ps1 /publish

RUN chmod +x ./publish.ps1

ENTRYPOINT [ "pwsh", "/publish.ps1" ]
