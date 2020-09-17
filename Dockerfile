FROM microsoft/powershell:latest

COPY publish.ps1 /

ENTRYPOINT [ "/publish.ps1" ]
