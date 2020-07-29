# gauge-dotnet-win
Gauge with customized dotnet plugin, which can be used to run gauge tests for dotnet.

# Included
* dotnet core 2.1
* Gauge: 1.0.8
* gague-dotnet-plugin: 1.1.4 (customized - to solve Gauge dotnet plugin [can not load assembly System.Data.SqlClient problem](https://github.com/getgauge/gauge-dotnet/issues/80))

# Example Usage
## Command Line
* Go to the root folder of the automation test project.
* Open Powershell under the folder, run 
```
docker run --rm -v ${PWD}:"C:\workspace" -w "C:\workspace\" jenniferz79/gaugedotnetwin gauge.cmd run specs\WebServiceTest.spec
```
## Interactive mode
* Go to the root folder of the automation test project.
* Open Powershell under the folder, run 
```
docker run -it -v ${PWD}:"C:\workspace" -w "C:\workspace\" jenniferz79/gaugedotnetwin
```
* A container will be created in interactive mode. You can run gauge command to run test in the PowerShell terminal. e.g.
```
gauge run specs\WebService.spec
```