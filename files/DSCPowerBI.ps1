Configuration PowerBI
{
    param ()
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Install-Module 'PSDscResources' -Verbose -Force -AllowClobber
    Node localhost
    {
        Package PowerBIDesktop
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "https://miscstrage.blob.core.windows.net/box/pbi/PBIDesktopSetup_x64.exe?sv=2019-12-12&st=2021-01-06T00%3A00%3A00Z&se=2021-06-30T14%3A59%3A00Z&sr=b&sp=r&sig=RiUzgukukIjPj2w9gbIRPVJXk6I5SW2ZL9FcmmAYH1Q%3D"
            Name        = "PowerBI Desktop"
            ProductId   = "a9c655eb-51f1-46d2-8f8c-ecf0ba091c34"
            Arguments   = "-s -norestart ACCEPT_EULA=1"
        }
    }
}

Configuration AzureDataStudio
{
    param ()
    Node localhost
    {
        Package AzureDataStudio
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "https://miscstrage.blob.core.windows.net/box/datastudio/azuredatastudio-windows-setup-1.25.1.exe?sv=2019-12-12&st=2021-01-06T04%3A00%3A00Z&se=2021-06-30T14%3A59%3A00Z&sr=b&sp=r&sig=A6GSoVogA8nCVSvh%2BBssSBjCCw2602HoY%2BX7qDZP3iU%3D"
            Name        = "Azure Data Studio"
            ProductId   = ""
            Arguments   = "/VERYSILENT /NORESTART /MERGETASKS=!runcode /LOG=`"$env:WINDIR\\Temp\\AzureDataStudio-Install.log`""
        }
    }
}

$outputpathPBI = "$env:SYSTEMDRIVE\powerbipackage";
$outputpathDataStudio = "$env:SYSTEMDRIVE\azuredatastudiopackage";
New-Item "$outputpathPBI" -ItemType Directory;
New-Item "$outputpathDataStudio" -ItemType Directory;
PowerBI -OutputPath "$outputpathPBI";
AzureDataStudio -OutputPath "$outputpathDataStudio";
Start-DscConfiguration -Path "$outputpathPBI" -Wait -Verbose -Force
Start-DscConfiguration -Path "$outputpathDataStudio" -Wait -Verbose -Force