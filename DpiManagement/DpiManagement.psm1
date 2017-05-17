<#
.Synopsis
    Gets current screen DPI in percents. 
#>
function Get-Dpi {
    Get-DpiRegistryPath | Set-Location
    $val = Get-ItemProperty -Path . -Name "LogPixels"
    $val.LogPixels | Convert-DpiPixelsToPercentage
}

<#
.Synopsis
   Sets screen DPI (given in percents). By default this command doesn't logoff from the system. 
.EXAMPLE
   Set-Dpi 150 
   Sets screen DPI to 150% without reboot.
.EXAMPLE
   Set-Dpi 200 -AutoReboot
   Sets screen DPI to 200% with automatic reboot.
#>
function Set-Dpi {
    param (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [System.Int32]
        $Percentage, 

        [switch]
        $AutoReboot 
    )

    Write-Host $Percentage
    Write-Host $AutoReboot

    $pixels = Convert-DpiPercentageToPixels $Percentage
    Get-DpiRegistryPath | Set-Location
    Set-ItemProperty -Path . -Name LogPixels -Value $pixels

    if ($AutoReboot) {
        logoff;exit
    }
}

<#
.Synopsis
   Switches screen DPI according to current DPI and the given set of DPI. 
.DESCRIPTION
   With this command you can rotate DPI from the desired list of DPI. The command takes current DPI and looks for it in the list. 
   If current DPI is found, the command sets the next DPI from the list.  
   If current DPI is last in the list, the command starts from the beginning of the list. 
   If current DPI is not in the list, the command sets the first DPI in the list.  
.EXAMPLE
    Switch-Dpi (100, 150, 200) 
    If current DPI is 100%, then it will be set to 150% DPI. 
    If current DPI is 150%, then it will be set to 200% DPI. 
    If current DPI is 200%, then it will be set to 100% DPI. 
    If current DPI is 250%, then it will be set to 100% DPI. 
#>
function Switch-Dpi {
    param (
        [int[]]
        $DpiSet 
    )

    $percentage = Get-Dpi  
    $currentDpiIndex = $DpiSet.IndexOf($percentage) 
    $nextDpiIndex = 0
    if ($currentDpiIndex -ige 0) {
        $nextDpiIndex = $currentDpiIndex + 1
    }

    if ($nextDpiIndex -ige $DpiSet.Count) {
       $nextDpiIndex = 0 
    }

    $nextDpi = $DpiSet[$nextDpiIndex]
    Write-Host $nextDpi
    Set-Dpi $nextDpi -AutoReboot
}

<#
.Synopsis
   Gets location of DPI settings in the registry. 
#>
function Get-DpiRegistryPath {
    'HKCU:\Control Panel\Desktop'
}

<#
.Synopsis
   Converts DPI in percents to DPI in pixels. 
.EXAMPLE
    Convert-DpiPercentageToPixels 150    
    Gets value for DPI 150%, measured in pixels.
#>
function Convert-DpiPercentageToPixels {
    [OutputType([int])]
    param (
        [Parameter(Position=0, Mandatory=$true,ValueFromPipeline=$true)]
        [int]
        $Percentage 
    )
    [int][System.Math]::Round($Percentage * 0.96);
}


<#
.Synopsis
   Converts DPI in pixels to DPI in percents. 
.EXAMPLE
    Convert-DpiPixelsToPercentage 96    
    Gets value for DPI 96 pixels.
#>
function Convert-DpiPixelsToPercentage {
    [OutputType([int])]
    param (
        [Parameter(Position=0, Mandatory=$true,ValueFromPipeline=$true)]
        [int]
        $Pixels
    )
    [int][System.Math]::Round($Pixels * 100 / 96);
}


