Configuration PowerBI
{
    param ()
    Node localhost
    {
        Package PowerBIDesktop
        {
            Ensure      = "Present"  # You can also set Ensure to "Absent"
            Path        = "https://miscstrage.blob.core.windows.net/box/pbi/PBIDesktopSetup_x64.exe?sv=2020-04-08&st=2021-03-22T04%3A11%3A04Z&se=2021-06-30T14%3A59%3A00Z&sr=b&sp=r&sig=Tio9OfbJNvboMoThh6WACkTHED7%2FrExuowC4hEn9gSg%3D"
            Name        = "PowerBI Desktop"
            ProductId   = "8eaa61ad-7258-469f-8243-b88fa415e9f5"
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
            Path        = "https://miscstrage.blob.core.windows.net/box/datastudio/azuredatastudio-windows-setup-1.26.1.exe?sv=2020-04-08&st=2021-03-22T04%3A11%3A37Z&se=2021-06-30T14%3A59%3A00Z&sr=b&sp=r&sig=U4xaOMtcdjIm1030zvosnJ4r0Lgj%2FyTVm0nf8yh2%2B3Y%3D"
            Name        = "Azure Data Studio"
            ProductId   = ""
            Arguments   = "/VERYSILENT /NORESTART /MERGETASKS=!runcode /LOG=`"$env:WINDIR\\Temp\\AzureDataStudio-Install.log`""
        }
    }
}
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.208 -Force
Install-Module -Name PSDscResources -Verbose -Force -AllowClobber
$outputpathPBI = "$env:SYSTEMDRIVE\powerbipackage";
$outputpathDataStudio = "$env:SYSTEMDRIVE\azuredatastudiopackage";
New-Item "$outputpathPBI" -ItemType Directory;
New-Item "$outputpathDataStudio" -ItemType Directory;
PowerBI -OutputPath "$outputpathPBI";
AzureDataStudio -OutputPath "$outputpathDataStudio";
Start-DscConfiguration -Path "$outputpathPBI" -Wait -Verbose -Force
Start-DscConfiguration -Path "$outputpathDataStudio" -Wait -Verbose -Force