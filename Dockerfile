FROM microsoft/powershell:latest

WORKDIR /scripts

COPY publish.ps1 /scripts
COPY dotnet-install.sh /scripts

RUN chmod +x /scripts/publish.ps1 \
    && chmod +x /scripts/dotnet-install.sh

SHELL [ "bash", "/scripts/dotnet-install.sh" ]

ENTRYPOINT [ "pwsh", "/scripts/publish.ps1" ]
