# Overview
DpiManagement is a PowerShell module for desktop DPI management. 
All commands operate with DPI measured in percents.
All commands are documented and completed with examples. 

# Installation 
You need to download DpiManagement folder to any module path specified by the environment variable:  
```
$env:PSModulePath
```

# Commands
*Get-Dpi* - gets the current DPI in percents.

*Set-Dpi* - sets the DPI, given in percents. By default this command doesn't logoff from the system, but you can use *-AutoReboot* switch parameter to force logoff. 

*Switch-Dpi* - switches DPI in the given list one-by-one based on the current DPI. This command sets DPI with *-AutoReboot* switch, so changes are applied immidiately.   

# Examples

```
> Get-Dpi
```
Gets current DPI. 

```
> Set-Dpi 150 -AutoReboot 
```
Sets DPI to 150% with auto logoff from the system.

```
> Switch-Dpi (100, 150) 
```
Switches DPI: 
a) to 150% if the current DPI is 100%; 
b) to 100% if the current DPI is 150%; 
c) to 100% if the current DPI is not 100% or 150%. 


 
