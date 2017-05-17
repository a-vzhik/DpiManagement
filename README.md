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
**Get-Dpi** - gets the current DPI in percents.

**Set-Dpi** - sets the DPI, given in percents. By default this command doesn't logoff from the system, but you can use *-AutoReboot* switch parameter to force logoff. 

**Switch-Dpi** - switches DPI in the given list one-by-one based on the current DPI. This command sets DPI with *-AutoReboot* switch, so changes are applied immidiately.   

**Convert-DpiPixelsToPercentage** - converts DPI measured in pixels to DPI measured in percents.

**Convert-DpiPercentageToPixels** - converts DPI measured in percents to DPI measured in pixels.

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
- to 150% if the current DPI is 100%; 
- to 100% if the current DPI is 150%; 
- to 100% if the current DPI is not 100% or 150%. 


 
