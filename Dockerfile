# escape=`
# Set Gauge API timeout to 60s for big project need more time to do dotnet restore.
ARG GAUGE_TIMEOUT=60000

# Get Nodejs
FROM mcr.microsoft.com/powershell:nanoserver-1809 AS downloadnodejs
SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop';$ProgressPreference='silentlyContinue';"]
RUN Invoke-WebRequest -OutFile nodejs.zip -UseBasicParsing "https://nodejs.org/dist/v10.16.3/node-v10.16.3-win-x64.zip"; `
Expand-Archive nodejs.zip -DestinationPath C:\; `
Rename-Item "C:\node-v10.16.3-win-x64" c:\nodejs

# Start to setup DS_AUT Automation Testing Environment
FROM mcr.microsoft.com/dotnet/core/sdk:2.1 AS build

# Set Environment Variables
USER ContainerAdministrator
RUN setx /M PATH "%PATH%;C:\nodejs"

USER ContainerUser
# Install Gauge & Plugins
COPY --from=downloadnodejs C:\nodejs\ C:\nodejs
RUN npm install -g @getgauge/cli@1.0.8
COPY gauge-dotnet-1.1.4.zip .
RUN gauge install dotnet -f .\gauge-dotnet-1.1.4.zip
RUN gauge install html-report 
RUN gauge install screenshot
RUN gauge config runner_connection_timeout %GAUGE_TIMEOUT%


