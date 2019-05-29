# * ------------------------------------------------------------------------------------------------------------ 
# * File Name         : E:\Instaladores\ps1\SetupSSL.bat 
# * Author            : Edisson Giovanni Zuñiga Lopez 
# * Description       : Procedimiento configurar puerto 80 y 443  del IIS Sitio Defaul WebSite
# *                   : 27\11\2018 
# * ------------------------------------------------------------------------------------------------------------ 

param([String]$SiteName1, [String]$Protocolhtt1, [String]$PortSitehttps1)

$certRootStore = "LocalMachine"
$certStore = "My"
$certdom = "obp*"

Write-Host "------------------------------------------------------------------------------------------------------------"
Write-Host "Información de certificado instalado bpm"
Get-ChildItem cert:\$certRootStore\$certStore
Write-Host
Read-Host -Prompt  "Oprima cualquier tecla para instalar o CTRL + C para finalizar"
Get-ChildItem cert:\$certRootStore\$certStore | where { $_.Subject -match "$certdom" } | Remove-Item
Get-ChildItem cert:\$certRootStore\$certStore
Write-Host
Write-Host "Información y Estado de de Sitios de IIS"
Get-WebBinding -Name "Default Web Site"
Write-Host "------------------------------------------------------------------------------------------------------------"
Read-Host -Prompt "Finaliza desinstalación certificado"

# Remove binding form site  
Remove-WebBinding -Name $SiteName1 -Port $PortSitehttps1 -Protocol $Protocolhtt1
# Remove binding in SSLBindings store  
Get-Item IIS:\SslBindings\0.0.0.0!$PortSitehttps1 | Remove-Item  
Write-Output "Binding removed" 

#Muestra información del sitio y estadp
Get-WebBinding -Name "Default Web Site"
Get-Item IIS:\Sites
Write-Host "------------------------------------------------------------------------------------------------------------"
Read-Host -Prompt "Finaliza desinstalación certificado"