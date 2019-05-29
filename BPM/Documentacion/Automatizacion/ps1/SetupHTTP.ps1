# * ------------------------------------------------------------------------------------------------------------ 
# * File Name         : E:\Instaladores\ps1\SetupHTTP.ps1 
# * Author            : Edisson Giovanni Zuñiga Lopez 
# * Description       : Procedimiento configurar puerto 80 y 443  del IIS Sitio Defaul WebSite
# *                   : 27\11\2018 
# * ------------------------------------------------------------------------------------------------------------ 
param([String]$SiteName1, [String]$HostName1, [String]$UAPWebBrowserUrl1, [String]$SiteFolder1,  [String]$PortSitehttps1, [String]$Protocolhtt1)

$SiteName = $SiteName1
$HostName = $HostName1
$UAPWebBrowserUrl =$UAPWebBrowserUrl1
$SiteFolder = Join-Path -Path "$SiteFolder1" -ChildPath ""
$PortSitehttps = $PortSitehttps1
$Protocolhtt = $Protocolhtt1

Write-Host 'Update website' $SiteName
$IISSite = "IIS:\Sites\$SiteName"
New-WebBinding -Name $SiteName -IP "*" -Port $PortSitehttps -Protocol $Protocolhtt
if($applicationPool) { Set-ItemProperty $IISSite -name  ApplicationPool -value $IISApplicationPool }
Write-Host 
Write-Host 'Bindings Instalados en el sitio:'  $SiteName
Get-WebBinding -Name "Default Web Site"

Read-Host -Prompt "Finalizo instalación SSL, oprima cualquier tecla para continuar"