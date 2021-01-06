Configuration PowerBITest
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
            ProductId   = "3fc9c5b9-adc8-4075-8e03-c156729596b8"
            Arguments   = "-s -norestart ACCEPT_EULA=1"
            DependsOn   = '[Package]PowerBIDesktop'
        }
        Package AzureDataStudio
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "https://miscstrage.blob.core.windows.net/box/datastudio/azuredatastudio-windows-setup-1.25.1.exe?sv=2019-12-12&st=2021-01-06T04%3A00%3A00Z&se=2021-06-30T14%3A59%3A00Z&sr=b&sp=r&sig=A6GSoVogA8nCVSvh%2BBssSBjCCw2602HoY%2BX7qDZP3iU%3D"
            Name        = "Azure Data Studio"
            ProductId   = "6591F69E-6588-4980-81ED-C8FCBD7EC4B8"
            Arguments   = "-s -norestart ACCEPT_EULA=1"
        }
    }
}
$outputpath = "$env:SYSTEMDRIVE\powerbipackage";

New-Item "$outputpath" -ItemType Directory;
PowerBITest -OutputPath "$outputpath";
Start-DscConfiguration -Path "$outputpath" -Wait -Verbose -Force