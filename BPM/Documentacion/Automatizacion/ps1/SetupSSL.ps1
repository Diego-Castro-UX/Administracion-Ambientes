# * ------------------------------------------------------------------------------------------------------------ 
# * File Name         : E:\Instaladores\ps1\SetupSSL.bat 
# * Author            : Edisson Giovanni Zuñiga Lopez 
# * Description       : Procedimiento configurar puerto 80 y 443  del IIS Sitio Defaul WebSite
# *                   : 27\11\2018 
# * ------------------------------------------------------------------------------------------------------------ 
param([String]$SiteName1, [String]$HostName1, [String]$pfxPass1, [String]$UAPWebBrowserUrl1, [String]$SiteFolder1, [String]$certPath1, [String]$Thumbprin2, [String]$PortSitehttps1, [String]$Protocolhtt1)

$SiteName = $SiteName1
$HostName = $HostName1
$pfxPass = $pfxPass1
$UAPWebBrowserUrl =$UAPWebBrowserUrl1
$SiteFolder = Join-Path -Path "$SiteFolder1" -ChildPath ""
$certPath = $certPath1
$PortSitehttps = $PortSitehttps1
$Protocolhtt = $Protocolhtt1
$certRootStore = "LocalMachine"
$certStore = "My"
$certdom = "obp*"
			
	Write-Host
	Write-Host "------------------------------------------------------------------------------------------------------------"
	Write-Host -Object "Certificado que se va a instalar: $Thumbprin2"
	Write-Host
	$Thumbprint = (Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object {$_.Subject -match "$certdom"}).Thumbprint;
	
	if ($Thumbprint -eq $Thumbprin2)  
	{
		Write-Host -Object "El certificado ya se encuentra instalado:"
		Write-Host
		Get-ChildItem cert:\$certRootStore\$certStore
		Write-Host $certRootStore
		Read-Host -Prompt "Inicia asignación ssl al puerto"
		
		Write-Host 'Update website' $SiteName
		$IISSite = "IIS:\Sites\$SiteName"
		New-WebBinding -Name $SiteName -IP "*" -Port $PortSitehttps -Protocol $Protocolhtt
		if($applicationPool) { Set-ItemProperty $IISSite -name  ApplicationPool -value $IISApplicationPool }
		Write-Host 
		Write-Host 'Bindings Instalados en el sitio:'  $SiteName
		Write-Host
		Get-WebBinding -Name "Default Web Site"
		Write-Host
		Write-Host 'Configuración certificado ssl:'  $SiteName
		Get-ChildItem cert:\$certRootStore\$certStore | where { $_.Subject -match "$certdom" } | select -First 1 | New-Item IIS:\SslBindings\0.0.0.0!$PortSitehttps
		
	} else {
				Read-Host -Prompt "El certificado no esta instalado. Oprima cualquier tecla para continuar"
				Write-Host "------------------------------------------------------------------------------------------------------------"
				Write-Host 'Import pfx certificate' $certPath
							$pfx = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
							$pfx.import($certPath,$pfxPass,“Exportable,MachineKeySet,PersistKeySet”)
							$store = New-Object System.Security.Cryptography.X509Certificates.X509Store($certStore,$certRootStore) 
							$store.Open('ReadWrite')
							$store.Add($pfx) 
							$store.Close() 
							$certThumbprint = $pfx.Thumbprint
							Get-ChildItem cert:\$certRootStore\$certStore
				Write-Host "------------------------------------------------------------------------------------------------------------"
				Write-Host
				Write-Host "Finalizo instalación SSL"
				Read-Host -Prompt "Inicia asignación ssl al puerto, oprima cualquier tecla para continuar"
				Write-Host "------------------------------------------------------------------------------------------------------------"
				Write-Host 'Update website' $SiteName
							$IISSite = "IIS:\Sites\$SiteName"
							New-WebBinding -Name $SiteName -IP "*" -Port $PortSitehttps -Protocol $Protocolhtt
							if($applicationPool) { Set-ItemProperty $IISSite -name  ApplicationPool -value $IISApplicationPool }
				Write-Host 
				Write-Host 'Bindings Instalados en el sitio:'  $SiteName
							Write-Host "------------------------------------------------------------------------------------------------------------"
							Write-Host
							Get-WebBinding -Name "Default Web Site"
							Write-Host "------------------------------------------------------------------------------------------------------------"
				Write-Host 'Configuración certificado ssl:'  $SiteName
							$certRootStore = "LocalMachine"
							$certStore = "My"
							Get-ChildItem cert:\$certRootStore\$certStore | where { $_.Subject -match "$certdom" } | select -First 1 | New-Item IIS:\SslBindings\0.0.0.0!$PortSitehttps
				Write-Host "------------------------------------------------------------------------------------------------------------"
			}

	Read-Host -Prompt "Finalizo instalación SSL, oprima cualquier tecla para continuar"